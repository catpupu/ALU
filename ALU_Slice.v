  `timescale 1ns/1ns
module ALU_Slice( a, b, cin, cout, inv, Signal, out );

    input a, b, cin, inv;
    input [5:0] Signal;
    output cout, out;

    wire and_out, or_out, fa_out;
    wire bx, e1, e2, e3;
    
    parameter AND = 6'b100100; // 36
    parameter OR  = 6'b100101; // 37
    parameter ADD = 6'b100000; // 32
    parameter SUB = 6'b100010; // 34
    parameter SLT = 6'b101010; // 42

    and (and_out, a, b);
    or (or_out, a, b);
    xor (bx, b, inv);
    
    // Full Adder
    xor (e1, a, bx);
    and (e2, a, bx);
    and (e3, e1, cin);
    or (cout, e2, e3);
    xor (fa_out, e1, cin);

    assign out = (Signal == AND ? and_out : Signal == OR ? or_out : fa_out);

endmodule