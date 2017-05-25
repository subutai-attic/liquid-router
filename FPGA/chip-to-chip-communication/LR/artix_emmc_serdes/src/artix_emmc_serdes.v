`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Optimal-Dynamics LLC
// Engineer: Baktiiar Kukanov
// 
// Create Date: 04/13/2017 10:39:57 AM
// Design Name: Artix SerDes
// Module Name: artix_emmc_serdes
// Project Name: SerDes between Parallella and LR
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


module artix_emmc_serdes#(
    parameter         	  TX_CLOCK = "BUF_G" ,       // Parameter to set transmission clock buffer type, BUFIO, BUF_H, BUF_G
    parameter             DIV_CLOCK = "BUF_G",       // Parameter to set intermediate clock buffer type, BUFR, BUF_H, BUF_G
    parameter             FBOUT_CLOCK = "BUF_G"     // Parameter to set final clock buffer type, BUF_R, BUF_H, BUF_G
    )(
      input   wire    rst,
      input   wire    clkin_p,
      input   wire    clkin_n,
      input   wire    datain_p,
      input   wire    datain_n,
      (* mark_debug = "true" *) input   wire    cmd_i,
      (* mark_debug = "true" *) input   wire [7:0]    sd_dat_i,
      (* mark_debug = "true" *) input   wire    sd_clkin,

      output   wire   SD_clk,
      (* mark_debug = "true" *) output   reg   cmd_o,
      (* mark_debug = "true" *) output   reg   cmd_t,
      output   reg [7:0]   sd_dat_o,
      output   reg     sd_dat_t,
      output   wire    clkout_p,
      output   wire    clkout_n,
      output   wire    dataout_p,
      output   wire    dataout_n,
      output   wire    txclk_div
    );


    (* mark_debug = "true" *) reg     bitslip;					
    wire    txclk;
    
    (* mark_debug = "true" *) wire    [7:0]   test_ptrn;
    (* mark_debug = "true" *) reg     [7:0]   sd_dat_in;
    (* mark_debug = "true" *) wire    [7:0]   sd_dat_out;
    
    assign SD_clk = sd_clkin;
    
    always @(posedge txclk_div)
       if (rst == 1'b0) begin
         sd_dat_in <= 0;
        end
        else begin
             sd_dat_in <= {3'b0, sd_dat_i[3:0], cmd_i};
        end

    always @(posedge SD_clk)
       if (rst == 1'b0) begin
            cmd_o <= 1'b0;
            cmd_t <= 1'b0;
            sd_dat_t <= 1'b0;
            sd_dat_o <= 1'b0;
        end
        else begin
            cmd_o <= sd_dat_out[0];
            cmd_t <= sd_dat_out[1];
            sd_dat_t <= sd_dat_out[2];
            sd_dat_o[3:0] <= sd_dat_out[6:3];
        end
    

//  GSR GSR_INST (.GSR (rst));
  
   // IBUFDS: Differential Input Buffer
   //         Artix-7
   // Xilinx HDL Language Template, version 2016.2

   IBUFDS #(
      .DIFF_TERM("TRUE"),        // Differential Termination
      .IBUF_LOW_PWR("TRUE"),     // Low power="TRUE", Highest performance="FALSE" 
      .IOSTANDARD("DEFAULT")     // Specify the input I/O standard
   ) IBUFDS_clock_inst (
      .O(clkin),                     // Buffer output
      .I(clkin_p),                     // Diff_p buffer input (connect directly to top-level port)
      .IB(clkin_n)                    // Diff_n buffer input (connect directly to top-level port)
   );

   IBUFDS #(
      .DIFF_TERM("TRUE"),       // Differential Termination
      .IBUF_LOW_PWR("TRUE"),     // Low power="TRUE", Highest performance="FALSE" 
      .IOSTANDARD("DEFAULT")     // Specify the input I/O standard
   ) IBUFDS_data_inst (
      .O(datain),  // Buffer output
      .I(datain_p),  // Diff_p buffer input (connect directly to top-level port)
      .IB(datain_n) // Diff_n buffer input (connect directly to top-level port)
   );

   // End of IBUFDS_inst instantiation

 
//    assign clk = clkin;

//    always@(posedge clkin) begin
//        if(reset == 1'b0)
//            rst <= 0;
//        else
//            rst <= 1;
//    end
  // PLLE2_BASE: Base Phase Locked Loop (PLL)
  //             Artix-7
  // Xilinx HDL Language Template, version 2016.2

  PLLE2_BASE #(
     .BANDWIDTH("OPTIMIZED"),  // OPTIMIZED, HIGH, LOW
     .CLKFBOUT_MULT(8),        // Multiply value for all CLKOUT, (2-64)
     .CLKFBOUT_PHASE(0.0),     // Phase offset in degrees of CLKFB, (-360.000-360.000).
     .CLKIN1_PERIOD(10.0),      // Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
     // CLKOUT0_DIVIDE - CLKOUT5_DIVIDE: Divide amount for each CLKOUT (1-128)
     .CLKOUT0_DIVIDE(2),
     .CLKOUT1_DIVIDE(4),
     .CLKOUT2_DIVIDE(1),
     .CLKOUT3_DIVIDE(1),
     .CLKOUT4_DIVIDE(1),
     .CLKOUT5_DIVIDE(1),
     // CLKOUT0_DUTY_CYCLE - CLKOUT5_DUTY_CYCLE: Duty cycle for each CLKOUT (0.001-0.999).
     .CLKOUT0_DUTY_CYCLE(0.5),
     .CLKOUT1_DUTY_CYCLE(0.5),
     .CLKOUT2_DUTY_CYCLE(0.5),
     .CLKOUT3_DUTY_CYCLE(0.5),
     .CLKOUT4_DUTY_CYCLE(0.5),
     .CLKOUT5_DUTY_CYCLE(0.5),
     // CLKOUT0_PHASE - CLKOUT5_PHASE: Phase offset for each CLKOUT (-360.000-360.000).
     .CLKOUT0_PHASE(0.0),
     .CLKOUT1_PHASE(0.0),
     .CLKOUT2_PHASE(0.0),
     .CLKOUT3_PHASE(0.0),
     .CLKOUT4_PHASE(0.0),
     .CLKOUT5_PHASE(0.0),
     .DIVCLK_DIVIDE(1),        // Master division value, (1-56)
     .REF_JITTER1(0.1),        // Reference input jitter in UI, (0.000-0.999).
     .STARTUP_WAIT("FALSE")    // Delay DONE until PLL Locks, ("TRUE"/"FALSE")
  )
  PLLE2_BASE_inst (
     // Clock Outputs: 1-bit (each) output: User configurable clock outputs
     .CLKOUT0(CLKOUT0),   // 1-bit output: CLKOUT0
     .CLKOUT1(CLKOUT1),   // 1-bit output: CLKOUT1
     .CLKOUT2(),   // 1-bit output: CLKOUT2
     .CLKOUT3(),   // 1-bit output: CLKOUT3
     .CLKOUT4(),   // 1-bit output: CLKOUT4
     .CLKOUT5(),   // 1-bit output: CLKOUT5
     // Feedback Clocks: 1-bit (each) output: Clock feedback ports
     .CLKFBOUT(CLKFBOUT), // 1-bit output: Feedback clock
     .LOCKED(LOCKED),     // 1-bit output: LOCK
     .CLKIN1(clkin),     // 1-bit input: Input clock
     // Control Ports: 1-bit (each) input: PLL control ports
     .PWRDWN(1'b0),     // 1-bit input: Power-down
     .RST(!rst),           // 1-bit input: Reset
     // Feedback Clocks: 1-bit (each) input: Clock feedback ports
     .CLKFBIN(CLKFBIN)    // 1-bit input: Feedback clock
  );

  // End of PLLE2_BASE_inst instantiation
  if (FBOUT_CLOCK == "BUF_G") begin                 // Final clock selection
     BUFG    bufg_mmcm_x1 (.I(CLKFBOUT), .O(CLKFBIN)) ;
  end
  else if (FBOUT_CLOCK == "BUF_R") begin
     BUFR #(.BUFR_DIVIDE("1"),.SIM_DEVICE("7SERIES"))bufr_mmcm_x1 (.I(CLKFBOUT),.CE(1'b1),.O(CLKFBIN),.CLR(1'b0)) ;
  end
  else begin 
     BUFH    bufh_mmcm_x1 (.I(CLKFBOUT), .O(CLKFBIN)) ;
  end

  if (DIV_CLOCK == "BUF_G") begin                 // Intermediate clock selection
     BUFG    bufg_mmcm_d2 (.I(CLKOUT1), .O(txclk_div)) ;
  end
  else if (DIV_CLOCK == "BUF_R") begin
     BUFR #(.BUFR_DIVIDE("1"),.SIM_DEVICE("7SERIES"))bufr_mmcm_d2 (.I(CLKOUT1),.CE(1'b1),.O(txclk_div),.CLR(1'b0)) ;
  end
  else begin 
     BUFH    bufh_mmcm_d2 (.I(CLKOUT1), .O(txclk_div)) ;
  end
     
  if (TX_CLOCK == "BUF_G") begin                // Sample clock selection
     BUFG    bufg_mmcm_xn (.I(CLKOUT0), .O(txclk)) ;
  end
  else if (TX_CLOCK == "BUFIO") begin
     BUFIO      bufio_mmcm_xn (.I (CLKOUT0), .O(txclk)) ;
  end
  else begin 
     BUFH    bufh_mmcm_xn (.I(CLKOUT0), .O(txclk)) ;
  end
		

 // ISERDESE2: Input SERial/DESerializer with Bitslip
 //            Artix-7
 // Xilinx HDL Language Template, version 2016.2
 ISERDESE2 #(
    .DATA_RATE("DDR"),           // DDR, SDR
    .DATA_WIDTH(8),              // Parallel data width (2-8,10,14)
    .DYN_CLKDIV_INV_EN("FALSE"), // Enable DYNCLKDIVINVSEL inversion (FALSE, TRUE)
    .DYN_CLK_INV_EN("FALSE"),    // Enable DYNCLKINVSEL inversion (FALSE, TRUE)
    // INIT_Q1 - INIT_Q4: Initial value on the Q outputs (0/1)
    .INIT_Q1(1'b1),
    .INIT_Q2(1'b1),
    .INIT_Q3(1'b1),
    .INIT_Q4(1'b1),
    .INTERFACE_TYPE("NETWORKING"),   // MEMORY, MEMORY_DDR3, MEMORY_QDR, NETWORKING, OVERSAMPLE
    .IOBDELAY("NONE"),           // NONE, BOTH, IBUF, IFD
    .NUM_CE(2),                  // Number of clock enables (1,2)
    .OFB_USED("FALSE"),          // Select OFB path (FALSE, TRUE)
    .SERDES_MODE("MASTER"),      // MASTER, SLAVE
    // SRVAL_Q1 - SRVAL_Q4: Q output values when SR is used (0/1)
    .SRVAL_Q1(1'b1),
    .SRVAL_Q2(1'b1),
    .SRVAL_Q3(1'b1),
    .SRVAL_Q4(1'b1) 
 )
 ISERDESE2_clock_inst (
    .O(),                       // 1-bit output: Combinatorial output
    // Q1 - Q8: 1-bit (each) output: Registered data outputs
    .Q1(test_ptrn[7]),
    .Q2(test_ptrn[6]),
    .Q3(test_ptrn[5]),
    .Q4(test_ptrn[4]),
    .Q5(test_ptrn[3]),
    .Q6(test_ptrn[2]),
    .Q7(test_ptrn[1]),
    .Q8(test_ptrn[0]),
    // SHIFTOUT1, SHIFTOUT2: 1-bit (each) output: Data width expansion output ports
    .SHIFTOUT1(),
    .SHIFTOUT2(),
    .BITSLIP(bitslip),           // 1-bit input: The BITSLIP pin performs a Bitslip operation synchronous to
                                 // CLKDIV when asserted (active High). Subsequently, the data seen on the Q1
                                 // to Q8 output ports will shift, as in a barrel-shifter operation, one
                                 // position every time Bitslip is invoked (DDR operation is different from
                                 // SDR).

    // CE1, CE2: 1-bit (each) input: Data register clock enable inputs
    .CE1(1'b1),
    .CE2(1'b1),
    .CLKDIVP(CLKDIVP),           // 1-bit input: TBD
    // Clocks: 1-bit (each) input: ISERDESE2 clock input ports
    .CLK(txclk),                   // 1-bit input: High-speed clock
    .CLKB(~txclk),                 // 1-bit input: High-speed secondary clock
    .CLKDIV(txclk_div),             // 1-bit input: Divided clock
    .OCLK(),                 // 1-bit input: High speed output clock used when INTERFACE_TYPE="MEMORY" 
    // Dynamic Clock Inversions: 1-bit (each) input: Dynamic clock inversion pins to switch clock polarity
    .DYNCLKDIVSEL(), // 1-bit input: Dynamic CLKDIV inversion
    .DYNCLKSEL(),       // 1-bit input: Dynamic CLK/CLKB inversion
    // Input Data: 1-bit (each) input: ISERDESE2 data input ports
    .D(clkin),                       // 1-bit input: Data input
    .DDLY(),                 // 1-bit input: Serial data from IDELAYE2
    .OFB(),                   // 1-bit input: Data feedback from OSERDESE2
    .OCLKB(),               // 1-bit input: High speed negative edge output clock
    .RST(!rst),                   // 1-bit input: Active high asynchronous reset
    // SHIFTIN1, SHIFTIN2: 1-bit (each) input: Data width expansion input ports
    .SHIFTIN1(),
    .SHIFTIN2() 
 );


 ISERDESE2 #(
    .DATA_RATE("DDR"),           // DDR, SDR
    .DATA_WIDTH(8),              // Parallel data width (2-8,10,14)
    .DYN_CLKDIV_INV_EN("FALSE"), // Enable DYNCLKDIVINVSEL inversion (FALSE, TRUE)
    .DYN_CLK_INV_EN("FALSE"),    // Enable DYNCLKINVSEL inversion (FALSE, TRUE)
    // INIT_Q1 - INIT_Q4: Initial value on the Q outputs (0/1)
    .INIT_Q1(1'b1),
    .INIT_Q2(1'b1),
    .INIT_Q3(1'b1),
    .INIT_Q4(1'b1),
    .INTERFACE_TYPE("NETWORKING"),   // MEMORY, MEMORY_DDR3, MEMORY_QDR, NETWORKING, OVERSAMPLE
    .IOBDELAY("NONE"),           // NONE, BOTH, IBUF, IFD
    .NUM_CE(2),                  // Number of clock enables (1,2)
    .OFB_USED("FALSE"),          // Select OFB path (FALSE, TRUE)
    .SERDES_MODE("MASTER"),      // MASTER, SLAVE
    // SRVAL_Q1 - SRVAL_Q4: Q output values when SR is used (0/1)
    .SRVAL_Q1(1'b1),
    .SRVAL_Q2(1'b1),
    .SRVAL_Q3(1'b1),
    .SRVAL_Q4(1'b1) 
 )
 ISERDESE2_data_inst (
    .O(),                       // 1-bit output: Combinatorial output
    // Q1 - Q8: 1-bit (each) output: Registered data outputs
    .Q1(sd_dat_out[7]),
    .Q2(sd_dat_out[6]),
    .Q3(sd_dat_out[5]),
    .Q4(sd_dat_out[4]),
    .Q5(sd_dat_out[3]),
    .Q6(sd_dat_out[2]),
    .Q7(sd_dat_out[1]),
    .Q8(sd_dat_out[0]),
    // SHIFTOUT1, SHIFTOUT2: 1-bit (each) output: Data width expansion output ports
    .SHIFTOUT1(),
    .SHIFTOUT2(),
    .BITSLIP(bitslip),           // 1-bit input: The BITSLIP pin performs a Bitslip operation synchronous to
                                 // CLKDIV when asserted (active High). Subsequently, the data seen on the Q1
                                 // to Q8 output ports will shift, as in a barrel-shifter operation, one
                                 // position every time Bitslip is invoked (DDR operation is different from
                                 // SDR).

    // CE1, CE2: 1-bit (each) input: Data register clock enable inputs
    .CE1(1'b1),
    .CE2(1'b1),
    .CLKDIVP(CLKDIVP),           // 1-bit input: TBD
    // Clocks: 1-bit (each) input: ISERDESE2 clock input ports
    .CLK(txclk),                   // 1-bit input: High-speed clock
    .CLKB(~txclk),                 // 1-bit input: High-speed secondary clock
    .CLKDIV(txclk_div),             // 1-bit input: Divided clock
    .OCLK(),                 // 1-bit input: High speed output clock used when INTERFACE_TYPE="MEMORY" 
    // Dynamic Clock Inversions: 1-bit (each) input: Dynamic clock inversion pins to switch clock polarity
    .DYNCLKDIVSEL(), // 1-bit input: Dynamic CLKDIV inversion
    .DYNCLKSEL(),       // 1-bit input: Dynamic CLK/CLKB inversion
    // Input Data: 1-bit (each) input: ISERDESE2 data input ports
    .D(datain),                       // 1-bit input: Data input
    .DDLY(),                 // 1-bit input: Serial data from IDELAYE2
    .OFB(),                   // 1-bit input: Data feedback from OSERDESE2
    .OCLKB(),               // 1-bit input: High speed negative edge output clock
    .RST(!rst),                   // 1-bit input: Active high asynchronous reset
    // SHIFTIN1, SHIFTIN2: 1-bit (each) input: Data width expansion input ports
    .SHIFTIN1(),
    .SHIFTIN2() 
 );

 // End of ISERDESE2_inst instantiation
 
 reg  btsl_com_flag;          //operation complete flag
 reg [1:0] btsl_st;  //states need to wait shifting of Q1 to Q8 output ports after bitslip assertion
 
 localparam bitslip_pattern  = 8'hC3;   
 
 always @(posedge txclk_div)
   begin: BITSLIP_OPERATION
     if (rst == 1'b0) begin
       bitslip <= 1'b0;
       btsl_com_flag <= 1'b1;
       btsl_st <= 2'b00;
     end
     else begin
       if (test_ptrn[7:0] != bitslip_pattern) begin
         case (btsl_st)
           2'b00: begin
             bitslip <= 1'b1;
             btsl_st <= 2'b01;
           end
           2'b01: begin
             bitslip <= 1'b0;
             btsl_st <= 2'b10;
           end
           2'b10: begin
             btsl_st <= 2'b11;
           end
           2'b11: begin
             btsl_st <= 2'b00;
           end
         endcase
       end
       else if (test_ptrn[7:0] == bitslip_pattern) begin
         btsl_com_flag <= 1'b0;
         bitslip <= 1'b0;
       end
     end
   end


   // OSERDESE2: Output SERial/DESerializer with bitslip
   //            Artix-7
   // Xilinx HDL Language Template, version 2016.2
   OSERDESE2 #(
      .DATA_RATE_OQ("DDR"),   // DDR, SDR
      .DATA_RATE_TQ("SDR"),   // DDR, BUF, SDR
      .DATA_WIDTH(8),         // Parallel data width (2-8,10,14)
      .INIT_OQ(1'b1),         // Initial value of OQ output (1'b0,1'b1)
      .INIT_TQ(1'b1),         // Initial value of TQ output (1'b0,1'b1)
      .SERDES_MODE("MASTER"), // MASTER, SLAVE
      .SRVAL_OQ(1'b1),        // OQ output value when SR is used (1'b0,1'b1)
      .SRVAL_TQ(1'b1),        // TQ output value when SR is used (1'b0,1'b1)
      .TBYTE_CTL("FALSE"),    // Enable tristate byte operation (FALSE, TRUE)
      .TBYTE_SRC("FALSE"),    // Tristate byte source (FALSE, TRUE)
      .TRISTATE_WIDTH(1)      // 3-state converter width (1,4)
   )
   OSERDESE2_clock_inst (
      .OFB(1'b0),             // 1-bit output: Feedback path for data
      .OQ(clkout),               // 1-bit output: Data path output
      // SHIFTOUT1 / SHIFTOUT2: 1-bit (each) output: Data output expansion (1-bit each)
      .SHIFTOUT1(1'b0),
      .SHIFTOUT2(1'b0),
      .TBYTEOUT(),   // 1-bit output: Byte group tristate
      .TFB(),             // 1-bit output: 3-state control
      .TQ(),               // 1-bit output: 3-state control
      .CLK(txclk),             // 1-bit input: High speed clock
      .CLKDIV(txclk_div),       // 1-bit input: Divided clock
      // D1 - D8: 1-bit (each) input: Parallel data inputs (1-bit each)
      .D1(test_ptrn[0]),
      .D2(test_ptrn[1]),
      .D3(test_ptrn[2]),
      .D4(test_ptrn[3]),
      .D5(test_ptrn[4]),
      .D6(test_ptrn[5]),
      .D7(test_ptrn[6]),
      .D8(test_ptrn[7]),
      .OCE(1'b1),             // 1-bit input: Output data clock enable
      .RST(!rst),             // 1-bit input: Reset
      // SHIFTIN1 / SHIFTIN2: 1-bit (each) input: Data input expansion (1-bit each)
      .SHIFTIN1(1'b0),
      .SHIFTIN2(1'b0),
      // T1 - T4: 1-bit (each) input: Parallel 3-state inputs
      .T1(),
      .T2(),
      .T3(),
      .T4(),
      .TBYTEIN(),     // 1-bit input: Byte group tristate
      .TCE()              // 1-bit input: 3-state clock enable
   );

   OSERDESE2 #(
      .DATA_RATE_OQ("DDR"),   // DDR, SDR
      .DATA_RATE_TQ("SDR"),   // DDR, BUF, SDR
      .DATA_WIDTH(8),         // Parallel data width (2-8,10,14)
      .INIT_OQ(1'b1),         // Initial value of OQ output (1'b0,1'b1)
      .INIT_TQ(1'b1),         // Initial value of TQ output (1'b0,1'b1)
      .SERDES_MODE("MASTER"), // MASTER, SLAVE
      .SRVAL_OQ(1'b1),        // OQ output value when SR is used (1'b0,1'b1)
      .SRVAL_TQ(1'b1),        // TQ output value when SR is used (1'b0,1'b1)
      .TBYTE_CTL("FALSE"),    // Enable tristate byte operation (FALSE, TRUE)
      .TBYTE_SRC("FALSE"),    // Tristate byte source (FALSE, TRUE)
      .TRISTATE_WIDTH(1)      // 3-state converter width (1,4)
   )
   OSERDESE2_data_inst (
      .OFB(1'b0),             // 1-bit output: Feedback path for data
      .OQ(dataout),               // 1-bit output: Data path output
      // SHIFTOUT1 / SHIFTOUT2: 1-bit (each) output: Data output expansion (1-bit each)
      .SHIFTOUT1(1'b0),
      .SHIFTOUT2(1'b0),
      .TBYTEOUT(),   // 1-bit output: Byte group tristate
      .TFB(),             // 1-bit output: 3-state control
      .TQ(),               // 1-bit output: 3-state control
      .CLK(txclk),             // 1-bit input: High speed clock
      .CLKDIV(txclk_div),       // 1-bit input: Divided clock
      // D1 - D8: 1-bit (each) input: Parallel data inputs (1-bit each)
      .D1(sd_dat_in[0]),
      .D2(sd_dat_in[1]),
      .D3(sd_dat_in[2]),
      .D4(sd_dat_in[3]),
      .D5(sd_dat_in[4]),
      .D6(sd_dat_in[5]),
      .D7(sd_dat_in[6]),
      .D8(sd_dat_in[7]),
      .OCE(1'b1),             // 1-bit input: Output data clock enable
      .RST(!rst),             // 1-bit input: Reset
      // SHIFTIN1 / SHIFTIN2: 1-bit (each) input: Data input expansion (1-bit each)
      .SHIFTIN1(1'b0),
      .SHIFTIN2(1'b0),
      // T1 - T4: 1-bit (each) input: Parallel 3-state inputs
      .T1(),
      .T2(),
      .T3(),
      .T4(),
      .TBYTEIN(),     // 1-bit input: Byte group tristate
      .TCE()              // 1-bit input: 3-state clock enable
   );

   // End of OSERDESE2_inst instantiation
   OBUFDS io_clk_out (
       .O                (clkout_p),
       .OB               (clkout_n),
       .I                 (clkout));
          
   OBUFDS io_data_out (
       .O                (dataout_p),
       .OB               (dataout_n),
       .I                 (dataout));
    
endmodule
