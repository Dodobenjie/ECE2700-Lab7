`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2026 10:33:18 AM
// Design Name: 
// Module Name: decoder4to16
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


module decoder4to16 (
    input  wire [3:0]  d,
    input  wire        en,
    output wire [15:0] y
);

    wire lower_enable;
    wire upper_enable;

    wire [7:0] lower_outputs;
    wire [7:0] upper_outputs;

    assign lower_enable = en & ~d[3];
    assign upper_enable = en &  d[3];

    decoder3to8 lower_decoder (
        .d(d[2:0]),
        .en(lower_enable),
        .y(lower_outputs)
    );

    decoder3to8 upper_decoder (
        .d(d[2:0]),
        .en(upper_enable),
        .y(upper_outputs)
    );

    assign y = {upper_outputs, lower_outputs};

endmodule