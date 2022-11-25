import random

from mpi4py import MPI

comm = MPI.COMM_WORLD
rank = comm.rank

N = 10  # Number of grid points
OBJ = ['A', 'B', 'C', 'D', 'E', 'F']
M = 1

OBJ_POS = dict()


def f(i: int) -> bool:
    OBJ_POS[i] = set()
    return True


def init_pos(obj_: str) -> bool:
    pos_ = random.choice(range(1, 11))
    OBJ_POS[pos_] = OBJ_POS[pos_].union(set(obj_))
    return True


# Creating dict of size N to store positions
_ = [f(i) for i in range(1, N + 1)]

# Initializing OBJ positions
_ = [init_pos(obj_=obj) for obj in OBJ]

# Dividing OBJ_POS into 2 dict for 2 cores
OBJS_1 = dict()
OBJS_2 = dict()

_ = [OBJS_1.update({key: value}) if key <= N / 2 else OBJS_2.update({key: value}) for key, value in OBJ_POS.items()]

print(OBJ_POS)


def toss():
    return random.choice(['H', 'T'])


for i in range(M):
    comm.barrier()

    if rank == 0:
        temp_dict = dict() # For updating the OBJS_1 after each iteration

        for k, v in OBJS_2.items():
            if len(v) == 0:
                continue

            for val in v:
                flip = toss()  # Will be "H" or "T"

                if flip == 'H':
                    try:
                        temp_dict[k + 1] = temp_dict[k + 1].union(set(val))
                    except KeyError:
                        temp_dict[k + 1] = set(val)

                else:
                    try:
                        temp_dict[k - 1] = temp_dict[k - 1].union(set(val))
                    except KeyError:
                        temp_dict[k - 1] = set(val)

        if temp_dict.get(6) or temp_dict.get(0):
            comm.send(temp_dict, dest=1, tag=101)
            print('Msg sent from rank 0 to rank 1')
            del temp_dict[6]
            del temp_dict[0]

        else:
            comm.send(None, dest=1, tag=101)
            print('Msg sent from rank 0 to rank 1  is None')

        comm.barrier()
        data_rec = comm.recv(source=1, tag=110)

        # Change keys accordingly. Since it is cyclic, I am changing key 11 to 1.
        if data_rec is not None:
            for k, v in data_rec.items():
                if k == 11:
                    del data_rec[k]
                    data_rec[1] = v

            # Combining 2 dictionaries with same keys, here I am updating OBJS_2 from temp_dict.
            for key_1, value_1 in temp_dict.items():
                for key_2, value_2 in data_rec.items():
                    if key_1 == key_2:
                        OBJS_2[key_1] = value_1.union(value_2)

        else:
            for key_, value_ in temp_dict.items():
                OBJS_2[key_] = set(value_)

        print(OBJS_2)

    if rank == 1:
        temp_dict = dict()  # For updating the OBJS_2 after each iteration

        for k, v in OBJS_2.items():
            if len(v) == 0:
                continue

            for val in v:
                flip = toss()  # Will be "H" or "T"

                if flip == 'H':
                    try:
                        temp_dict[k + 1] = temp_dict[k + 1].union(set(val))
                    except KeyError:
                        temp_dict[k + 1] = set(val)

                else:
                    try:
                        temp_dict[k - 1] = temp_dict[k - 1].union(set(val))
                    except KeyError:
                        temp_dict[k - 1] = set(val)

        if temp_dict.get(6) or temp_dict.get(0):
            comm.send(temp_dict, dest=1, tag=101)
            print('Msg sent from rank 0 to rank 1')
            del temp_dict[6]
            del temp_dict[0]

        else:
            comm.send(None, dest=1, tag=110)
            print('Msg sent from rank 0 to rank 1  is None')

        comm.barrier()
        data_rec = comm.recv(source=1, tag=101)

        # Change keys accordingly. Since it is cyclic, I am changing key 11 to 1.
        if data_rec is not None:
            for k, v in data_rec.items():
                if k == 11:
                    del data_rec[k]
                    data_rec[1] = v

            # Combining 2 dictionaries with same keys, here I am updating OBJS_2 from temp_dict.
            for key_1, value_1 in temp_dict.items():
                for key_2, value_2 in data_rec.items():
                    if key_1 == key_2:
                        OBJS_2[key_1] = value_1.union(value_2)

        else:
            for key_, value_ in temp_dict.items():
                OBJS_2[key_] = set(value_)

        print(OBJS_2)
