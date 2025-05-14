<p align="center">
  <img src="https://via.placeholder.com/150?text=CRC32-Verilog" alt="CRC32-Verilog Logo" />
</p>

<h1 align="center">CRC32-Verilog 🚀</h1>

<p align="center">
  <a href="https://github.com/your-username/CRC32-Verilog"><img src="https://img.shields.io/github/license/your-username/CRC32-Verilog?color=blue" alt="License: MIT"></a>
  <a href="https://github.com/your-username/CRC32-Verilog"><img src="https://img.shields.io/badge/Verilog-HDL-orange" alt="Verilog"></a>
  <a href="https://github.com/your-username/CRC32-Verilog"><img src="https://img.shields.io/badge/Status-Active-green" alt="Status: Active"></a>
</p>

<p align="center">
  A Verilog implementation of a CRC-32 system for Ethernet frame generation and verification. Generate and verify Frame Check Sequence (FCS) with a testbench for simulation! 📡
</p>

---

## ✨ Features

| Feature | Description |
|---------|-------------|
| **CRC-32 Calculation** | Implements the standard CRC-32 polynomial for Ethernet (`x³² + x²⁶ + x²³ + ...`). |
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

## 📥 Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/CRC32-Verilog.git
   ```
2. Navigate to the project directory:
   ```bash
   cd CRC32-Verilog
   ```

---

## 🚀 Usage

### Simulation
1. Open your Verilog simulator.
2. Compile all `.v` files with `proj_crc32_tb.v` as the top module.
3. Run the simulation to check:
   - `oerr_tb`: High if FCS is incorrect.
   - `omatch_tb`: High if FCS matches (`0xc704dd7b`).
4. Example for Icarus Verilog:
   ```bash
   iverilog -o crc32_tb proj_crc32_tb.v proj_crc32_core.v proj_crc32_gen.v proj_crc32_mon.v proj_crc32_in8.v
   vvp crc32_tb
   ```

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
