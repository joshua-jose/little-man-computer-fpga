`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.10.2023 11:33:20
// Design Name: 
// Module Name: sevenseg
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


module sevenseg(
    input [3:0] num,
    output reg a,
    output reg b,
    output reg c,
    output reg d,
    output reg e,
    output reg f,
    output reg g
    );
    
    reg [6:0] segleds;
    
    always @ * begin
        case (num)
            4'd0: segleds = 7'b1111110;
            4'd1: segleds = 7'b0110000;
            4'd2: segleds = 7'b1101101;
            4'd3: segleds = 7'b1111001;
            4'd4: segleds = 7'b0110011;
            4'd5: segleds = 7'b1011011;
            4'd6: segleds = 7'b1011111;
            4'd7: segleds = 7'b1110000;
            4'd8: segleds = 7'b1111111;
            4'd9: segleds = 7'b1110011;
            4'd10: segleds = 7'b1110111;
            4'd11: segleds = 7'b0011111;
            4'd12: segleds = 7'b1001110;
            4'd13: segleds = 7'b0111101;
            4'd14: segleds = 7'b1001111;
            4'd15: segleds = 7'b1000111;
        endcase
        
        a = !segleds[6];
        b = !segleds[5];
        c = !segleds[4];
        d = !segleds[3];
        e = !segleds[2];
        f = !segleds[1];
        g = !segleds[0];
        
    end
endmodule
