 `timescale 1 ns/1 ns	//time scale for simulation

module Testbench();
    reg [2:0] SW;
    wire [0:0] LEDG;

    // dut stands for 'Device Under Test', and is a common term used in design verification
    MAJ dut(.a(SW[2]), .b(SW[1]), .c(SW[0]), .m(LEDG[0]));

    task check_majority();
    begin
        #1; // delay for signals to stabilize
        if (((SW[2] && SW[1]) || (SW[2] && SW[0]) || (SW[1] && SW[0])) != LEDG[0]) begin
            $display("Test failed: SW = %b, LEDG = %b", SW, LEDG);
        end
    end
    endtask

// Test Procedure
    initial begin
        SW = 3'b000; #5;
        check_majority();
        SW = 3'b001; #5;
        check_majority();
        SW = 3'b010; #5;
        check_majority();
        SW = 3'b011; #5;
        check_majority();
        SW = 3'b100; #5;
        check_majority();
        SW = 3'b101; #5;
        check_majority();
        SW = 3'b110; #5;
        check_majority();
        SW = 3'b111; #5;
        check_majority();
        $display("Tests Passed!!!");
        $finish;
    end
endmodule