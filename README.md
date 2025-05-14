CRC32-Verilog
A Verilog implementation of a CRC-32 (Cyclic Redundancy Check) system for Ethernet frame generation and verification. This project includes modules for generating Frame Check Sequence (FCS) and monitoring CRC-32 integrity, along with a testbench for simulation.
Features

CRC-32 Calculation: Implements the standard CRC-32 polynomial for Ethernet (x^32 + x^26 + x^23 + ...).
FCS Generation: Appends 32-bit FCS to data frames.
FCS Verification: Checks FCS integrity with error detection and match reporting.
Parameterized Design: Configurable data width (DAT_W) and frame size (NUM_W).
Testbench Included: Simulates a 36-byte Ethernet frame to verify functionality.

Project Structure

proj_crc32_core.v: Core module integrating FCS generation and monitoring.
proj_crc32_gen.v: Generates CRC-32 and appends FCS to frames.
proj_crc32_mon.v: Monitors and verifies FCS integrity.
proj_crc32_in8.v: Core CRC-32 calculation for 8-bit input data.
proj_crc32_tb.v: Testbench simulating an Ethernet frame.

Testbench
The testbench (proj_crc32_tb.v) simulates a 36-byte Ethernet frame.
Outputs:
oerr_tb: High if FCS is incorrect.
omatch_tb: High if FCS matches the expected value (0xc704dd7b).

Clock period: 10ns (100MHz).

Applications

Ethernet frame processing.
Error detection in communication protocols.
FPGA/ASIC design for network hardware.

