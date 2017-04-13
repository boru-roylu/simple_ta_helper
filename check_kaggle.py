#! /usr/bin/python3

# Purpose: Check kaggle score for HW1
# Author: Roy Lu
# It is an example, you should revise it for your own purpose

import sys

private_simple_baseline = 7.30589
private_strong_baseline = 7.00617
public_simple_baseline  = 6.03348
public_strong_baseline  = 5.80008
tolerance_rate = 1.2

leaderboard_score = sys.argv[1]
reproduced_score_fn  = sys.argv[2]

# The score in HW1 is rmse; therefore smaller is better
hw1_score = 9999
hw1_best_score = 9999
with open(reproduced_score_fn, 'r') as f:
    lines = f.readlines()
    if len(lines) == 2:
        hw1_score = float(lines[0])
        hw1_best_score = float(lines[1])

private_score = 9999
public_score  = 9999
if len(leaderboard_score.split(',')) == 3:
    private_score = float(leaderboard_score.split(',')[1])
    public_score  = float(leaderboard_score.split(',')[2])

required_score = tolerance_rate * (private_score + public_score) / 2

# 0: reproduced
# 1: public simple baseline
# 2: public strong baseline
# 3: private simple baseline
# 4: private strong baseline
final_score = [0, 0, 0, 0, 0]
if hw1_score <= required_score or hw1_best_score <= required_score:
    final_score[0] = 1
    # public
    if public_score <= public_simple_baseline:
        final_score[1] = 1
    if public_score <= public_strong_baseline:
        final_score[2] = 1

    # private
    if private_score <= private_simple_baseline:
        final_score[3] = 1
    if private_score <= private_strong_baseline:
        final_score[4] = 1
print(",".join([ str(x) for x in final_score]))
