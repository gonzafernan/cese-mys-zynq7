//! @title Quadrature incremental encoder
//! @author Gonzalo G. Fernandez
//! Quadrature incremental encoder interface

module top_qencoder(
    input clk_pin
);

wire [1:0] encoder;
wire enable;
wire reset;

wire [31:0] position;
wire dir;

vio
vio_0(
    .clk_0(clk_pin),
    .probe_in0_0(position),
    .probe_in1_0(dir),
    .probe_out0_0(encoder),
    .probe_out1_0(enable),
    .probe_out2_0(reset)
);

qencoder #(
    .NB(32)
)
u_qencoder(
    .o_position(position),
    .o_dir(dir),
    .i_encoder(encoder),
    .i_enable(enable),
    .i_reset(reset),
    .clk(clk_pin)
);

endmodule