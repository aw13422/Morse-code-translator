`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2021 06:58:40 PM
// Design Name: 
// Module Name: decoder_generic
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


module decoder_generic              // 3 to 8 decoder
    #(parameter N = 3)(
    input [N - 1:0] w,
    input en,
    output reg [0:2 ** N - 1] y     // ** = exponent
    );
    
    always @(w, en)
    begin
        y = 'b0;
        if (en)
            y[w] = 1'b1; 
        else
            y = 'b0;
    end
endmodule
