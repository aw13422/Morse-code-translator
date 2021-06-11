`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2021 12:51:31 PM
// Design Name: 
// Module Name: mux_2x1_8bit
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


module mux_2x1_8bit(
    input sel,
    input [7:0]I1,
    input [7:0]I0,
    output reg[7:0]D_out
    );
    
    always @(I0, I1, sel)
    begin
        if(sel)
            D_out = I1;
        else
            D_out = I0;
    end
endmodule
