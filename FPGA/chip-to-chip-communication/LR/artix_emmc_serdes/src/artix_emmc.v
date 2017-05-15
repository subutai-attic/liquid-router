`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2017 10:00:17 AM
// Design Name: 
// Module Name: artix_emmc
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


module artix_emmc#(
    parameter         	  TX_CLOCK = "BUF_G" ,       // Parameter to set transmission clock buffer type, BUFIO, BUF_H, BUF_G
    parameter             DIV_CLOCK = "BUF_G",       // Parameter to set intermediate clock buffer type, BUFR, BUF_H, BUF_G
    parameter             FBOUT_CLOCK = "BUF_G"     // Parameter to set final clock buffer type, BUF_R, BUF_H, BUF_G
    )(
      input   wire    rst,
      input   wire    clkin_p,
      input   wire    clkin_n,
      input   wire    datain_p,
      input   wire    datain_n,
      input   wire    cmd_i,
      input   wire [7:0]    sd_dat_i,
      input   wire    sd_clkin,

      output   wire   SD_clk,
      output   wire   cmd_o,
      output   wire   cmd_t,
      output   wire [7:0]   sd_dat_o,
      output   wire [7:0]   sd_dat_t,
      output   wire    clkout_p,
      output   wire    clkout_n,
      output   wire    dataout_p,
      output   wire    dataout_n
    );

    artix_emmc_serdes artix_emmc_serdes_ins(
        .rst(rst),
        .clkin_p(clkin_p),
        .clkin_n(clkin_n),
        .datain_p(datain_p),
        .datain_n(datain_n),
        .cmd_i(cmd_i),
        .sd_dat_i(sd_dat_i),
        .sd_clkin(sd_clkin),
        .SD_clk(SD_clk),
        .cmd_o(cmd_o),
        .cmd_t(cmd_t),
        .sd_dat_o(sd_dat_o),
        .sd_dat_t(sd_dat_t),
        .clkout_p(clkout_p),
        .clkout_n(clkout_n),
        .dataout_p(dataout_p),
        .dataout_n(dataout_n),
        .txclk_div(txclk_div)
        
    );

//    fifo_18kb fifo_18kb_inst(
//        .aclk           (txclk_div),
//        .sd_clk         (SD_clk),
//        .rst            (rst),
//        .axi_data_in    (write_dat_fifo),
//        .sd_data_in     (data_in_rx_fifo),
//        .sd_data_out    (data_out_tx_fifo),
//        .axi_data_out   (read_fifo_out),
//        .sd_rd_en       (rd_fifo),
//        .axi_rd_en      (fifo_data_read_ready),
//        .axi_wr_en      (fifo_data_write_ready),
//        .sd_wr_en       (we_fifo),
//        .sd_full_o      ()
//    );
endmodule
