## Project Context

- **Course**: VLSI Laboratory  
- **Instructor**: Prof. Hsieh-Chia Chang  
- **Timeframe**: Oct. 2024 – Jan. 2025  
- **Collaboration**: Team-based course project with shared design responsibility

---

## Architecture Overview

The MAC architecture consists of:

- 6-bit Booth-encoded multiplier
- Partial product reduction using CSA (Carry-Save Adders)
- Final summation using CLA (Carry Lookahead Adder)
- Accumulator for iterative addition
- Hierarchical adder structure to reduce critical path delay

This architecture balances **speed, area, and structural clarity**, and is suitable for layout-level optimization.

---

## Design Methodology

### 1. Arithmetic Architecture Selection
- Booth encoding was adopted to reduce the number of partial products
- CSA stages minimized carry propagation during partial product accumulation
- CLA was used in the final stage to shorten the critical path

### 2. Timing Optimization
- Critical paths were identified through post-layout simulation
- Pipeline restructuring and adder-level optimizations were applied
- Buffer insertion was explored to reduce long interconnect delay

### 3. Layout Considerations
- Transistor sizing optimized to balance drive strength and parasitic loading
- Routing symmetry was emphasized to improve post-layout timing accuracy
- Parasitic capacitance and RC delay were explicitly considered

---

## Performance Summary

### Project Versions and Attribution

This repository contains **two distinct versions** of the design:

### 1. Course Final Submission (Team Version)

- **Post-layout critical path delay**: **3.01 ns**
- **Transistor count**: **2257**
- This version corresponds to the **official final submission** evaluated for course grading
- This is the version referenced by team members who report course results

### 2. Post-Course Individual Optimization (Author Only)

- **Post-layout critical path delay**: **2.6 ns**
- **Transistor count**: **~2500**
- After the course concluded, additional pipeline restructuring and buffer insertion
  were explored individually by the author
- These optimizations were **not part of the original course submission**
  and are included to demonstrate further timing optimization beyond course requirements

---

## Repository Structure

