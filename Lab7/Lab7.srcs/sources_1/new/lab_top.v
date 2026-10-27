`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2026 10:42:04 AM
// Design Name: 
// Module Name: lab_top
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


module lab_top (
    input  wire [15:0] sw,
    input  wire        btnC,
    output reg  [15:0] led
);

    wire mux2_result;
    wire mux4_result;
    wire button_result;

    wire [7:0]  decoder3_result;
    wire [15:0] decoder4_result;

    wire [7:0] choice_lines;
    wire       choice_result;

    wire [7:0] viewer_lines;
    wire       viewer_result;

    wire [7:0] panel_lines;
    wire       panel_selected;

    mux2 demo_mux2 (
        .i0(sw[0]),
        .i1(sw[1]),
        .sel(sw[2]),
        .out(mux2_result)
    );

    mux4 demo_mux4 (
        .i0(sw[0]),
        .i1(sw[1]),
        .i2(sw[2]),
        .i3(sw[3]),
        .sel(sw[5:4]),
        .out(mux4_result)
    );

    decoder3to8 demo_decoder3 (
        .d(sw[2:0]),
        .en(sw[3]),
        .y(decoder3_result)
    );

    decoder4to16 demo_decoder4 (
        .d(sw[3:0]),
        .en(sw[4]),
        .y(decoder4_result)
    );

    decoder_data_choice demo_choice (
        .data(sw[3:0]),
        .address(sw[6:4]),
        .en(sw[7]),
        .decoded_lines(choice_lines),
        .selected_data(choice_result)
    );

    decoder_output_viewer demo_viewer (
        .address(sw[2:0]),
        .en(sw[3]),
        .sel(sw[5:4]),
        .decoded_lines(viewer_lines),
        .viewed_output(viewer_result)
    );

    status_panel demo_panel (
        .data(sw[3:0]),
        .sel(sw[5:4]),
        .address(sw[8:6]),
        .en(sw[9]),
        .selected_data(panel_selected),
        .panel_leds(panel_lines)
    );

    mux2 demo_button (
        .i0(sw[0]),
        .i1(sw[1]),
        .sel(btnC),
        .out(button_result)
    );

    always @* begin
        led = 16'b0;

        case (sw[15:13])
            3'b000: led[0] = mux2_result;

            3'b001: led[0] = mux4_result;

            3'b010: led[7:0] = decoder3_result;

            3'b011: led = decoder4_result;

            3'b100: begin
                led[7:0] = choice_lines;
                led[8] = choice_result;
            end

            3'b101: begin
                led[7:0] = viewer_lines;
                led[8] = viewer_result;
            end

            3'b110: begin
                led[7:0] = panel_lines;
                led[8] = panel_selected;
            end

            3'b111: led[0] = button_result;

            default: led = 16'b0;
        endcase
    end

endmodule
