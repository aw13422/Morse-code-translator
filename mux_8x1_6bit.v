`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2021 06:15:06 PM
// Design Name: 
// Module Name: mux_8x1_6bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module mux_8x1_6bit(
    input [2:0]sel,
    input [5:0]I7,
    input [5:0]I6,
    input [5:0]I5,
    input [5:0]I4,
    input [5:0]I3,
    input [5:0]I2,
    input [5:0]I1,
    input [5:0]I0,
    output reg[5:0]D_out
    );
    
    always @(I0, I1, I2, I3, I4, I5, I6, I7, sel)
    begin
        case(sel)
        3'b000: D_out = I7;
        3'b001: D_out = I6;
        3'b010: D_out = I5;
        3'b011: D_out = I4;
        3'b100: D_out = I3;
        3'b101: D_out = I2;
        3'b110: D_out = I1;
        3'b111: D_out = I0;
        default: D_out = I7;
        endcase
    end
endmodule
