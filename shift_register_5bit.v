`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2021 03:21:59 PM
// Design Name: 
// Module Name: shift_register_5bit
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


module shift_register_5bit(
    input clk,
    input en,
    input reset_n,
    input SI,
    output [4:0]out
    );
    wire [4:0]D;
    wire [4:0]Q;
    
    D_flip_flop DFF0(.clk(clk), .en(en), .reset_n(reset_n), .D(SI), .Q(Q[0]));   // right-most 
    D_flip_flop DFF1(.clk(clk), .en(en), .reset_n(reset_n), .D(Q[0]), .Q(Q[1]));
    D_flip_flop DFF2(.clk(clk), .en(en), .reset_n(reset_n), .D(Q[1]), .Q(Q[2]));
    D_flip_flop DFF3(.clk(clk), .en(en), .reset_n(reset_n), .D(Q[2]), .Q(Q[3]));
    D_flip_flop DFF4(.clk(clk), .en(en), .reset_n(reset_n), .D(Q[3]), .Q(Q[4]));
    
    assign out = Q;
endmodule
