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

module RIPPLE(
    input [23:1] ADDR,
    input AS_n,
    input BERR_n,
    input C1n,
    input C3n,
    input CDACn, // Unused but maybe handy
    input CFGIN_n,
    inout [15:12] DBUS,
    input LDS_n,
    input RESET_n,
    input RW,
    input UDS_n,
    output CFGOUT_n,
    output DTACK_n,
    output OVR_n,
    output SLAVE_n,
// IDE stuff
    input IDEEN_n,
    output IDE_ROMEN,
    output IDEBUF_OE,
    output IDECS1_n,
    output IDECS2_n,
    output IOR_n,
    output IOW_n
    );

wire autoconfig_cycle;
wire ide_access;
wire [3:0] autoconfig_dout;
wire ide_dtack;

wire CLK7M = !(C1n ^ C3n);

Autoconfig AUTOCONFIG (
  .ADDR (ADDR),
  .AS_n (AS_n),
  .UDS_n (UDS_n),
  .CLK (CLK7M),
  .RW (RW),
  .DIN (DBUS[15:12]),
  .RESET_n (RESET_n),
  .ide_enabled (~IDEEN_n),
  .CFGIN_n (CFGIN_n),
  .CFGOUT_n (CFGOUT_n),
  .ide_access (ide_access),
  .autoconfig_cycle (autoconfig_cycle),
  .DOUT (autoconfig_dout),
  .dtack (autoconf_dtack)
);

IDE IDE (
  .ADDR (ADDR),
  .UDS_n (UDS_n),
  .LDS_n (LDS_n),
  .RW (RW),
  .AS_n (AS_n),
  .CLK (CLK7M),
  .ide_access (ide_access),
  .ide_enable (~IDEEN_n),
  .RESET_n (RESET_n),
  .DTACK (ide_dtack),
  .IOR_n (IOR_n),
  .IOW_n (IOW_n),
  .IDECS1_n (IDECS1_n),
  .IDECS2_n (IDECS2_n),
  .IDE_ROMEN (IDE_ROMEN)
);


assign DBUS[15:12] = (autoconfig_cycle) && RW && !UDS_n && BERR_n && RESET_n ? autoconfig_dout : 'bZ;

assign OVR_n = (ide_access && !AS_n) ? 1'b0 : 1'bZ;
assign DTACK_n = (ide_access && !AS_n && ide_dtack) ? 1'b0 : 1'bZ;

assign OVR_n = 1'bZ;
assign DTACK_n = 1'bZ;

assign SLAVE_n = !((autoconfig_cycle || ide_access) && !AS_n);

assign IDEBUF_OE = !((autoconfig_cycle || ide_access) && !AS_n && BERR_n && (UDS_n || LDS_n || !RW));


endmodule
