from mpi4py import MPI

comm = MPI.COMM_WORLD
rank = comm.Get_rank()


for _ in range(2):
    if rank == 0:
        data_1_r = comm.recv(source=1, tag=110)
        data_2_r = comm.recv(source=2, tag=120)
        data_3_r = comm.recv(source=3, tag=130)

        print(f"Data 1: {data_1_r}")
        print(f"Data 2: {data_2_r}")
        print(f"Data 3: {data_3_r}")

        data_send_common = {
            'msg_status': 'Message received'
        }

        # comm.send(data_send_common, dest=1, tag=101)
        # comm.send(data_send_common, dest=2, tag=102)
        # comm.send(data_send_common, dest=3, tag=103)

        for i in range(3):
            tag_ = int(str(10) + str(i + 1))
            comm.send(data_send_common, dest=i + 1, tag=tag_)

    elif rank == 1:
        data_1_list_send = []
        data_1_list_rec = []

        data_1 = {
            'coin_preference': 'HH'
        }
        data_1_list_send.append(data_1)

        comm.send(data_1, dest=0, tag=110)

        data_1_rec = comm.recv(source=0, tag=101)
        data_1_list_rec.append(data_1_rec)

        print(f"Data 1 rec: {data_1_rec}")

    elif rank == 2:
        data_2_list_send = []
        data_2_list_rec = []

        data_2 = {
            'coin_preference': 'HT'
        }
        data_2_list_send.append(data_2)

        comm.send(data_2, dest=0, tag=120)

        data_2_rec = comm.recv(source=0, tag=102)
        data_2_list_rec.append(data_2_rec)

        print(f"Data 2 rec: {data_2_rec}")

    elif rank == 3:
        data_3_list_send = []
        data_3_list_rec = []

        data_3 = {
            'coin_preference': 'TT'
        }
        data_3_list_send.append(data_3)

        comm.send(data_3, dest=0, tag=130)

        data_3_rec = comm.recv(source=0, tag=103)
        data_3_list_rec.append(data_3_rec)

        print(f"Data 3 rec: {data_3_rec}")
