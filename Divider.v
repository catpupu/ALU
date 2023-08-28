`timescale 1ns/1ns
module Divider( clk, dataA, dataB, Signal, dataOut, reset );

    input clk ;
    input reset ;
    input [31:0] dataA ;
    input [31:0] dataB ;
    input [5:0] Signal ;
    output [63:0] dataOut ;

    reg [63:0] temp ;

    parameter DIVU = 6'b011011;
    parameter OUT = 6'b111111;

    always@( Signal ) begin
        if ( Signal == OUT ) 
            temp <= (temp >> 1);
        if ( Signal == DIVU )
            temp = {31'b0, dataA, 1'b0};
    end

    always@( posedge clk or reset ) begin

        if ( reset )
            temp = 64'b0 ;
        if ( Signal == DIVU ) begin
            temp[63:32] = temp[63:32] - dataB;
            temp[0] = temp[63] ^ 1;
            if(temp[63] == 1)
                temp[63:32] = temp[63:32] + dataB;
            //temp = {temp[62:0], 1'b0};
            temp = temp << 1;
        end
    end

    assign dataOut = temp;

endmodule