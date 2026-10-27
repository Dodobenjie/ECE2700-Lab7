`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2026 10:41:26 AM
// Design Name: 
// Module Name: status_panel
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


module status_panel (
    input  wire [3:0] data,
    input  wire [1:0] sel,
    input  wire [2:0] address,
    input  wire       en,
    output wire       selected_data,
    output wire [7:0] panel_leds
);

    wire panel_enable;

    mux4 selector (
        .i0(data[0]),
        .i1(data[1]),
        .i2(data[2]),
        .i3(data[3]),
        .sel(sel),
        .out(selected_data)
    );

    assign panel_enable = en & selected_data;

    decoder3to8 panel_decoder (
        .d(address),
        .en(panel_enable),
        .y(panel_leds)
    );

endmodule
