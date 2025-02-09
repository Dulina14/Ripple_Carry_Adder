`timescale 10ns/1ns
module full_adder_tb;

// Inputs
logic a = 0, b = 0, c_in = 0;
logic sum, c_out;

full_adder dut (.*);

initial begin
    #30 a <= 0; b <= 0; c_in <= 0;
    #10 a <= 0; b <= 0; c_in <= 1;
    #20 a <= 1; b <= 1; c_in <= 0;

    #1 assert ({c_out, sum} == a + b + c_in)
       begin 
           $display("Test Passed");
       end 
    else   
       $error("Test Failed");

   
    
    $finish;
end

endmodule
