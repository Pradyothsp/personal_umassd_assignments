import random

from mpi4py import MPI

from utils import get_temp_dict, save_json, read_json

M = 1

comm = MPI.COMM_WORLD
rank = comm.rank

OBJS_1 = read_json(file_name='objs_1_init.json')
OBJS_2 = read_json(file_name='objs_2_init.json')

for i in range(M):
    comm.barrier()

    if rank == 0:
        # comm.barrier()
        temp_dict, OBJS_1 = get_temp_dict(OBJS_1)  # For updating the OBJS_1 after each iteration

        # print(f"Temp Dict 0 is {temp_dict}")

        comm.send(temp_dict, dest=1, tag=101)

        if temp_dict.get(0):
            del temp_dict[0]

        if temp_dict.get(6):
            del temp_dict[6]

        comm.barrier()
        data_rec = comm.recv(source=1, tag=110)

        print(f"Data received in rank 0 is {data_rec}")

        if data_rec.get(5):
            temp_dict[5] = temp_dict[5].union(data_rec.get(5))

        if data_rec.get(11):
            temp_dict[1] = temp_dict[1].union(data_rec.get(11))

        OBJS_1 = temp_dict.copy()

        print(f"OBJ_1: {OBJS_1}, after iteration {i + 1}")

        if i + 1 == M:
            save_json(file_name='obj_pos_1.json', data=OBJS_1)

    if rank == 1:
        # comm.barrier()
        temp_dict = dict()  # For updating the OBJS_2 after each iteration

        temp_dict, OBJS_2 = get_temp_dict(OBJS_2)  # For updating the OBJS_2 after each iteration

        # print(f"Temp Dict 1 is {temp_dict}")

        comm.send(temp_dict, dest=0, tag=110)

        if temp_dict.get(5):
            del temp_dict[5]

        if temp_dict.get(11):
            del temp_dict[11]

        comm.barrier()
        data_rec = comm.recv(source=0, tag=101)

        print(f"Data received in rank 1 is {data_rec}")

        if data_rec.get(0):
            temp_dict[10] = temp_dict[10].union(data_rec.get(0))

        if data_rec.get(6):
            temp_dict[6] = temp_dict[6].union(data_rec.get(6))

        OBJS_2 = temp_dict.copy()

        print(f"OBJ_2: {OBJS_2}, after iteration {i + 1}")

        if i + 1 == M:
            save_json(file_name='obj_pos_2.json', data=OBJS_2)

# FINAL_POS = OBJS_1.update(OBJS_2)
# print(f"Final positions is: {FINAL_POS}")
