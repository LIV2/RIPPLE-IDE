`timescale 1ns / 1ps
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

module IDE(
    input [23:1] ADDR,
    input BERR_n,
    input UDS_n,
    input LDS_n,
    input RW,
    input AS_n,
    input CLK,
    input ide_access,
    input ide_enable,
    input RESET_n,
    output DTACK,
    output reg IOR_n,
    output reg IOW_n,
    output IDECS1_n,
    output IDECS2_n,
    output IDEBUF_OE,
    output IDE_ROMEN
    );

wire ds = !UDS_n || !LDS_n;

reg ide_dtack;
reg ide_enabled;

assign IDECS1_n = !(ide_access && ADDR[12] && !ADDR[16]) || !ide_enabled;
assign IDECS2_n = !(ide_access && ADDR[13] && !ADDR[16]) || !ide_enabled;

assign IDE_ROMEN = !(ide_access && BERR_n && (!ide_enabled || ADDR[16]));

assign IDEBUF_OE = !(ide_access && ide_enabled && BERR_n && !ADDR[16] && !AS_n && (ds || !RW));


reg [1:0] AS_n_sync = 2'b11;

always @(posedge CLK) begin
  AS_n_sync[1:0] <= {AS_n_sync[0], AS_n};
end

always @(posedge CLK or posedge AS_n) begin
  if (AS_n) begin
    IOW_n      <= 1;
    ide_dtack  <= 0;
  end else begin
`ifdef slowaccess
    ide_dtack <= ide_access && !AS_n_sync[0];       // Assert DTACK at end of S5
    IOW_n <= !(!RW && !AS_n && AS_n_sync == 2'b10); // Assert IOW for S5 + 1 only
`else
    ide_dtack <= ide_access && !AS_n;       // Assert DTACK at beginning of S4
    IOW_n <= !(!RW && !AS_n && AS_n_sync == 2'b11); // Assert IOW for S4-5 only
`endif
  end
end

always @(negedge CLK or posedge AS_n) begin
  if (AS_n) begin  
    IOR_n <= 1;
  end else begin
    IOR_n <= !(RW);
  end
end

always @(posedge CLK or negedge RESET_n) begin
  if (!RESET_n) begin
    ide_enabled <= 0;
  end else begin
    if (ide_access && ide_enable && !RW) ide_enabled <= 1;
  end
end

assign DTACK = ide_dtack;

endmodule
