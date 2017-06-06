`timescale 1ns / 1ps

module iserdes #(
    parameter data_rate             = "SDR",
    parameter interface_type        = "NETWORKING",
    parameter integer data_width    = 8,
    parameter integer num_ce        = 2, 
    parameter init_value            = 1'b1,
    parameter init_sr_value         = 1'b1
)
(
 (* mark_debug = "true" *) output [7:0] q,
 (* mark_debug = "true" *) input  wire d,
 input  wire ce1,
 input  wire ce2,
 (* mark_debug = "true" *) input  wire locked_in,
 input  wire clk,
 (* mark_debug = "true" *) input  wire clkdiv,
 (* mark_debug = "true" *) input  wire rst
);

(* mark_debug = "true" *) reg bitslip;
 
ISERDESE2 #(
    .DATA_RATE(data_rate),              // DDR, SDR
    .DATA_WIDTH(8),        // Parallel data width (2-8,10,14)
    .DYN_CLKDIV_INV_EN("FALSE"),    // Enable DYNCLKDIVINVSEL inversion (FALSE, TRUE)
    .DYN_CLK_INV_EN("FALSE"),       // Enable DYNCLKINVSEL inversion (FALSE, TRUE)
    // INIT_Q1 - INIT_Q4: Initial value on the Q outputs (0/1)
    .INIT_Q1(init_value),
    .INIT_Q2(init_value),
    .INIT_Q3(init_value),
    .INIT_Q4(init_value),
    .INTERFACE_TYPE(interface_type),// MEMORY, MEMORY_DDR3, MEMORY_QDR, NETWORKING, OVERSAMPLE
    .IOBDELAY("NONE"),              // NONE, BOTH, IBUF, IFD
    .NUM_CE(num_ce),                // Number of clock enables (1,2)
    .OFB_USED("FALSE"),             // Select OFB path (FALSE, TRUE)
    .SERDES_MODE("MASTER"),         // MASTER, SLAVE
    // SRVAL_Q1 - SRVAL_Q4: Q output values when SR is used (0/1)
    .SRVAL_Q1(init_sr_value),
    .SRVAL_Q2(init_sr_value),
    .SRVAL_Q3(init_sr_value),
    .SRVAL_Q4(init_sr_value)
)
ISERDESE2_inst(
    .O(O),                          // 1-bit output: Combinatorial output
    // Q1 - Q8: 1-bit (each) output: Registered data outputs
    .Q1(q[7]),
    .Q2(q[6]),
    .Q3(q[5]),
    .Q4(q[4]),
    .Q5(q[3]),
    .Q6(q[2]),
    .Q7(q[1]),
    .Q8(q[0]),
    // SHIFTOUT1, SHIFTOUT2: 1-bit (each) output: Data width expansion output ports
    .SHIFTOUT1(SHIFTOUT1),
    .SHIFTOUT2(SHIFTOUT2),
    .BITSLIP(bitslip),  // 1-bit input: The BITSLIP pin performs a Bitslip operation synchronous to
                        // CLKDIV when asserted (active High). Subsequently, the data seen on the Q1
                        // to Q8 output ports will shift, as in a barrel-shifter operation, one
                        // position every time Bitslip is invoked (DDR operation is different from
                        // SDR).
    // CE1, CE2: 1-bit (each) input: Data register clock enable inputs
    .CE1(1'b1),
    .CE2(1'b1),
    .CLKDIVP(CLKDIVP),  // 1-bit input: TBD
    // Clocks: 1-bit (each) input: ISERDESE2 clock input ports
    .CLK(clk),          // 1-bit input: High-speed clock
    .CLKB(!clk),        // 1-bit input: High-speed secondary clock
    .CLKDIV(clkdiv),    // 1-bit input: Divided clock
    .OCLK(OCLK),        // 1-bit input: High speed output clock used when INTERFACE_TYPE="MEMORY"
    // Dynamic Clock Inversions: 1-bit (each) input: Dynamic clock inversion pins to switch clock polarity
    .DYNCLKDIVSEL(DYNCLKDIVSEL),    // 1-bit input: Dynamic CLKDIV inversion
    .DYNCLKSEL(DYNCLKSEL),          // 1-bit input: Dynamic CLK/CLKB inversion
    // Input Data: 1-bit (each) input: ISERDESE2 data input ports
    .D(d),              // 1-bit input: Data input
    .DDLY(DDLY),        // 1-bit input: Serial data from IDELAYE2
    .OFB(ofb),          // 1-bit input: Data feedback from OSERDESE2
    .OCLKB(OCLKB),      // 1-bit input: High speed negative edge output clock
    .RST(!rst),          // 1-bit input: Active high asynchronous reset
    // SHIFTIN1, SHIFTIN2: 1-bit (each) input: Data width expansion input ports
    .SHIFTIN1(SHIFTIN1),
    .SHIFTIN2(SHIFTIN2)
);

wire ce;            //clock enable
(* mark_debug = "true" *) reg  btsl_com_flag;          //operation complete flag
(* mark_debug = "true" *) reg [1:0] btsl_st;  //states need to wait shifting of Q1 to Q8 output ports after bitslip assertion
(* mark_debug = "true" *) reg resetn;

localparam bitslip_pattern  = 8'h0A;
assign ce = num_ce == 2 ? ce1 & ce2 : ce1;


always @(posedge clkdiv)
  begin: BITSLIP_OPERATION
    if (resetn) begin
      bitslip <= 1'b0;
      btsl_com_flag <= 1'b1;
      btsl_st <= 2'b00;
    end
    else begin
      if (q != bitslip_pattern && q != 8'hff && btsl_com_flag) begin
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
      else if (q == bitslip_pattern) begin
        btsl_com_flag <= 1'b0;
      end
    end
  end


always @(posedge clkdiv) begin
  if (rst == 0)
    resetn <= 1;
  else if (btsl_com_flag == 1)
    resetn <= 0;
end


endmodule