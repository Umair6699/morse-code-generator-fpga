# Morse Code Generator on FPGA

This project implements a **Morse code generator** on an FPGA using Verilog.  
The system converts selected letters into Morse code signals and displays them on an LED in real-time.

---

## Features
- Select letters (A–H) using 3 switches (SW2_0)  
- Generate corresponding Morse code signals (dot `.` and dash `-`)  
- LED output (LEDR0) displays the Morse code  
- Push button KEY1 to start transmission and KEY0 to reset  
- Real hardware implementation on Intel DE10 FPGA  
- Hardware demo video included to show working system  

---

## FPGA Board Used
- **Board:** Intel DE10 (Cyclone V - XC5SEMA)  
- **Clock Frequency:** 50 MHz  
- **LED Output:** LEDR0  
- **Switch Inputs:** SW2_0  
- **Push Buttons:** KEY0 (Reset), KEY1 (Start)  
- **Pin Assignments:** See [`constraints/morse_code.qsf`](constraints/morse_code.qsf)  
- **Notes:** Project tested on real hardware  

---

## Tools & Technologies
- **Verilog HDL** for digital design  
- **Quartus Prime** for FPGA compilation and pin assignments  
- **ModelSim / Vivado** for simulation (optional)  
- **Intel DE10 FPGA Board**  

---

## Folder Structure

morse-code-generator-fpga/
├── rtl/ ← Verilog source code
│ └── morse_code.v
├── constraints/ ← FPGA pin assignment file 
│ └── Pin_assignment.txt
├── simulation/ ← Video showing hardware working
│ └── hardware_demo.mp4
├── board/ ← FPGA board info
│ └── fpga_board_info.txt
└── README.md ← Project explanation

---

## Simulation / Hardware Proof
- **Video** demonstrating the Morse code output on Intel DE10 FPGA  
- File: [`simulation/hardware_demo.mp4`](simulation/hardware_demo.mp4)  
- Shows **LEDR0 blinking** according to the selected letter in Morse code  

---

## How to Use
1. Connect the Intel DE10 FPGA board to your PC.  
2. Load the **Verilog code** (`rtl/morse_code.v`) in Quartus Prime.  
3. Apply **pin assignments** from [`constraints/morse_code.qsf`](constraints/morse_code.qsf).  
4. Compile the project and upload it to the FPGA.  
5. Set the switches SW2_0 to select a letter.  
6. Press KEY1 to start the Morse code transmission.  
7. LEDR0 will blink the corresponding Morse code.  
8. Press KEY0 to reset.  

---

## Author
**Muhammad Umair Ajmal**  
Electrical Engineering Student  

---

## License
This project is open source. You can use it for **educational purposes**.
