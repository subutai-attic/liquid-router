`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/02/2015 11:41:32 AM
// Design Name: 
// Module Name: clock_divider
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


module sd_clock_divider(
    input wire AXI_CLOCK,
    output wire sd_clk,
    output wire sd_clk_high,
    input wire [7:0] DIVISOR,
    input AXI_RST,
    output reg Internal_clk_stable,
    output wire sd_clk90,
    output wire sd_clk_sel
    );

reg [11:0] clk_div;
reg SD_CLK_O;
reg [11:0] div;
reg SD_CLK_90;
reg SD_CLK_1;
reg [11:0] clk_div1;

localparam divisor0 = 12'h1f3;          // 200MHz
localparam divisor1 = 12'h07c;          // 800MHz

wire [11:0] sd_clk_divisor;
wire [11:0] sd_clk_divisor1;

assign sd_clk      = SD_CLK_O;
assign sd_clk90    = SD_CLK_90;
assign sd_clk_high = SD_CLK_1;

assign sd_clk_divisor  = DIVISOR == 8'h7d ? divisor0 : DIVISOR;
assign sd_clk_divisor1 = DIVISOR == 8'h7d ? divisor1 : DIVISOR;
assign sd_clk_sel      = DIVISOR == 8'h7d ? 1'b1 : 1'b0;


always @ (posedge AXI_CLOCK or posedge AXI_RST)
begin
 if (AXI_RST == 0) begin
    clk_div <=12'h000;
    SD_CLK_O  <= 1;
    Internal_clk_stable <= 1'b0;
 end
 else if (clk_div == sd_clk_divisor)begin
    clk_div  <= 0;
    SD_CLK_O <=  ~SD_CLK_O;
    Internal_clk_stable <= 1'b1;
 end 
 else begin
    clk_div  <= clk_div + 1;
    SD_CLK_O <=  SD_CLK_O;
    Internal_clk_stable <= 1'b1;
 end
end


always @ (negedge AXI_CLOCK or posedge AXI_RST)
begin
 if (AXI_RST == 0) begin
    div <=12'h000;
    SD_CLK_90  <= 1;
 end
 else if (div == sd_clk_divisor)begin
    div  <= 0;
    SD_CLK_90 <=  ~SD_CLK_90;
 end 
 else begin
    div  <= div + 1;
    SD_CLK_90 <=  SD_CLK_90;
 end
end


always @ (posedge AXI_CLOCK or posedge AXI_RST)
begin
 if (AXI_RST == 0) begin
   clk_div1 <= 12'h000;
   SD_CLK_1  <= 1;
 end
 else if (clk_div1 == divisor1) begin
   clk_div1 <= 0;
   SD_CLK_1 <= ~SD_CLK_1;
 end 
 else begin
   clk_div1  <= clk_div1 + 1;
   SD_CLK_1 <=  SD_CLK_1;
 end
end

endmodule
