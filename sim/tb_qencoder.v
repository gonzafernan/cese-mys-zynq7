//! @title Testbench for quadrature incremental encoder
//! @author Gonzalo G. Fernandez
//! Testbench for quadrature incremental encoder interface

`define NB 32
`timescale 1ns/100ps

module tb_qencoder();

parameter NB = `NB; //! Number of bits for encoder output

wire [NB-1:0] position;     //! Simulated output position measured by encoder
wire dir;                   //! Simulated direction
reg [1:0] encoder = 1'b00;  //! Simulated encoder signals
reg enable = 1'b0;          //! Encoder enable
reg reset = 1'b0;           //! System reset for simulation
reg clk = 1'b0;             //! System clock for simulation

reg signal_sel = 1'b0;
wire [1:0] tb_fsm_state;

assign tb_fsm_state = tb_qencoder.u_qencoder.state;

//! Clock generator
always #5 begin : clock_gen
    clk = ~clk;
end

//! Encoder signal A simulation
always #40 begin : qenc_a_sim
    encoder[signal_sel] = ~encoder[signal_sel];
end

//! Encoder signal B simulation
always @(posedge encoder[signal_sel]) begin : qenc_b_sim
    #20 encoder[signal_sel + 1'b1] = 1'b1;
end
always @(negedge encoder[signal_sel]) begin
    #20 encoder[signal_sel + 1'b1] = 1'b0;
end

//! Main test sequence
initial begin : main_seq
    #20 reset = 1'b1;                       // enable sys
    #20 enable = 1'b1;                      // enable encoder module
    #200 signal_sel = signal_sel + 1'b1;    // change sim direction
    #200 $finish;                           // end simulation
end

//! DUT: Quadratic incremental encoder
qencoder #(
    .NB(NB)
)
u_qencoder(
    .o_position(position),
    .o_dir(dir),
    .i_encoder(encoder),
    .i_enable(enable),
    .i_reset(reset),
    .clk(clk)
);

endmodule