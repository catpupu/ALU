`timescale 1ns/1ns
module ALUControl( clk, Signal, SignaltoALU, SignaltoSHT, SignaltoDIV, SignaltoMUX );

    input clk ;
    input [5:0] Signal ;
    output [5:0] SignaltoALU ;
    output [5:0] SignaltoSHT ;
    output [5:0] SignaltoDIV ;
    output [5:0] SignaltoMUX ;

    reg [5:0] temp;
    reg [6:0] counter;

    parameter AND = 6'b100100;
    parameter OR  = 6'b100101;
    parameter ADD = 6'b100000;
    parameter SUB = 6'b100010;
    parameter SLT = 6'b101010;

    parameter SLL = 6'b000000;

    parameter DIVU= 6'b011011;
    parameter MFHI= 6'b010000;
    parameter MFLO= 6'b010010;
    parameter OUT = 6'b111111;

    always@( Signal ) begin
        temp = Signal;
        if ( Signal == DIVU )
            counter = 0 ;
    end

    always@( posedge clk ) begin
        if ( Signal == DIVU ) begin
            counter = counter + 1 ;
            if ( counter == 33 ) begin
                temp = OUT ; // Open HiLo reg for Div
                counter = 0 ;
            end
        end
    end

    assign SignaltoALU = temp ;
    assign SignaltoSHT = temp ;
    assign SignaltoDIV = temp ;
    assign SignaltoMUX = temp ;

endmodule