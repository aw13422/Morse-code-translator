`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2021 03:14:44 PM
// Design Name: 
// Module Name: morse_decoder_application
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


module morse_decoder_application(
    input clk,
    //input b,
    input b_debounced,
    input reset_n,
    output [4:0]symbol,
    output [2:0]symbol_count,
    output dot, dash, lg, wg
//    output [6:0]sseg,
//    output [0:7]AN,
//    output DP
    );
    wire shift_en;
    //wire b_debounced;
    wire [4:0]shift_out;
    wire [2:0]counter_bin;
    wire [11:0]counter_bcd;
    wire [19:0]shift_bin;
    wire [11:0]shift_bcd;
    wire dot_wire, dash_wire, lg_wire, wg_wire;
    assign dot = dot_wire;
    assign dash = dash_wire;
    assign lg = lg_wire;
    assign wg = wg_wire;

    assign symbol = shift_out;
    assign symbol_count = counter_bcd[2:0];
//    button B0(          // morse button
//        .clk(clk),
//        .reset_n(1),
//        .noisy(b),
//        .debounced(b_debounced),
//        .p_edge(),
//        .n_edge(),
//        ._edge()
//    );
    morse_decoder_2 MD0(
        .clk(clk),
        .reset_n(reset_n),
        .b(b_debounced),
        .dot(dot_wire),
        .dash(dash_wire),
        .lg(lg_wire),
        .wg(wg_wire)
    );
  
    assign shift_en = dot_wire ^ dash_wire;
    shift_register_5bit SR0(
        .clk(clk),
        .en(shift_en),
        .reset_n(reset_n & ~(lg_wire | wg_wire)),  // reset_n & ~(lg_wire | wg_wire)
        .SI(dash_wire),
        .out(shift_out)          // 5 bit output
    );
//    sseg_driver SSD0(
//        .clk(clk),
//        //.reset_n(~reset_n),
//        .I7({counter_bcd > 0, 3'b000, shift_out[0], 1'b1}),  
//        .I6({counter_bcd > 1, 3'b000, shift_out[1], 1'b1}),
//        .I5({counter_bcd > 2, 3'b000, shift_out[2], 1'b1}),
//        .I4({counter_bcd > 3, 3'b000, shift_out[3], 1'b1}),
//        .I3({counter_bcd > 4, 3'b000, shift_out[4], 1'b1}),
//        .I2(6'b000001),
//        .I1(6'b000001),
//        .I0({1'b1, counter_bcd[3:0], 1'b1}),
//        .AN(AN),
//        .sseg(sseg),
//        .DP(DP)
//    );
    udl_counter #(.BITS(3)) UC2(        // 3 bit counter
        .clk(clk),
        .reset_n(reset_n & ~(lg_wire | wg_wire)),  //  & ~(lg_wire | wg_wire)
        .enable(shift_en), 
        .up(1),
        .load(counter_bin == 5),             
        .D(3'b000),                    // 3 bit
        .Q(counter_bin)                // 3 bit
    );
    bin2bcd BB0(
        .bin({5'b00000, counter_bin}),     // 8 bit
        .bcd(counter_bcd)                    // 12 bit
    );
endmodule
