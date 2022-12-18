# Generating Initial positions
python3 generate_positions.py

# Running code in 2 cores
mpiexec -n 2 python3 main.py

# For Plotting (Output file will be output/plot.png)
python3 plot_positions.py
