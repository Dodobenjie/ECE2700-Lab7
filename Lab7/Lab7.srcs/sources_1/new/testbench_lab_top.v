`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2026 10:45:41 AM
// Design Name: 
// Module Name: testbench_lab_top
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

module tb_lab_top;

    reg [15:0] sw;
    reg        btnC;
    wire [15:0] led;

    integer errors;
    integer tests;

    lab_top uut (
        .sw(sw),
        .btnC(btnC),
        .led(led)
    );

    task check_board;
        input [2:0]  mode;
        input [12:0] controls;
        input        button;
        input [15:0] expected;

        begin
            sw = {mode, controls};
            btnC = button;
            #10;

            tests = tests + 1;

            if (led !== expected) begin
                errors = errors + 1;

                $display(
                    "FAIL mode=%b controls=%h button=%b led=%h expected=%h",
                    mode, controls, button, led, expected
                );
            end
        end
    endtask

    initial begin
        sw = 0;
        btnC = 0;
        errors = 0;
        tests = 0;

        // Mode 000: 2-to-1 MUX.
        check_board(3'b000, 13'h002, 0, 16'h0000);
        check_board(3'b000, 13'h006, 0, 16'h0001);

        // Mode 001: 4-to-1 MUX, data = 1010.
        check_board(3'b001, 13'h00A, 0, 16'h0000);
        check_board(3'b001, 13'h01A, 0, 16'h0001);
        check_board(3'b001, 13'h02A, 0, 16'h0000);
        check_board(3'b001, 13'h03A, 0, 16'h0001);

        // Mode 010: 3-to-8 decoder.
        check_board(3'b010, 13'h008, 0, 16'h0001);
        check_board(3'b010, 13'h00B, 0, 16'h0008);
        check_board(3'b010, 13'h00F, 0, 16'h0080);
        check_board(3'b010, 13'h000, 0, 16'h0000);
        check_board(3'b010, 13'h007, 0, 16'h0000);

        // Mode 011: 4-to-16 decoder.
        check_board(3'b011, 13'h010, 0, 16'h0001);
        check_board(3'b011, 13'h018, 0, 16'h0100);
        check_board(3'b011, 13'h01F, 0, 16'h8000);
        check_board(3'b011, 13'h00F, 0, 16'h0000);

        // Mode 100: decoder-controlled data choice.
        check_board(3'b100, 13'h08A, 0, 16'h0001);
        check_board(3'b100, 13'h09A, 0, 16'h0102);
        check_board(3'b100, 13'h0BA, 0, 16'h0108);
        check_board(3'b100, 13'h0CA, 0, 16'h0010);
        check_board(3'b100, 13'h03A, 0, 16'h0000);

        // Mode 101: MUX viewing decoder outputs.
        check_board(3'b101, 13'h02A, 0, 16'h0104);
        check_board(3'b101, 13'h01A, 0, 16'h0004);
        check_board(3'b101, 13'h022, 0, 16'h0000);
        check_board(3'b101, 13'h03F, 0, 16'h0080);

        // Mode 110: custom status panel.
        // First address, selected data = 1, enabled.
        check_board(3'b110, 13'h21A, 0, 16'h0101);

        // Last address, selected data = 1, enabled.
        check_board(3'b110, 13'h3FA, 0, 16'h0180);

        // Selected data = 0, enabled.
        check_board(3'b110, 13'h3EA, 0, 16'h0000);

        // Disabled panel; raw selected-data LED remains on.
        check_board(3'b110, 13'h1FA, 0, 16'h0100);

        // All data zero.
        check_board(3'b110, 13'h200, 0, 16'h0000);

        // Mode 111: button-controlled MUX.
        check_board(3'b111, 13'h002, 0, 16'h0000);
        check_board(3'b111, 13'h002, 1, 16'h0001);
        check_board(3'b111, 13'h002, 0, 16'h0000);

        if (errors == 0)
            $display("ALL BOARD TESTS PASS: %0d tests", tests);
        else
            $display("BOARD TESTS FAILED: %0d errors", errors);

        $finish;
    end

endmodule