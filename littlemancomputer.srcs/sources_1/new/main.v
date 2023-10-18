`timescale 1ns / 1ps

// Contains the core logic for the CPU (Control Unit)
module main(
    input clk, en,
    output a,b,c,d,e,f,g
    );

   reg [7:0] pc; // program counter
   reg [3:0] ir; // instruction register
   reg [7:0] ar; // address register
   reg [11:0] ac; // accumulator

   reg  [7:0] addr_bus; // address buss
   reg [11:0] data_write_bus; // write to memory
   wire [11:0] data_read_bus; // read from memory

   reg we; // ram write enable
   reg re; // ram read enable

   ram ram1(clk, addr_bus, data_read_bus, data_write_bus, we, re);
    
   wire [3:0] num;
   wire en_edge;

   sevenseg U1(num, a,b,c,d,e,f,g);
   debounce U2(clk, en, en_edge);

   initial begin
       pc <= 0;
       ir <= 0;
       ar <= 0;
       ac <= 0;
       re <= 0;
       we <= 0;
   end

    reg [3:0] state; // Control Unit state (to progress through fetch-decode-execute cycle)
    initial state <= 0;

    reg running;
    initial running <= 1;
    
    always @(posedge clk) begin
//       if (en_edge & running) begin
        if (running) begin
            // fetch
           if (state == 0) begin
               
               addr_bus <= pc; // put the PC onto addr bus
                
               we <= 0;
               re <= 1; // ram read enable
           end

           if (state == 1) begin

               ir <= data_read_bus[11:8]; // load IR
               ar <= data_read_bus[7:0]; // load AR
                
               re <= 0;

                
               // TODO: use ALU
               // increment PC using BCD counting
               pc[3:0] <= pc[3:0] + 4'd1;
               if (pc[3:0] >= 4'd9) begin
                    pc[7:4] <= pc[7:4] + 4'd1;
                    pc[3:0] <= 4'd0;
               end  
           end


           // decode
           // execute

           if (state == 2) begin
                case (ir)
                    4'd0: running <= 0; // HLT
                    4'd3: begin // STA
                       addr_bus <= ar; // Write to address in address register
                       data_write_bus <= ac; // Put accumulator on data bus
                       
                       we <= 1;
                       re <= 0; 
                    end
                    4'd5: begin // LDA
                       addr_bus <= ar; // Read from address in address register
                       we <= 0;
                       re <= 1; 
                    end
                endcase
           end

           if (state == 3) begin
                case (ir)
                    4'd3: begin // STA
                        we <= 0; // disable writes
                    end
                    4'd5: begin // LDA
                       ac <= data_read_bus; // Store read address into accumulator
                       re <= 0; 
                    end
                endcase
           end

            state <= (state >= 3) ? 0 : state + 1;
        
      end 
    end

   assign num = ar[3:0];
    
endmodule
