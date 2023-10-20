`timescale 1ns / 1ps

module alu
    (
    input clk,
    input [11:0] operand_1, // bcd
    input [11:0] operand_2, // bcd
    input op, // 0 for add, 1 for sub
    output [11:0] result
    
    );

    wire carry0, carry1, carry2, carry3;
    wire [11:0] sum;
    reg [11:0] result_cache;

    assign carry0 = 0;

    bcd_adder A1(operand_1[3:0], operand_2[3:0], carry0, sum[3:0], carry1);
    bcd_adder A2(operand_1[7:4], operand_2[7:4], carry1, sum[7:4], carry2);
    bcd_adder A3(operand_1[11:8], operand_2[11:8], carry2, sum[11:8], carry3);

    always @(negedge clk) begin
        if (op == 0)
            result_cache <= sum;
    end

    assign result = result_cache;


endmodule


module bcd_adder(
    input [3:0] a,b,
    input carry_in,
    output [3:0] sum,
    output carry
    );
    reg [4:0] sum_temp;
    reg carry_temp;
    
    always @(a,b,carry_in)
    begin
        sum_temp = a+b+carry_in; //add all the inputs
        if(sum_temp > 9) begin
            sum_temp = sum_temp+6; //add 6, if result is more than 9.
            carry_temp = 1;  //set the carry output
        end
        else begin
            carry_temp = 0;
        end
    end     

    assign carry = carry_temp;
    assign sum = sum_temp[3:0];

endmodule