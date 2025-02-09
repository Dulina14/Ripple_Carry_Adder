module full_adder (
    input logic a,
    input logic b,
    input logic c_in,
    output logic sum,
    output logic c_out
);

logic wire_1, wire_2;

assign wire_1 = a ^ b;
assign wire_2 = wire_1 & c_in;

wire wire_3 = a & b;

always_comb begin  
    c_out = wire_2 | wire_3;
    sum = wire_1 ^ c_in;
    
end
    
endmodule

`timescale 1ns/1ps;
module full_adder_tb;

// Inputs
logic a=0, c_in=0, b, sum, c_out;

full_adder dut (.*);

initial begin
    $dumpfile("full_adder_tb.vcd");
    $dumpvars(0, full_adder_tb);

    #30 a<=0; b<=0; c_in<=0;
    #10 a<=0; b<=0; c_in<=1;

    #20 a<=1; b<=1 ; c_in<=0;

    #1 assert ({c_out, sum} == a+b+c_in)
    Concat $display("Test Passed");

     else   $error("Test Failed");

     #10 a<=1; b<=1; c_in<=1;

     #1 assert ({dut.wire_1} == 0)
     else $error("False. wire_1 :%d", dut.wire_1);
    
    $finish;
end

endmodule

module N_bit_adder #(parameter N=4) (
    input logic signed [N-1:0] A,B,
    input logic c_in,
    output logic signed [N-1:0] sum,
    output logic c_out
);

logic C [N:0];
assign C[0] = c_in;
assign c_out = C[N] ;

genvar i;
for (i=0; i<N; i=i+1) begin:add
// full_adder fa (A[i], B[i], C[i], sum[i], C[i+1]);

full_adder fa (
    .a(A[i]),
    .b(B[i]),
    .c_in(C[i]),
    .sum(sum[i]),
    .c_out(C[i+1])
);

end

endmodule

module N_bit_adder_tb;

timeunit 1ns;
timeprecision 1ps;

localparam  N = 8;

logic signed [N-1:0] A, B, sum;
logic c_in, c_out;

N_bit_adder #(.N(N)) dut(.*);

initial begin
$dumpfile("N_bit_adder_tb.vcd");
$dumpvars(0, N_bit_adder_tb);

A <= 8'd5; B <= 8'd3; c_in <= 0;
#assert (S == 8'd8) else $error("Test Failed");

#10 A <= 8'd30; B <= -8'd10; c_in <= 0;
#10 A <= 8'd5; B <= -8'd10; c_in <= 1;
#10 A <= 8'd127; B <= 8'd1; c_in <= 0;

repeat(10) begin
    #9
    std::randomize(c_in);
    std::randomize(A) with {A inside {[-128:127]};};
    std::randomize(B) with {B inside {[-128:127]};};
    #1;

    assert ({c_out, sum} == A+B+c_in) 
    else $error("%d + %d + %d != {%d,%d}", A, B, c_in, c_out, sum);

end
end

endmodule