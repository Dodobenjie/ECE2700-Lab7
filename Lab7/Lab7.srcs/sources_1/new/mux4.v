`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2026 10:30:40 AM
// Design Name: 
// Module Name: mux4
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


module mux4 (
    input  wire       i0,
    input  wire       i1,
    input  wire       i2,
    input  wire       i3,
    input  wire [1:0] sel,
    output wire       out
);

    wire low_pair;
    wire high_pair;

    mux2 mux_a (
        .i0(i0),
        .i1(i1),
        .sel(sel[0]),
        .out(low_pair)
    );

    mux2 mux_b (
        .i0(i2),
        .i1(i3),
        .sel(sel[0]),
        .out(high_pair)
    );

    mux2 mux_c (
        .i0(low_pair),
        .i1(high_pair),
        .sel(sel[1]),
        .out(out)
    );

endmodule
