`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2026 10:32:09 AM
// Design Name: 
// Module Name: testbench_building_blocks
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps

module testbench_building_blocks;

    reg [1:0] data2;
    reg       sel2;
    wire      out2;

    reg [3:0] data4;
    reg [1:0] sel4;
    wire      out4;

    reg [2:0] d3;
    reg       en3;
    wire [7:0] y3;

    reg [3:0] d4;
    reg       en4;
    wire [15:0] y4;

    reg [7:0]  expected3;
    reg [15:0] expected4;

    integer i;
    integer j;
    integer errors;
    integer tests;
    integer start_errors;

    mux2 uut_mux2 (
        .i0(data2[0]),
        .i1(data2[1]),
        .sel(sel2),
        .out(out2)
    );

    mux4 uut_mux4 (
        .i0(data4[0]),
        .i1(data4[1]),
        .i2(data4[2]),
        .i3(data4[3]),
        .sel(sel4),
        .out(out4)
    );

    decoder3to8 uut_decoder3 (
        .d(d3),
        .en(en3),
        .y(y3)
    );

    decoder4to16 uut_decoder4 (
        .d(d4),
        .en(en4),
        .y(y4)
    );

    task check;
        input [15:0] actual;
        input [15:0] expected;
        input [255:0] block_name;
        begin
            tests = tests + 1;

            if (actual !== expected) begin
                errors = errors + 1;

                $display(
                    "FAIL %0s: test=%0d actual=%h expected=%h",
                    block_name, tests, actual, expected
                );
            end
        end
    endtask

    initial begin
        errors = 0;
        tests = 0;

        data2 = 0;
        sel2 = 0;
        data4 = 0;
        sel4 = 0;
        d3 = 0;
        en3 = 0;
        d4 = 0;
        en4 = 0;
        expected3 = 0;
        expected4 = 0;

        // 2-to-1 MUX: 4 data patterns x 2 selections.
        start_errors = errors;

        for (i = 0; i < 4; i = i + 1) begin
            for (j = 0; j < 2; j = j + 1) begin
                data2 = i;
                sel2 = j;
                #10;

                check(
                    {15'b0, out2},
                    {15'b0, data2[sel2]},
                    "mux2"
                );
            end
        end

        if (errors == start_errors)
            $display("PASS mux2: 8 tests");

        // 4-to-1 MUX: 16 data patterns x 4 selections.
        start_errors = errors;

        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 4; j = j + 1) begin
                data4 = i;
                sel4 = j;
                #10;

                check(
                    {15'b0, out4},
                    {15'b0, data4[sel4]},
                    "mux4"
                );
            end
        end

        if (errors == start_errors)
            $display("PASS mux4: 64 tests");

        // 3-to-8 decoder: 8 addresses x 2 enable states.
        start_errors = errors;

        for (j = 0; j < 2; j = j + 1) begin
            for (i = 0; i < 8; i = i + 1) begin
                en3 = j;
                d3 = i;

                expected3 = 8'b0;
                if (en3)
                    expected3[i] = 1'b1;

                #10;

                check(
                    {8'b0, y3},
                    {8'b0, expected3},
                    "decoder3to8"
                );
            end
        end

        if (errors == start_errors)
            $display("PASS decoder3to8: 16 tests");

        // 4-to-16 decoder: 16 addresses x 2 enable states.
        start_errors = errors;

        for (j = 0; j < 2; j = j + 1) begin
            for (i = 0; i < 16; i = i + 1) begin
                en4 = j;
                d4 = i;

                expected4 = 16'b0;
                if (en4)
                    expected4[i] = 1'b1;

                #10;

                check(y4, expected4, "decoder4to16");
            end
        end

        if (errors == start_errors)
            $display("PASS decoder4to16: 32 tests");

        if (errors == 0)
            $display("ALL PASS: %0d tests", tests);
        else
            $display("FAILED: %0d errors in %0d tests",
                     errors, tests);

        $finish;
    end

endmodule