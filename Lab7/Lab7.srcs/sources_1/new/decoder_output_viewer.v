`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2026 10:40:46 AM
// Design Name: 
// Module Name: decoder_output_viewer
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


module decoder_output_viewer (
    input  wire [2:0] address,
    input  wire       en,
    input  wire [1:0] sel,
    output wire [7:0] decoded_lines,
    output wire       viewed_output
);

    decoder3to8 decoder (
        .d(address),
        .en(en),
        .y(decoded_lines)
    );

    mux4 viewer (
        .i0(decoded_lines[0]),
        .i1(decoded_lines[1]),
        .i2(decoded_lines[2]),
        .i3(decoded_lines[3]),
        .sel(sel),
        .out(viewed_output)
    );

endmodule