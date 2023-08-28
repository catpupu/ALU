`timescale 1ns/1ns
module HiLo( clk, DivAns, HiOut, LoOut, reset );

    input clk, reset ;
    input [63:0] DivAns ;
    output [31:0] HiOut, LoOut ;
    reg [63:0] REM;
    
    always@( posedge clk or reset )
        REM = reset ? 64'b0 : DivAns;

    assign HiOut = REM[63:32];
    assign LoOut = REM[31:0];
  
endmodule