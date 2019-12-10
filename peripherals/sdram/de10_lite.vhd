-------------------------------------------------------------------
-- Name        : de0_lite.vhd
-- Author      : 
-- Version     : 0.1
-- Copyright   : Departamento de Eletrônica, Florianópolis, IFSC
-- Description : Projeto base DE10-Lite
-------------------------------------------------------------------
LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

use work.decoder_types.all;

entity de10_lite is
	port(
		---------- CLOCK ----------
		ADC_CLK_10      : in    std_logic;
		MAX10_CLK1_50   : in    std_logic;
		MAX10_CLK2_50   : in    std_logic;
		----------- SDRAM ------------
		DRAM_ADDR       : out   std_logic_vector(12 downto 0);
		DRAM_BA         : out   std_logic_vector(1 downto 0);
		DRAM_CAS_N      : out   std_logic;
		DRAM_CKE        : out   std_logic;
		DRAM_CLK        : out   std_logic;
		DRAM_CS_N       : out   std_logic;
		DRAM_DQ         : inout std_logic_vector(15 downto 0);
		DRAM_LDQM       : out   std_logic;
		DRAM_RAS_N      : out   std_logic;
		DRAM_UDQM       : out   std_logic;
		DRAM_WE_N       : out   std_logic;
		----------- SEG7 ------------
		HEX0            : out   std_logic_vector(7 downto 0);
		HEX1            : out   std_logic_vector(7 downto 0);
		HEX2            : out   std_logic_vector(7 downto 0);
		HEX3            : out   std_logic_vector(7 downto 0);
		HEX4            : out   std_logic_vector(7 downto 0);
		HEX5            : out   std_logic_vector(7 downto 0);
		----------- KEY ------------
		KEY             : in    std_logic_vector(1 downto 0);
		----------- LED ------------
		LEDR            : out   std_logic_vector(9 downto 0);
		----------- SW ------------
		SW              : in    std_logic_vector(9 downto 0);
		----------- VGA ------------
		VGA_B           : out   std_logic_vector(3 downto 0);
		VGA_G           : out   std_logic_vector(3 downto 0);
		VGA_HS          : out   std_logic;
		VGA_R           : out   std_logic_vector(3 downto 0);
		VGA_VS          : out   std_logic;
		----------- Accelerometer ------------
		GSENSOR_CS_N    : out   std_logic;
		GSENSOR_INT     : in    std_logic_vector(2 downto 1);
		GSENSOR_SCLK    : out   std_logic;
		GSENSOR_SDI     : inout std_logic;
		GSENSOR_SDO     : inout std_logic;
		----------- Arduino ------------
		ARDUINO_IO      : inout std_logic_vector(15 downto 0);
		ARDUINO_RESET_N : inout std_logic
	);
end entity;

architecture rtl of de10_lite is

	signal rst   : std_logic;
	signal rst_n : std_logic;

	-- PLL signals
	signal clk            : std_logic;  -- 1 MHz
	signal clk_sdram_ctrl : std_logic;  -- 200 MHz
	signal clk_vga        : std_logic;  -- 40 MHz
	signal clk_sdram_chip : std_logic;  -- 125 MHz
	signal locked_sig     : std_logic;

	-- SDRAM signals
	signal sdram_addr       : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal chipselect_sdram : STD_LOGIC;
	signal rst              : STD_LOGIC;
	signal clken            : std_logic;
	signal d_we             : STD_LOGIC;
	signal sdram_d_rd       : std_logic;
	signal ddata_w          : STD_LOGIC_VECTOR(15 DOWNTO 0);
	signal burst            : std_logic;
	signal sdram_read       : STD_LOGIC_VECTOR(15 DOWNTO 0);
	signal waitrequest      : std_logic;
	signal DRAM_DQM         : std_logic_vector(1 downto 0);
	signal burst            : std_logic;
	signal byteenable       : std_logic_vector(1 downto 0);

begin

	pll_inst : entity work.pll
		port map(
			areset => '0',
			inclk0 => MAX10_CLK1_50,
			c0     => clk,
			c1     => clk_sdram_ctrl,
			c2     => clk_vga,
			c3     => clk_sdram_chip,
			locked => locked_sig
		);

	-- SDRAM instatiation
	sdram_controller : entity work.sdram_controller
		port map(
			address     => sdram_addr,
			byteenable  => byteenable,
			chipselect  => chipselect_sdram,
			clk         => clk_sdram_ctrl,
			clken       => clken,
			reset       => rst,
			reset_req   => rst,
			write       => d_we,
			read        => sdram_d_rd,
			writedata   => ddata_w,
			burst       => burst,
			-- outputs:
			readdata    => sdram_read,
			waitrequest => waitrequest,
			DRAM_ADDR   => DRAM_ADDR,
			DRAM_BA     => DRAM_BA,
			DRAM_CAS_N  => DRAM_CAS_N,
			DRAM_CKE    => DRAM_CKE,
			DRAM_CLK    => open,
			DRAM_CS_N   => DRAM_CS_N,
			DRAM_DQ     => DRAM_DQ,
			DRAM_DQM    => DRAM_DQM,
			DRAM_RAS_N  => DRAM_RAS_N,
			DRAM_WE_N   => DRAM_WE_N
		);

	-- Dummy out signals
	--ARDUINO_IO <= ddata_r(31 downto 16);
	LEDR(9 downto 8) <= SW(9 downto 8);

	-- SDRAM Signals
	--sdram_addr <= x"0000" & ;
	byteenable       <= "11";
	chipselect_sdram <= '1';
	clken            <= '1';
	rst              <= SW(9);
	d_we             <= SW(8);
	sdram_d_rd       <= not SW(8);
	--ddata_w <= ;
	burst            <= '0';
	--<= sdram_read;
	HEX5(0)          <= waitrequest;
	DRAM_UDQM        <= DRAM_DQM(1);
	DRAM_LDQM        <= DRAM_DQM(0);

end;
