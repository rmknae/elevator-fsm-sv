# run.do - Simulation script for elevator FSM project

# Create and map work library
vlib work
vmap work work

# Compile RTL
vlog rtl/elevator.sv

# Compile Testbench
vlog testbench/elevator_tb.sv

# Load simulation
vsim -voptargs=+acc work.elevator_tb

# Add specific signals to waveform
add wave sim:/elevator_tb/direction
add wave sim:/elevator_tb/req_floor
add wave sim:/elevator_tb/clk
add wave sim:/elevator_tb/reset
add wave sim:/elevator_tb/emergency
add wave sim:/elevator_tb/valid_in
add wave sim:/elevator_tb/cathode
add wave sim:/elevator_tb/anode
add wave sim:/elevator_tb/r
add wave sim:/elevator_tb/g
add wave sim:/elevator_tb/b
add wave sim:/elevator_tb/anode
add wave sim:/elevator_tb/cathode


# Run simulation
run -all
