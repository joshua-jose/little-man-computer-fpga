`timescale 1ns / 1ps

module ram
    # (
        parameter SIZE = 100
    )
    
    (
    input clk, 
    input [7:0] addr_bus, 
    output [11:0] data_read_bus,
    input [11:0] data_write_bus,
    input we, re
    
    );

    reg [11:0] cache;
    reg [11:0] data [SIZE:0];

    initial $readmemh("ram_init.mem", data); // load RAM initial state

    // 4 MSBs multplied by 10, 4 LSBs then added to that value
    // conversion of BCD to binary
    wire [7:0] addr = (addr_bus[7:4] * 10) + addr_bus[3:0];

    always @ (negedge clk) begin
        if (re & !we) begin
            cache <= data[addr];
        end
        
        if (we & !re) begin
            data[addr] <= data_write_bus;
        end
    end

    // If read enable goes low then output becomes high impedance
    // assign data_read_bus = re ? cache : 'bz;
    assign data_read_bus = cache;

endmodule
