from collections import deque


def play(players, marbles):
    circle = deque([0])
    scores = [0] * players
    for turn in range(1, marbles+1):
        current_player = turn % players
        if turn % 23:
            circle.rotate(2)
            circle.append(turn)
        else:
            circle.rotate(-7)
            scores[current_player] += circle.pop() + turn
    return max(scores)


PLAYERS = 410
MARBLES = 72059

print(play(PLAYERS, MARBLES))
print(play(PLAYERS, MARBLES*100))
