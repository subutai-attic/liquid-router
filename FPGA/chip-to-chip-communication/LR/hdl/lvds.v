`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2017 04:25:46 PM
// Design Name: 
// Module Name: lvds
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


module lvds(
    input   wire    clkin_p,
    input   wire    clkin_n,
    input   wire    clk,
    input   wire    datain_p,
    input   wire    datain_n,
    
    output  wire    clkout_p,
    output  wire    clkout_n,
    output  wire    dataout_p,
    output  wire    dataout_n
    );
    
    (* mark_debug = "true" *) wire    clkin;
    (* mark_debug = "true" *) wire    clkout;
    (* mark_debug = "true" *) wire    data;
    (* mark_debug = "true" *) reg [31:0]  count =0;
    
    assign clkout = clkin;
    // IBUFDS: Differential Input Buffer
    //         Artix-7
    // Xilinx HDL Language Template, version 2016.2
 
    IBUFDS #(
       .DIFF_TERM("FALSE")       // Differential Termination
//       .IOSTANDARD("DEFAULT")     // Specify the input I/O standard
    ) IBUFDS_clk_inst (
       .O(clkin),             // Buffer output
       .I(clkin_p),         // Diff_p buffer input (connect directly to top-level port)
       .IB(clkin_n)         // Diff_n buffer input (connect directly to top-level port)
    );
    
    always@(posedge clk) 
    begin
        if(clkin)
            count <= count + 1;
    end
    
    IBUFDS #(
       .DIFF_TERM("TRUE")       // Differential Termination
//       .IOSTANDARD("DEFAULT")     // Specify the input I/O standard
    ) IBUFDS_data_inst (
       .O(data),            // Buffer output
       .I(datain_p),        // Diff_p buffer input (connect directly to top-level port)
       .IB(datain_n)        // Diff_n buffer input (connect directly to top-level port)
    ); 
    // End of IBUFDS_inst instantiation
    
    
    // OBUFDS: Differential Output Buffer
    //         Artix-7
    // Xilinx HDL Language Template, version 2016.2
    
    OBUFDS OBUFDS_clk_inst (
       .O(clkout_p),     // Diff_p output (connect directly to top-level port)
       .OB(clkout_n),    // Diff_n output (connect directly to top-level port)
       .I(clkout)           // Buffer input 
    );
   
    OBUFDS  OBUFDS_data_inst (
       .O(dataout_p),     // Diff_p output (connect directly to top-level port)
       .OB(dataout_n),    // Diff_n output (connect directly to top-level port)
       .I(data)        // Buffer input 
    );   
    // End of OBUFDS_inst instantiation
endmodule
