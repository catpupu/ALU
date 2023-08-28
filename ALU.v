`timescale 1ns/1ns
module ALU( dataA, dataB, Signal, dataOut, reset );

    input [31:0]  dataA, dataB ;
    input [5:0]   Signal ;
    input reset ;

    output [31:0] dataOut ;

    wire reg [31:0] ALUOut, C;
    wire inv;
    
    parameter SUB = 6'b100010; // 34
    parameter SLT = 6'b101010; // 42
    
    assign inv = (Signal == SUB || Signal == SLT);
    
    genvar i;
    ALU_Slice slice( .a(dataA[0]), .b(dataB[0]), .cin(inv), .cout(C[0]), .Signal(Signal), .out(ALUOut[0]), .inv(inv) );
    for(i = 1 ; i<32 ; i=i+1)
        ALU_Slice slice( .a(dataA[i]), .b(dataB[i]), .cin(C[i-1]), .cout(C[i]), .Signal(Signal), .out(ALUOut[i]), .inv(inv) );

    assign dataOut = (reset == 1 ? 32'b0 : Signal == SLT ? {31'b0, ALUOut[31]} : ALUOut);
endmodule