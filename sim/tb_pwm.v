//! @title Testbench for PWM module
//! @author Gonzalo G. Fernandez
//! Testbench for Pulse Width Modulation (PWM) module

`define NB 32
`timescale 1ns/100ps

module tb_pwm();

parameter NB = `NB; //! Number of bits for encoder output

reg [NB-1:0] freq_counter;  //! Define PWM frequency
reg [NB-1:0] duty_counter;  //! Define PWM duty cycle
reg enable = 1'b0;          //! Encoder enable
reg reset = 1'b0;           //! System reset for simulation
reg clk = 1'b0;             //! System clock for simulation

wire pwm_out;               //! PWM output

//! Clock generator
always #5 begin : clock_gen
    clk = ~clk;
end

//! Main test sequence
initial begin : main_seq
    freq_counter = 10;
    duty_counter = 2;
    #20 reset = 1'b1;       // enable sys
    #20 enable = 1'b1;      // enable PWM module
    #100 freq_counter = 6;
    #100 duty_counter = 3;
    #100 freq_counter = 6;
    #100 duty_counter = 1;
    #100 freq_counter = 6;
    #100 duty_counter = 5;
    #100 freq_counter = 10;
    #100 duty_counter = 5;
    #100 freq_counter = 10;
    #100 duty_counter = 15;
    #200 $finish;           // end simulation
end

//! DUT: PWM module
pwm #(
    .NB(NB)
)
u_pwm(
    .o_pwm(pwm_out),
    .i_max_counter(freq_counter),
    .i_max_duty(duty_counter),
    .i_enable(enable),
    .i_reset(reset),
    .clk(clk)
);

endmodule