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

    A = 8'd5; B = 8'd3; c_in = 0;
    #2;
    assert (sum == 8'd8) 
    else $error("Test Failed: %d + %d + %d != %d", A, B, c_in, sum);

    #10 A = 8'd30; B = -8'd10; c_in = 0;
    #10 A = 8'd5; B = -8'd10; c_in = 1;
    #10 A = 8'd127; B = 8'd1; c_in = 0;

    repeat (10) begin
        #10;
        c_in = (c_in + 1) % 2;  // Alternate between 0 and 1
        A = (A + 17) % 256 - 128;  // Pseudo-random cycling
        B = (B - 23) % 256 - 128;  // Pseudo-random cycling

        #1; // Wait for values to propagate

        assert ({c_out, sum} == A + B + c_in) 
        else $error("Test Failed: %d + %d + %d != {%d,%d}", A, B, c_in, c_out, sum);
    end
end

endmodule
