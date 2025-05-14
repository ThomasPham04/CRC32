
<h1 align="center">CRC32-Verilog 🚀</h1>

<p align="center">
  <a href="https://github.com/ThomasPham04/CRC32"><img src="https://img.shields.io/github/license/ThomasPham04/CRC32?color=blue" alt="License: MIT"></a>
  <a href="https://github.com/ThomasPham04/CRC32"><img src="https://img.shields.io/badge/Verilog-HDL-orange" alt="Verilog"></a>
  <a href="https://github.com/ThomasPham04/CRC32"><img src="https://img.shields.io/badge/Status-Active-green" alt="Status: Active"></a>
</p>

<p align="center">
  A Verilog implementation of a CRC-32 system for Ethernet frame generation and verification. Generate and verify Frame Check Sequence (FCS) with a testbench for simulation! 📡
</p>

---

## ✨ Features

| Feature | Description |
|---------|-------------|
| **CRC-32 Calculation** | Implements the standard CRC-32 polynomial for Ethernet (`G(x)=x³²+x²⁶+x²³+x²²+x¹⁶+x¹²+x¹¹+x¹⁰+x⁸+x⁷+x⁵+x⁴+x²+x¹+x⁰`). |
| **FCS Generation** | Appends 32-bit FCS to data frames. |
| **FCS Verification** | Checks FCS integrity with error detection and match reporting. |
| **Parameterized Design** | Configurable data width (`DAT_W`) and frame size (`NUM_W`). |
| **Testbench Included** | Simulates a 36-byte Ethernet frame to verify functionality. |

---

## 📂 Project Structure

- `proj_crc32_core.v` 🛠️: Core module integrating FCS generation and monitoring.
- `proj_crc32_gen.v` 📤: Generates CRC-32 and appends FCS to frames.
- `proj_crc32_mon.v` 🔍: Monitors and verifies FCS integrity.
- `proj_crc32_in8.v` ⚙️: Core CRC-32 calculation for 8-bit input data.
- `proj_crc32_tb.v` 🧪: Testbench simulating an Ethernet frame.

---

## 🛠️ Prerequisites

- Verilog simulator (e.g., [ModelSim](https://www.mentor.com/products/fv/modelsim/), [Vivado](https://www.xilinx.com/products/design-tools/vivado.html), or [Icarus Verilog](http://iverilog.icarus.com/)).
- Basic knowledge of Verilog and Ethernet frame structure.

---

## 📥 Installation (Windows)

1. Clone the repository:
   ```bash
   git clone https://github.com/ThomasPham04/CRC32.git
   ```
2. Navigate to the project directory:
   ```bash
   cd CRC32
   ```
3. Run the file CRC32.xpr in CRC32 directory (required: install Vivado):
   ```bash
    CRC32.xpr
   ```
4. In Vivado, open the Flow Navigator and select Run Simulation > Run Behavioral Simulation to see its behavior.

---

### Customization
- Edit parameters (`DAT_W`, `NUM_W`) in Verilog files for different data widths or frame sizes.
- Modify `proj_crc32_tb.v` to test custom Ethernet frames.

---

## 🧪 Testbench

- **File**: `proj_crc32_tb.v`
- **Function**: Simulates a 36-byte Ethernet frame.
- **Outputs**:
  - `oerr_tb`: Indicates FCS errors.
  - `omatch_tb`: Confirms FCS match with `0xc704dd7b`.
- **Clock**: 10ns period (100MHz).

---

## 🌐 Applications

- Ethernet frame processing 📦
- Error detection in communication protocols 🛡️
- FPGA/ASIC design for network hardware 💻

---
