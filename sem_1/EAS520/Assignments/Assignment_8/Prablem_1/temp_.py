if rank == 1:
    temp_dict = dict()  # For updating the OBJS_1 after each iteration

    for k, v in OBJS_2.items():
        if len(v) == 0:
            continue

        for val in v:
            flip = toss()  # Will be "H" or "T"

            print(flip)

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

    comm.barrier()
    if temp_dict.get(5) or temp_dict.get(11):
        comm.send(temp_dict, dest=0, tag=110)
        print('Msg sent from rank 1 to rank 0')

        try:
            del temp_dict[5]
            del temp_dict[11]

        except KeyError:
            pass

    else:
        comm.send(None, dest=1, tag=110)
        print('Msg sent from rank 1 to rank 0  is None')

    data_rec = comm.recv(source=0, tag=101)

    OBJS_2.clear()  # Reset the dictionary

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
