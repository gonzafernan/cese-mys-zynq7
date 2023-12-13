
# Entity: pwm 
- **File**: pwm.v
- **Title:**  Pulse-width Modulation (PWM)
- **Author:**  Gonzalo G. Fernandez

## Diagram
![Diagram](pwm.svg "Diagram")
## Description

Pulse-width modulation

![alt text](wavedrom_hkPQ0.svg "title")

![alt text](wavedrom_Dm151.svg "title")

![alt text](wavedrom_msFJ2.svg "title")

## Generics

| Generic name | Type | Value | Description                           |
| ------------ | ---- | ----- | ------------------------------------- |
| NB           |      | 32    | number of bits for configuration regs |

## Ports

| Port name     | Direction | Type     | Description                     |
| ------------- | --------- | -------- | ------------------------------- |
| o_pwm         | output    |          | modulated output                |
| i_max_counter | input     | [NB-1:0] | value to define frequency       |
| i_max_duty    | input     | [NB-1:0] | value for signal high threshold |
| i_enable      | input     |          | module enable                   |
| i_reset       | input     |          | system reset (active low)       |
| clk           | input     |          | system clock                    |

## Signals

| Name        | Type           | Description                 |
| ----------- | -------------- | --------------------------- |
| reg_counter | reg [NB-1 : 0] | counter for module behavior |
| reg_out     | reg            |                             |

## Processes
- pwm_main: ( @(posedge clk) )
  - **Type:** always
  - **Description**
  Main PWM bahavior description
 