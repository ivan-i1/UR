reset;

# Sets
set S;                # Stocks
set T;                # Time periods

# Parameters
param q integer > 0;  # Number of stocks to include
param r {S, T};       # Return of stock i at time t
param b {T};          # Benchmark return at time t

# Decision Variables
var x {S} binary;     # 1 if stock i is included
var w {S} >= 0;       # Weight of investment in stock i
var p {T};            # Portfolio return at time t

# Constraints

# Total number of selected stocks = q
s.t. Cardinality:
    sum {i in S} x[i] = q;

# Total investment sums to 1
s.t. Budget:
    sum {i in S} w[i] = 1;

# Zero weight if stock not selected
s.t. Link {i in S}:
    w[i] <= x[i];

# Define portfolio return
s.t. PortfolioDef {t in T}:
    p[t] = sum {i in S} w[i] * r[i, t];

# Objective: minimize squared tracking error over time
minimize TrackingError:
    sum {t in T} (p[t] - b[t])^2;

