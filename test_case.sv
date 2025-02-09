module test_case;
  // DUT ports
  logic signed [7:0] a;
  wire signed [15:0] a1;
  wire [15:0] a2;

  // Assignments
  assign a1 = a;
  assign a2 = {8{a[7]}, a}; // Sign extension using the MSB of `a`

  // Testbench variables
  logic [7:0] test_data; // Holds test cases for `a`
  integer i;

  initial begin
    // Display header
    $display("Time\t a (signed) \t a1 (sign-extended) \t a2 (manual extension) \t Match?");
    $display("---------------------------------------------------------------");

    // Apply test cases
    for (i = -128; i <= 127; i++) begin
      test_data = i[7:0]; // Apply signed value
      a = test_data;      // Assign to `a`
      #1;                 // Wait for propagation

      // Compare `a1` and `a2`
      if (a1 === a2) begin
        $display("%0t\t %0d \t\t %0d \t\t\t %0d \t\t\t YES", $time, a, a1, a2);
      end else begin
        $display("%0t\t %0d \t\t %0d \t\t\t %0d \t\t\t NO", $time, a, a1, a2);
      end
    end

    // Finish simulation
    $finish;
  end
endmodule
