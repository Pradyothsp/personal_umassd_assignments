import random

from mpi4py import MPI

from utils import toss

comm = MPI.COMM_WORLD
rank = comm.rank

N = 10  # Number of grid points
OBJ = ['A', 'B', 'C', 'D', 'E', 'F']
M = 1

# Creating dict of size N (from 1 to N+1) to store positions
OBJ_POS = {i: set() for i in range(N + 1)}


def init_pos(obj_: str) -> bool:
    pos_ = random.choice(range(1, N + 1))
    OBJ_POS[pos_] = OBJ_POS[pos_].union(set(obj_))
    return True


# Initializing OBJ positions
_ = [init_pos(obj_=obj) for obj in OBJ]

# Dividing OBJ_POS into 2 dict for 2 cores
OBJS_1 = dict()
OBJS_2 = dict()

_ = [OBJS_1.update({key: value}) if key <= N / 2 else OBJS_2.update({key: value}) for key, value in OBJ_POS.items()]


for i in range(M):
    comm.barrier()

    if rank == 0:
        comm.barrier()
        temp_dict = dict()  # For updating the OBJS_1 after each iteration

        for k, v in OBJS_1.items():
            if len(v) == 0:
                continue

            for val in v:
                flip = toss()  # Will be "H" or "T"

                if flip == 'H':
                    if temp_dict.get(k + 1):
                        temp_dict[k + 1] = temp_dict[k + 1].union(set(val))
                    else:
                        temp_dict[k + 1] = set(val)

                else:
                    if temp_dict.get(k - 1):
                        temp_dict[k - 1] = temp_dict[k - 1].union(set(val))
                    else:
                        temp_dict[k - 1] = set(val)

            OBJS_1[k] = set()

        # comm.barrier()
        if temp_dict.get(6) or temp_dict.get(0):
            comm.send(temp_dict, dest=1, tag=101)
            print('Msg sent from rank 0 to rank 1')

            try:
                del temp_dict[6]
                del temp_dict[0]

            except KeyError:
                del temp_dict[0]

            finally:
                pass

        else:
            comm.send(None, dest=1, tag=101)
            print('Msg sent from rank 0 to rank 1  is None')

        comm.barrier()
        data_rec = comm.recv(source=1, tag=110)

        # OBJS_1.clear()  # Reset the dictionary

        if data_rec is not None:
            if data_rec.get(11):
                data_rec[1] = data_rec[11]
                del data_rec[11]

            # Combining 2 dictionaries with same keys, here I am updating OBJS_2 from temp_dict.
            for k1, v1 in temp_dict.items():
                if data_rec.get(k1):
                    OBJS_1[k1] = data_rec[k1].union(v1)

                else:
                    OBJS_1[k1] = v1

        else:
            for key_, value_ in temp_dict.items():
                OBJS_1[key_] = value_

        print(f"OBJ_1: {OBJS_1}, after iteration {i + 1}")

    if rank == 1:
        comm.barrier()
        temp_dict = dict()  # For updating the OBJS_1 after each iteration

        for k, v in OBJS_2.items():
            if len(v) == 0:
                continue

            for val in v:
                flip = toss()  # Will be "H" or "T"

                if flip == 'H':
                    if temp_dict.get(k + 1):
                        temp_dict[k + 1] = temp_dict[k + 1].union(set(val))
                    else:
                        temp_dict[k + 1] = set(val)

                else:
                    if temp_dict.get(k - 1):
                        temp_dict[k - 1] = temp_dict[k - 1].union(set(val))
                    else:
                        temp_dict[k - 1] = set(val)

                OBJS_2[k] = set()

        # comm.barrier()
        if temp_dict.get(5) or temp_dict.get(11):
            comm.send(temp_dict, dest=0, tag=110)
            print('Msg sent from rank 1 to rank 0')

            try:
                del temp_dict[5]
                del temp_dict[11]

            except KeyError:
                del temp_dict[11]

            finally:
                pass

        else:
            comm.send(None, dest=1, tag=110)
            print('Msg sent from rank 1 to rank 0  is None')

        comm.barrier()
        data_rec = comm.recv(source=0, tag=101)

        # OBJS_2.clear()  # Reset the dictionary

        if data_rec is not None:
            if data_rec.get(0):
                data_rec[10] = data_rec[0]
                del data_rec[0]

            # Combining 2 dictionaries with same keys, here I am updating OBJS_2 from temp_dict.
            for k1, v1 in temp_dict.items():
                if data_rec.get(k1):
                    OBJS_2[k1] = data_rec[k1].union(v1)

                else:
                    OBJS_2[k1] = v1

        else:
            for key_, value_ in temp_dict.items():
                OBJS_2[key_] = value_

        print(f"OBJ_2: {OBJS_2}, after iteration {i + 1}")

# print(f"OBJ_1: {OBJS_1}, after final")
# print(f"OBJ_2: {OBJS_2}, after final")
