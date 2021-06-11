`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2021 04:56:45 PM
// Design Name: 
// Module Name: sseg_driver
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


module sseg_driver(
    input clk,
//    input reset_n,
//    input en,
    input [5:0]I7,
    input [5:0]I6,
    input [5:0]I5,
    input [5:0]I4,
    input [5:0]I3,
    input [5:0]I2,
    input [5:0]I1,
    input [5:0]I0,
//    input up,
//    input load,
//    input [2:0]D,
    output [0:7]AN,
    output [6:0]sseg,
    output DP
    );
    wire done;
    wire [2:0]Q;
    wire [5:0]D_out;
    wire [0:7]y;
    
    timer_input #(.BITS(8)) TI0(
        .clk(clk),
        .reset_n(1), // 1
        .enable(1),
        .FINAL_VALUE(8'b1111_1111), //
        .done(done)
    );
    udl_counter UC0(
        .clk(clk),
        .reset_n(1), // 1
        .enable(done),
        .up(1),
        .load(0),
        .D('b0),
        .Q(Q)
    );
    mux_8x1_6bit MU0(
        .sel(Q),
        .I7(I7),
        .I6(I6),
        .I5(I5),
        .I4(I4),
        .I3(I3),
        .I2(I2),
        .I1(I1),
        .I0(I0),
        .D_out(D_out)
    );
    decoder_generic DG0(
        .w(Q),
        .en(D_out[5]),
        .y(y)
    );
    hex2sseg H2S0(
        .hex(D_out[4:1]),
        .sseg(sseg)
    );
    
    assign DP = D_out[0];
    assign AN = ~y;

endmodule