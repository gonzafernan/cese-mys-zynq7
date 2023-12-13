//! @title Pulse-width Modulation (PWM)
//! @author Gonzalo G. Fernandez
//! Pulse-width modulation
//!
//! {reg: [{"name": "EN", "bits": 1}, {"bits": 31}]}
//! {reg: [{"name": "freq_counter", "bits": 32}]}
//! {reg: [{"name": "duty_counter", "bits": 32}]}
//!

module pwm #(
    parameter NB = 32 //! number of bits for configuration regs
)(
    output o_pwm,                   //! modulated output
    input [NB-1:0] i_max_counter,   //! value to define frequency
    input [NB-1:0] i_max_duty,      //! value for signal high threshold
    input i_enable,                 //! module enable
    input i_reset,                  //! system reset (active low)
    input clk                       //! system clock
);

reg [NB-1 : 0] reg_counter; //! counter for module behavior 
reg reg_out;

//! Main PWM bahavior description
always @(posedge clk) begin : pwm_main
    if (~i_reset) begin
        reg_out <= 1'b0;
        reg_counter <= {NB{1'b0}};
    end
    else begin
        if (i_enable) begin
            reg_counter <= (reg_counter <= i_max_counter) ? reg_counter + 1'b1 : 1'b0;
            reg_out <= (reg_counter <= i_max_duty) ? 1'b1 : 1'b0;
        end
        else begin
            reg_out <= 1'b0;
            reg_counter <= reg_counter;
        end
    end
end

assign o_pwm = reg_out;

endmodule
