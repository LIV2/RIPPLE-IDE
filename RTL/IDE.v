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
    input UDS_n,
    input LDS_n,
    input RW,
    input AS_n,
    input CLK,
    input ide_access,
    input ide_enable,
    input RESET_n,
    output DTACK,
    output IOR_n,
    output IOW_n,
    output IDECS1_n,
    output IDECS2_n,
    output IDE_ROMEN
    );

wire ds = !UDS_n || !LDS_n;

reg ide_dtack;
reg ide_enabled = 0;


always @(posedge CLK or negedge RESET_n) begin
  if (!RESET_n) begin
    ide_enabled <= 0;
  end else begin
    // IDE enabled on first write to an IDE address
    if (ide_access && ide_enable && !RW && !UDS_n && !AS_n) ide_enabled <= 1;
  end
end

assign IDECS1_n = !(ide_access && ADDR[12] && !ADDR[16]) || !ide_enabled;
assign IDECS2_n = !(ide_access && ADDR[13] && !ADDR[16]) || !ide_enabled;

// IDE ROM is mapped to whole range until ide is enabled by the first write
// After then, it is mapped to (base address) + 64K
assign IDE_ROMEN = !(!AS_n && ide_access && (!ide_enabled || ADDR[16]));

reg [2:0] as_delay;
localparam S6 = 3'b100;

always @(posedge CLK or posedge AS_n) begin
  if (AS_n) begin
    as_delay <= 3'b111;
  end else begin
    as_delay <= {as_delay[1:0], AS_n};
  end
end

assign IOR_n = !(!AS_n &&  RW && !as_delay[0] && ds); // S4 to end of S6
assign IOW_n = !(!AS_n && !RW && !as_delay[1] && ds); // S4 & S5

assign DTACK = (ide_access && as_delay[1] == 0);

endmodule
