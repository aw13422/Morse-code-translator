`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2021 01:13:40 PM
// Design Name: 
// Module Name: bin2bcd
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


module bin2bcd(
    input [7:0]bin,
    output [11:0]bcd
    );
    wire[18:0] add_out;
        
    assign bcd[11:10] = 0;
    assign bcd[0] = bin[0]; 
    
    add_3 A0(.A({1'b0, bin[7:5]})        , .S(add_out[18:15]));
    add_3 A1(.A({add_out[17:15], bin[4]}), .S(add_out[14:11]));
    add_3 A2(.A({add_out[13:11], bin[3]}), .S(add_out[10:7]));
    add_3 A3(.A({add_out[9:7], bin[2]})  , .S(add_out[6:3]));
    add_3 A4(.A({add_out[5:3], bin[1]})  , .S(bcd[4:1]));
    
    add_3 A5(.A({1'b0, add_out[18], add_out[14], add_out[10]}), .S({bcd[9], add_out[2:0]}));
    add_3 A6(.A({add_out[2:0], add_out[6]})                   , .S(bcd[8:5]));
    
endmodule
