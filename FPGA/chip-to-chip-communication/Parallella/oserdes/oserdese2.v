`timescale 1ns / 1ps

module oserdese2 #(
    parameter data_rate_oq = "SDR",
    parameter data_rate_tq = "SDR",
    parameter serdes_mode  = "MASTER",
    parameter integer data_width = 8,
    parameter integer tristate_width = 1
)
(
    input  wire [7:0] d,
    input  wire oce,
    output wire oq,
//    output wire ofb,
    input  wire clk,
    input  wire clkdiv,
    input  wire rst
);


//assign D = {D8,D7,D6,D5,D4,D3,D2,D1};

//  OSERDESE2: Output SERial/DESerializer with bitslip
//  7 Series
//  Xilinx HDL Libraries Guide, version 14.7
OSERDESE2 #(
    .DATA_RATE_OQ(data_rate_oq),           // DDR, SDR
    .DATA_RATE_TQ(data_rate_tq),           // DDR, BUF, SDR
    .DATA_WIDTH(data_width),        // Parallel data width (2-8,10,14)
    .INIT_OQ(1'b1),                 // Initial value of OQ output (1'b0,1'b1)
    .INIT_TQ(1'b1),                 // Initial value of TQ output (1'b0,1'b1)
    .SERDES_MODE(serdes_mode),         // MASTER, SLAVE
    .SRVAL_OQ(1'b1),                // OQ output value when SR is used (1'b0,1'b1)
    .SRVAL_TQ(1'b1),                // TQ output value when SR is used (1'b0,1'b1)
    .TBYTE_CTL("FALSE"),            // Enable tristate byte operation (FALSE, TRUE)
    .TBYTE_SRC("FALSE"),            // Tristate byte source (FALSE, TRUE)
    .TRISTATE_WIDTH(tristate_width) // 3-state converter width (1,4)
)
OSERDESE2_inst (
    .OFB(ofb),                      // 1-bit output: Feedback path for data
    .OQ(oq),                        // 1-bit output: Data path output
    // SHIFTOUT1 / SHIFTOUT2: 1-bit (each) output: Data output expansion (1-bit each)
    .SHIFTOUT1(SHIFTOUT1),
    .SHIFTOUT2(SHIFTOUT2),
    .TBYTEOUT(TBYTEOUT),            // 1-bit output: Byte group tristate
    .TFB(TFB),                      // 1-bit output: 3-state control
    .TQ(TQ),                        // 1-bit output: 3-state control
    .CLK(clk),                      // 1-bit input: High speed clock
    .CLKDIV(clkdiv),                // 1-bit input: Divided clock
    // D1 - D8: 1-bit (each) input: Parallel data inputs (1-bit each)
    .D1(d[0]),
    .D2(d[1]),
    .D3(d[2]),
    .D4(d[3]),
    .D5(d[4]),
    .D6(d[5]),
    .D7(d[6]),
    .D8(d[7]),
    .OCE(1'b1),                      // 1-bit input: Output data clock enable
    .RST(!rst),                      // 1-bit input: Reset
    // SHIFTIN1 / SHIFTIN2: 1-bit (each) input: Data input expansion (1-bit each)
    .SHIFTIN1(SHIFTIN1),
    .SHIFTIN2(SHIFTIN2),
    // T1 - T4: 1-bit (each) input: Parallel 3-state inputs
    .T1(T1),
    .T2(T2),
    .T3(T3),
    .T4(T4),
    .TBYTEIN(TBYTEIN),              // 1-bit input: Byte group tristate
    .TCE(TCE)                       // 1-bit input: 3-state clock enable
);

endmodule