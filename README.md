# 🚪 Elevator FSM – FPGA Implementation

This project implements an **8-floor elevator controller** using a **Finite State Machine (FSM)** in **SystemVerilog**.  
It's designed for **simulation in QuestaSim** and **deployment on an FPGA board**.  
The goal is to provide a simple, verifiable design that handles floor requests, movement directions, and emergency stops.

Whether you're a beginner learning digital design or an experienced engineer, this repo makes it easy to understand, simulate, and test the elevator logic.

---

## 📂 Repository Structure

### `design_diagrams/`  
Contains:  
- Design diagrams illustrating the overall architecture.  
- FSM state diagram showing transitions and logic flow.  

### `outputs/`  
Artifacts from simulation and synthesis:  
- Simulation waveform from QuestaSim.  
- Bitstream file for FPGA programming.  
- Demo video demonstrating the elevator in action on hardware.  

### `rtl/`  
Core design source:  
- **`elevator.sv`**: The main SystemVerilog module implementing the elevator FSM.  

### `testbench/`  
Verification files:  
- **`elevator_tb.sv`**: Testbench for simulating and verifying the design in QuestaSim.  

### `run.bat`  
A convenient batch script to launch the QuestaSim simulation with one click.  

---

## ⚙️ How the Elevator Works

The elevator uses an **FSM** to manage operations across **8 floors (0–7)**.  
It processes requests to move up or down, handles intermediate stops, and includes **emergency handling**.  
The design is **clocked and resettable** for reliable behavior.

---

## 🔑 Inputs

| Input     | Description                          | Bits/Type |
|-----------|--------------------------------------|-----------|
| `direction` | 1 for up request, 0 for down        | 1-bit     |
| `req_floor` | Requested floor number (0–7)        | [2:0]     |
| `clk`       | System clock                        | -         |
| `reset`     | Resets elevator to floor 0          | -         |
| `emergency` | Triggers immediate stop             | -         |
| `valid_in`  | Validates the current request       | -         |

---

## 🔑 Outputs

| Output   | Description                           | Bits/Type |
|----------|---------------------------------------|-----------|
| `cathode` | Drives 7-segment display segments    | [6:0]     |
| `anode`   | Selects active digit on display      | [7:0]     |
| `r, g, b` | RGB LED control: <br>• `r`: Red (down/emergency) <br>• `g`: Green (idle/doors) <br>• `b`: Blue (up) | 1-bit each |

**RGB LED status:**  
- 🔴 Red: Down movement or emergency  
- 🟢 Green: Idle or doors open  
- 🔵 Blue: Up movement  

---

## 🚦 Elevator Logic (FSM States)

### Idle (IDLE) 🟢  
- Elevator is stationary at the current floor.  
- Green LED on.  
- Waits for a valid request → then moves up/down.  

### Moving Up (MOVING_UP) 🔵  
- Blue LED on.  
- Increments floor every second (clock-based).  
- Stops at requested floor or intermediate up-call.  

### Moving Down (MOVING_DOWN) 🔴🟢  
- Red + Green LEDs on.  
- Decrements floor every second.  
- Stops at requested floor or intermediate down-call.  

### Door Open (DOOR_OPEN) 🟢🔵  
- Green + Blue LEDs on.  
- Doors open for 1 second.  
- Then → Door Close state.  

### Door Close (DOOR_CLOSE) 🔴🔵  
- Red + Blue LEDs on.  
- Doors close for 20 seconds.  
- Then → IDLE.  

### Emergency (EMERGENCY) 🔴  
- Red LED on.  
- Movement halts immediately.  
- Resumes at IDLE once cleared.  

---

## 🖥️ Display System

- **7-Segment Display**: Shows the current floor (0–7).  
- **RGB LEDs**: Indicate elevator status as described above.  

---

## ▶️ Running the Project

### Prerequisites
- QuestaSim installed for simulation.  
- FPGA board compatible with provided bitstream.  
- Basic SystemVerilog knowledge helpful but not required.  

### Simulation
1. Double-click **`run.bat`** → opens QuestaSim and runs testbench (`elevator_tb.sv`).  
2. View waveforms in QuestaSim to verify behavior.  

### FPGA Deployment
1. Use the **bitstream file** from `outputs/` to program your FPGA.  
2. Connect inputs (buttons for requests).  
3. Observe outputs on **7-segment display** and **RGB LEDs**.  
4. Watch demo video in `outputs/`.  

If issues occur → check FSM diagram in `design_diagram/`.  

---

## 📝 Notes for Beginners
- Start with **`elevator.sv`** → includes comments for clarity.  
- Try simulating different scenarios in the testbench.  
- Remember: the design is **synchronous** (everything tied to `clk`).  

---

🚀 Feel free to **fork and contribute improvements**!
