`timescale 1ns / 1ps

module debounce(
    input clk, b_in,
    output b_out
    );

    // sync button to clock
    reg b1=1'b0, b2=1'b0;
    always @(posedge clk) begin
      b1 <= b_in;
      b2 <= b1;
    end
    wire b_synced = b2;

    reg [15:0] b_history = 16'h0000;
    reg b_edge = 1'b0;
    
    always @(posedge clk) begin
        // debounced edge detection on button
        b_history <= { b_history[14:0] , b_synced };
        if (b_history == 16'b0011111111111111)
            b_edge <= 1'b1;
          else
            b_edge <= 1'b0;
                
        
        
    end
    assign b_out = b_edge;
    
endmodule
