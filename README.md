## Proyecto Microarquitecturas y Softcores

- Autor: Gonzalo G. Fernandez
- Carrera de Especializacion en Sistemas Embebidos
- Laboratorio de Sistemas Embebidos - FIUBA

## Desarrollo de IP cores para robot movil en plataforma Zynq7

![](./imgs/project-base_diagram.png)

### PWM IP core: diseño y simulación comportamental

El comportamiento se basa en el siguiente diagrama de tiempo:

![](./imgs/pwm-expected_out.png)

La salida queda definida por:
- *freq_counte*: define la frecuencia del canal PWM
- *duty_counter*: define el duty cycle del canal PWM

El diagrama de bloques del modulo diseñado es el siguiente:

![](./docs/pwm.svg)

Simulacion comportamental:

![](./imgs/pwm-sim_out.png)

### Diagrama de bloques

Project block design (PWM y switches):

![](./imgs/project-block_diagram_pwm.png)

Project block design (PWM, encoder y switches):

![](./imgs/project-block_diagram_pwm_encoder.png)

### Implementacion

![](./imgs/project-impl.png)

Timing report:

![](./imgs/project-timing_report.png)

Utilization report:

![](./imgs/project-utilization_report.png)

Power report:

![](./imgs/project-power_report.png)

### Propuesta a futuro

![](./imgs/project-future_diagram.png)