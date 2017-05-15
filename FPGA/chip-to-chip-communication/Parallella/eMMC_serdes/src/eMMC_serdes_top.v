`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2017 01:20:23 PM
// Design Name: 
// Module Name: eMMC_serdes_top
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


module eMMC_serdes_top
#(
        parameter       TX_CLOCK = "BUF_G" ,   		// Parameter to set transmission clock buffer type, BUFIO, BUF_H, BUF_G
        parameter       DIV_CLOCK = "BUF_G" ,          	// Parameter to set intermediate clock buffer type, BUFR, BUF_H, BUF_G
	    parameter 		FBOUT_CLOCK = "BUF_G"		// Parameter to set final clock buffer type, BUF_R, BUF_H, BUF_G
)(
        
        input   wire    pll_rst,
        input   wire    pll_clkin,
        input   wire    rst,
        input   wire    clkin_p,
        input   wire    clkin_n,
        input   wire    datain_p,
        input   wire    datain_n,
        input   wire    cmd_o,
        input   wire    cmd_t,
        input   wire    sd_dat_t,
        input   wire [7:0]   sd_dat_o,
        
        
        output  wire    cmd_i,
        output  wire [7:0]    sd_dat_i,
        output  wire    clkout_p,
        output  wire    clkout_n,
        output  wire    dataout_p,
        output  wire    dataout_n,
        
	    output wire clk_div
);
    eMMC_serdes eMMC_serdes_ins(
        .pll_rst(pll_rst),
        .pll_clkin(pll_clkin),
        .rst(rst),
        .clkin_p(clkin_p),
        .clkin_n(clkin_n),
        .datain_p(datain_p),
        .datain_n(datain_n),
        .cmd_o(cmd_o),
        .cmd_t(cmd_t),
        .sd_dat_t(sd_dat_t),
        .sd_dat_o(sd_dat_o),
        .cmd_i(cmd_i),
        .sd_dat_i(sd_dat_i),
        .clkout_p(clkout_p),
        .clkout_n(clkout_n),
        .dataout_p(dataout_p),
        .dataout_n(dataout_n),
        .clk_div(clk_div)
        );
        
    fifo_18kb fifo_18kb_inst(
        .aclk           (txclk_div),
        .sd_clk         (SD_clk),
        .rst            (rst),
        .axi_data_in    (write_dat_fifo),
        .sd_data_in     (data_in_rx_fifo),
        .sd_data_out    (data_out_tx_fifo),
        .axi_data_out   (read_fifo_out),
        .sd_rd_en       (rd_fifo),
        .axi_rd_en      (fifo_data_read_ready),
        .axi_wr_en      (fifo_data_write_ready),
        .sd_wr_en       (we_fifo),
        .sd_full_o      ()
        );

endmodule