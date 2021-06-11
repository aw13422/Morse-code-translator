`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2021 03:23:39 PM
// Design Name: 
// Module Name: D_flip_flop
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


module D_flip_flop(
    input clk,
    input en, 
    input reset_n,
    input D,
    output reg Q
    );
    
    always@ (posedge clk)
    begin
        if(~reset_n)
            Q = 1'b0;
        else if(en)
            Q = D;
    end
endmodule

