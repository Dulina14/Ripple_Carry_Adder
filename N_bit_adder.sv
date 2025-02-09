module N_bit_adder #(parameter N=8) (
    input logic signed [N-1:0] A, B,
    input logic c_in,
    output logic signed [N-1:0] sum,
    output logic c_out
);

logic [N:0] C;  // Use packed array instead of logic array
assign C[0] = c_in;
assign c_out = C[N];

generate
    genvar i;
    for (i = 0; i < N; i = i + 1) begin : add
        full_adder fa (
            .a(A[i]),
            .b(B[i]),
            .c_in(C[i]),
            .sum(sum[i]),
            .c_out(C[i+1])
        );
    end
endgenerate

endmodule

