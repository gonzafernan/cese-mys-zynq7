//! @title Quadrature incremental encoder
//! @author Gonzalo G. Fernandez
//! Quadrature incremental encoder interface

module qencoder #(
    parameter NB = 32 //! number of bits of output value
)(
    output wire [NB-1:0] o_position,    //! Position output
    output wire o_dir,                  //! Sensed direction
    input wire [1:0] i_encoder,         //! A and B encoder signals
    input wire i_enable,                //! Module enable
    input wire i_reset,                 //! Module reset (active low)
    input wire clk                      //! System clock
);

localparam AA = 2'b00;
localparam AB = 2'b01;
localparam BA = 2'b10;
localparam BB = 2'b11;

reg [NB-1 : 0] reg_counter; //! Position counter
reg reg_dir;                //! Registered direction
reg [1:0] state;            //! Current FSM state
//reg [1:0] next_state;       //! Next FSM state

//! Quadratic encoder reset and enable
always @(posedge clk or negedge i_reset) begin : reset_enable_run
    if (~i_reset) begin
        state <= AA;
        reg_counter <= {NB{1'b0}};
        reg_dir <= 1'b0;
    end
    else begin
        if (~i_enable) begin
            state <= state;
            reg_counter <= reg_counter;
            reg_dir <= 1'b0;
        end
        else begin
//           state <= next_state;
            case (state)
                AA: begin
                    if (i_encoder == 2'b10) begin
//                       next_state <= BA;
                        state <= BA;
                        reg_counter <= reg_counter + 1'b1;
                        reg_dir <= 1'b1;
                    end
                    else if (i_encoder == 2'b01) begin
//                        next_state <= AB;
                        state <= AB;
                        reg_counter <= reg_counter - 1'b1;
                        reg_dir <= 1'b0;
                    end
                    else begin
//                        next_state <= AA;
                        state <= AA;
                        reg_counter <= reg_counter;
                        reg_dir <= reg_dir;
                    end
                end
                AB: begin
                    if (i_encoder == 2'b00) begin
//                        next_state <= AA;
                        state <= AA;
                        reg_counter <= reg_counter + 1'b1;
                        reg_dir <= 1'b1;
                    end
                    else if (i_encoder == 2'b11) begin
//                        next_state <= BB;
                        state <= BB;
                        reg_counter <= reg_counter - 1'b1;
                        reg_dir <= 1'b0;
                    end
                    else begin
//                        next_state <= AB;
                        state <= AB;
                        reg_counter <= reg_counter;
                        reg_dir <= reg_dir;
                    end
                end
                BA: begin
                    if (i_encoder == 2'b11) begin
//                        next_state <= BB;
                        state <= BB;
                        reg_counter <= reg_counter + 1'b1;
                        reg_dir <= 1'b1;
                    end
                    else if (i_encoder == 2'b00) begin
//                        next_state <= AA;
                        state <= AA;
                        reg_counter <= reg_counter - 1'b1;
                        reg_dir <= 1'b0;
                    end
                    else begin
//                        next_state <= BA;
                        state <= BA;
                        reg_counter <= reg_counter;
                        reg_dir <= reg_dir;
                    end
                end
                BB: begin
                    if (i_encoder == 2'b01) begin
//                        next_state <= AB;
                        state <= AB;
                        reg_counter <= reg_counter + 1'b1;
                        reg_dir <= 1'b1;
                    end
                    else if (i_encoder == 2'b10) begin
//                        next_state <= BA;
                        state <= BA;
                        reg_counter <= reg_counter - 1'b1;
                        reg_dir <= 1'b0;
                    end
                    else begin
//                        next_state <= BB;
                        state <= BB;
                        reg_counter <= reg_counter;
                        reg_dir <= reg_dir;
                    end               
                end
                default: begin
                    reg_counter <= reg_counter;
//                    next_state <= state;
                    state <= state;
                    reg_dir <= reg_dir;
                end
            endcase
        end
    end
end

assign o_position = reg_counter;
assign o_dir = reg_dir;

endmodule