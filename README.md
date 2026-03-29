# MiniChess Dynamic Programming Solver

A tabular **Markov Decision Process (MDP)** based MiniChess project that computes an optimal policy for White using **Dynamic Programming** methods such as **Value Iteration** and **Policy Iteration**.

The project models a simplified chess endgame on a small board with a limited piece set, making the full state space enumerable and solvable exactly.

## Problem Statement

The goal is to design and implement a reinforcement learning agent that plays as **White** in a simplified chess environment and learns how to convert a small advantage into a win, or at least avoid a loss, against a defensive opponent.

The environment is modeled as a finite MDP with:

- a custom MiniChess board,
- a compact tabular state representation,
- legal action generation for both sides,
- terminal-state detection,
- sparse rewards,
- and exact dynamic programming for optimal control.

---

## Environment Description

### Board

The notebook uses a **4×4 board** configuration.

### Pieces

The game includes only:

- **White King (WK)**
- **White Pawn (WP)**
- **Black King (BK)**

### Rules and Constraints

- White moves first.
- The pawn advances forward and can promote to a Queen.
- Kings move one square in any direction.
- Kings cannot move into check.
- Kings may not occupy adjacent squares.
- Pieces cannot move through other pieces.
- No castling.
- No en passant.
- Promotion is only to a **Queen**.

---

## State Representation

The environment uses the following state tuple:

```python
State = (WK, WP, BK, Turn, Promoted, Plies)
```

## State Components:

| Component  | Meaning                                                |
| ---------- | ------------------------------------------------------ |
| `WK`       | White King position `(row, col)`                       |
| `WP`       | White Pawn position `(row, col)` or `None` if captured |
| `BK`       | Black King position `(row, col)`                       |
| `Turn`     | Player to move: `'W'` or `'B'`                         |
| `Promoted` | Boolean flag indicating whether the pawn has promoted  |
| `Plies`    | Half-move counter used for the move-limit draw rule    |


This representation is fully Markovian because it contains all information needed to determine legal actions and next states.

## Action Space
### White Actions
- Move White King
- Move Pawn
- Move Queen (after promotion)
### Black Actions
- Move Black King
### Constraints
- No illegal moves
- No king adjacency
- No moving into check
- No overlapping pieces

### Transition Model
- Deterministic transitions
- Each (state, action) → next state with probability = 1
- Precomputed using reachable-state graph

## Reward Design

| Condition     | Reward |
| ------------- | ------ |
| Checkmate     | +10    |
| Pawn captured | -10    |
| Draw          | 0      |
| Normal move   | 0      |


## Terminal Conditions

- Episode ends if:
- Checkmate
- Pawn captured
- Stalemate
- Move limit reached
- Game finishes after promotion

## Algorithms

### Value Iteration

- Updates value function until convergence:

`V(s) = max_a Σ p(s'|s,a) [ r + γV(s') ]`

## Policy Iteration

- Steps:

<ol>
<li> Policy Evaluation
<li>Policy Improvement
</ol>

- Repeat until policy stabilizes.

## Results
- Reachable States: 6089
- Value Iteration Convergence: 6 iterations
- Policy Iteration Convergence: 6 iterations

## Learned Strategy
- Advance pawn safely
- Use king support
- Restrict opponent king
- Convert advantage to win

## Visualization
- Policy trace
- Board rendering
- Value heatmaps


## Project Structure
.
├── Team_40_DP.ipynb
├── README.md
└── requirements.txt


Requirements : `requirements.txt`

How to Run:

```
git clone https://github.com/<your-username>/minichess-dp-solver.git
cd minichess-dp-solver
jupyter notebook
```

## Technical Notes
- Tabular Dynamic Programming
- Fully enumerated state space
- Deterministic transitions
- Suitable only for small environments

## Limitations
- Does not scale to full chess
- State explosion problem
- Sparse rewards

## Future Improvements
- Larger board support
- Minimax / Alpha-Beta comparison
- Monte Carlo Tree Search
- Neural RL (Deep Q / Policy Gradients)