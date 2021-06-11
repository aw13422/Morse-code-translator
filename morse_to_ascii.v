`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2021 12:40:28 PM
// Design Name: 
// Module Name: morse_to_ascii
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


module morse_to_ascii(
    input clk,
    input b,
    input reset_n,
    output tx,
    output [6:0]sseg,
    output [0:7]AN,
    output DP,
    output full
//    output dot1, dash1, lg1, wg1
    );
    wire dot, dash, lg, wg;
    wire wg_delayed;
    wire [7:0]addr;
    wire [7:0]w_data;
    wire [4:0]symbol;
    wire [2:0]symbol_count;
    wire b_debounced;
//    assign b_debounced = b;
    
//    assign dot1 = dot;
//    assign dash1 = dash;
//    assign lg1 = lg;
//    assign wg1 = wg;
    button B0(          // morse button
        .clk(clk),
        .reset_n(1),
        .noisy(b),
        .debounced(b_debounced),
        .p_edge(),
        .n_edge(),
        ._edge()
    );
    morse_decoder_2 MD0(
        .clk(clk),
        .reset_n(reset_n),
        .b(b_debounced),
        .dot(dot),
        .dash(dash),
        .lg(lg),
        .wg(wg)
    );
    shift_register_5bit SR0(
        .clk(clk),
        .en(dot ^ dash),
        .reset_n(reset_n & ~(lg | wg)),  
        .SI(dash),
        .out(symbol)          // 5 bit output
    );
    udl_counter #(.BITS(3)) UC2(        // 3 bit counter
        .clk(clk),
        .reset_n(reset_n & ~(lg | wg)),  
        .enable(dot ^ dash), 
        .up(1),
        .load(symbol_count == 5),             
        .D(3'b000),                    // 3 bit
        .Q(symbol_count)                // 3 bit
    );
    mux_2x1_8bit MUX0(
        .sel(wg),
        .I0({symbol_count, symbol}),
        .I1(8'b1110_0000),
        .D_out(addr)
    );
    D_flip_flop DFF0(
        .clk(clk),
        .en(1),
        .reset_n(1),
        .D(wg),
        .Q(wg_delayed)
    );
    synch_rom R0(
        .clk(clk), 
        .addr(addr),   // 8 bit
        .data(w_data)     // 8 bit
    );
    uart U0(
        .clk(clk),
        .reset_n(reset_n),
        .r_data(),     
        .rd_uart(0),
        .rx_empty(),   
        .rx(),          
        .w_data(w_data),      // 8 bits
        .wr_uart(~full & (lg | wg | wg_delayed)),
        .tx_full(full),             
        .tx(tx),                      
        .TIMER_FINAL_VALUE(650)    // 11 bits
    );
    sseg_driver SSD0(
        .clk(clk),
        .I7({symbol_count > 0, 3'b000, symbol[0], 1'b1}),  // symbol_count > 0
        .I6({symbol_count > 1, 3'b000, symbol[1], 1'b1}),
        .I5({symbol_count > 2, 3'b000, symbol[2], 1'b1}),
        .I4({symbol_count > 3, 3'b000, symbol[3], 1'b1}),
        .I3({symbol_count > 4, 3'b000, symbol[4], 1'b1}),
        .I2(6'b000001), // 000001
        .I1(6'b000001),   
        .I0(6'b000001),
        .AN(AN),
        .sseg(sseg),
        .DP(DP)
    );
endmodule
