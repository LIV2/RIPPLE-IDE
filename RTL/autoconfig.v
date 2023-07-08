/*
 * Copyright (C) 2023 Matthew Harlum <matt@harlum.net>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 2.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software Foundation,
 * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 */

module Autoconfig (
    input [23:1] ADDR,
    input AS_n,
    input UDS_n,
    input CLK,
    input RW,
    input [3:0] DIN,
    input RESET_n,
    input ide_enabled,
    input CFGIN_n,
    output CFGOUT_n,
    output ide_access,
    output autoconfig_cycle,
    output reg [3:0] DOUT,
    output reg dtack
);

// Autoconfig
localparam [15:0] mfg_id  = 16'd5194;
localparam [7:0]  prod_id = 8'd6;
localparam [31:0] serial  = 32'd1;

reg ide_configured;

reg [3:0] ide_base;

reg cfgin;
reg cfgout;
reg shutup;

assign CFGOUT_n = ~cfgout;

assign autoconfig_cycle = (ADDR[23:16] == 8'hE8) && cfgin && !cfgout;


// These need to be registered at the end of a bus cycle
always @(posedge AS_n or negedge RESET_n) begin
  if (!RESET_n) begin
    cfgout <= 0;
    cfgin  <= 0;
  end else begin
    cfgin  <= ~CFGIN_n;
    cfgout <= ide_configured || shutup;
  end
end

always @(posedge CLK or negedge RESET_n)
begin
  if (!RESET_n) begin
    DOUT           <= 'b0;
    dtack          <= 0;
    ide_base       <= 4'b0;
    ide_configured <= 0;
    shutup         <= 0;
  end else if (!UDS_n && autoconfig_cycle && !dtack) begin
    dtack <= 1;
    if (RW) begin
      case (ADDR[8:1])
        8'h00:   DOUT <= {3'b110, ide_enabled}; // IO / Read from autoboot rom
        8'h01:   DOUT <= 4'b0010;              // Size:128K
        8'h02:   DOUT <= ~prod_id[7:4];        // Product number
        8'h03:   DOUT <= ~prod_id[3:0];        // Product number
        8'h04:   DOUT <= ~4'b0000; 
        8'h05:   DOUT <= ~4'b0000;
        8'h08:   DOUT <= ~mfg_id[15:12];        // Manufacturer ID
        8'h09:   DOUT <= ~mfg_id[11:8];         // Manufacturer ID
        8'h0A:   DOUT <= ~mfg_id[7:4];          // Manufacturer ID
        8'h0B:   DOUT <= ~mfg_id[3:0];          // Manufacturer ID
        8'h0C:   DOUT <= ~serial[31:28];        // Serial number
        8'h0D:   DOUT <= ~serial[27:24];        // Serial number
        8'h0E:   DOUT <= ~serial[23:20];        // Serial number
        8'h0F:   DOUT <= ~serial[19:16];        // Serial number
        8'h10:   DOUT <= ~serial[15:12];        // Serial number
        8'h11:   DOUT <= ~serial[11:8];         // Serial number
        8'h12:   DOUT <= ~serial[7:4];          // Serial number
        8'h13:   DOUT <= ~serial[3:0];          // Serial number
        8'h14:   DOUT <= ~4'h0;                 // ROM Offset high byte high nibble
        8'h15:   DOUT <= ~4'h0;                 // ROM Offset high byte low nibble
        8'h16:   DOUT <= ~4'h0;                 // ROM Offset low byte high nibble
        8'h17:   DOUT <= ~4'h8;                 // ROM Offset low byte low nibble
        8'h20:   DOUT <= 4'b0;
        8'h21:   DOUT <= 4'b0;
        default: DOUT <= 4'hF;
      endcase
    end else begin
      if (ADDR[8:1] == 8'h26) begin
          // We've been told to shut up (not enough space)
          shutup <= 1;
      end else if (ADDR[8:1] == 8'h25) begin
          ide_configured <= 1'b1;
          ide_base <= DIN[3:0];
      end
    end
  end else begin
    if (AS_n)
      dtack <= 0;
  end
end

assign ide_access  = (ADDR[23:16] == {4'hE, ide_base} && ide_configured);

endmodule
