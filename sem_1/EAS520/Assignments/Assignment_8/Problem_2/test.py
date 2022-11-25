import random

from mpi4py import MPI

comm = MPI.COMM_WORLD
rank = comm.Get_rank()

# Initial Amount
D_AMOUNT = 10000
P1_AMOUNT = 100
P2_AMOUNT = 200
P3_AMOUNT = 300

# Store Bet Amount after each round
P1_BETS = []
P2_BETS = []
P3_BETS = []

# Store the status of winning after each round
P1_WIN_STATUS = []
P2_WIN_STATUS = []
P3_WIN_STATUS = []

def get_bet_amount(current_amount: int, is_prev_win: bool = None, prev_bet: int = None,
                   is_round_1: bool = False) -> int:
    if is_round_1:
        return int(current_amount / 2)

    else:
        if is_prev_win:
            return int(prev_bet / 2)

        return int(current_amount / 4)


def toss():
    return random.choices(['H', 'T'])


for i in range(2000):
    comm.barrier()
    is_round_1 = True if i == 0 else False

    if rank == 0:
        data_rec_1 = comm.recv(source=1, tag=110)
        data_rec_2 = comm.recv(source=2, tag=120)
        data_rec_3 = comm.recv(source=3, tag=130)

        # Coin choices of all the players
        coin_choices = [data_rec_1['coin_choice'], data_rec_2['coin_choice'], data_rec_3['coin_choice']]

        # Total bet amount of all the players excluding dealer
        bet_amount_players = [data_rec_1['bet_amount'], data_rec_2['bet_amount'], data_rec_3['bet_amount']]

        dealer_bet_amount = sum(bet_amount_players)
        D_AMOUNT -= dealer_bet_amount  # Putting money from dealer to pot
        pot = dealer_bet_amount + sum(bet_amount_players)  # Putting all the money in pot

        flip = toss()

        win_status = [True if coin_choice == flip else False for coin_choice in coin_choices]

        for j, is_win in enumerate(win_status):
            tag_ = int(str(10) + str(j + 1))  # Generating tags to send to players rank

            if is_win:  # if player wins
                data_send = {
                    'win_status': True,
                    'amount_won': bet_amount_players[j] * 2
                }

            else:
                D_AMOUNT += bet_amount_players[j] * 2

                data_send = {
                    'win_status': False,
                    'amount_won': 0
                }

            comm.send(data_send, dest=j + 1, tag=tag_)

        comm.barrier()
        print(f"D_AMOUNT: {D_AMOUNT}, after {i + 1} iterations")

    for p in range(3):
        if rank == p+1:

            if is_round_1:
                bet_amount = get_bet_amount(current_amount=P1_AMOUNT, is_round_1=is_round_1)
            else:
                bet_amount = get_bet_amount(P1_AMOUNT, P1_WIN_STATUS[-1], P1_BETS[-1], is_round_1)

            P1_AMOUNT -= bet_amount
            P1_BETS.append(bet_amount)

            data_send = {
                'bet_amount': bet_amount,
                'coin_choice': random.choices(['H', 'T'])
            }
            comm.send(data_send, dest=0, tag=110)

            comm.barrier()
            data_rec = comm.recv(source=0, tag=101)

            P1_WIN_STATUS.append(data_rec.get('win_status'))
            P1_AMOUNT += data_rec.get('amount_won')

            print(f"P1_AMOUNT: {P1_AMOUNT}, after {i + 1} iterations")
