`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2026 10:40:17 AM
// Design Name: 
// Module Name: decoder_data_choice
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


module decoder_data_choice (
    input  wire [3:0] data,
    input  wire [2:0] address,
    input  wire       en,
    output wire [7:0] decoded_lines,
    output wire       selected_data
);

    decoder3to8 decoder (
        .d(address),
        .en(en),
        .y(decoded_lines)
    );

    assign selected_data =
        (decoded_lines[0] & data[0]) |
        (decoded_lines[1] & data[1]) |
        (decoded_lines[2] & data[2]) |
        (decoded_lines[3] & data[3]);

endmodule
