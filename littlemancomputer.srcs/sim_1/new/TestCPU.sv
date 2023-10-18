`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.10.2023 09:26:43
// Design Name: 
// Module Name: TestCPU
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


module TestCPU(
    );
    localparam CLK_PERIOD = 10;
    localparam EN_PERIOD = 100;
    
    reg clk;
    initial clk =1'b0;
    
    always #(CLK_PERIOD/2.0)
        clk = ~clk;
        
    reg en;
    initial en = 1'b0;
    always #(EN_PERIOD/2.0)
        en = ~en;
    
    reg a,b,c,d,e,f,g;
    initial begin 
        #10 a <= 0; 
        #10 b <= 0; 
        #10 c <= 0; 
        #10 d <= 0; 
        #10 e <= 0; 
        #10 f <= 0; 
        #10 g <= 0;
    end
    
    main M1(clk, en,a,b,c,d,e,f,g);

    
endmodule
