library ieee;
use ieee.std_logic_1164.all;

entity lt24_touch is
	port(
		clk, rst: in std_logic;
		--MM
		en: in std_logic;
		--Export
		dout, penirq_n, busy: in std_logic;
		--MM
		ncf, irqf: out std_logic;
		xcoord, ycoord: out std_logic_vector(11 downto 0);
		--Export
		din, dclk, cs: out std_logic
	);
end entity;

architecture arch of lt24_touch is
	component adc_spi_controller
		port(
			iCLK, iRST_n, iADC_DOUT, iADC_PENIRQ_n, iADC_BUSY: in std_logic;
			oADC_DIN, oADC_DCLK, oADC_CS, oTOUCH_IRQ, oNEW_COORD: out std_logic;
			oX_COORD, oY_COORD: out std_logic_vector(11 downto 0)
		);
	end component;
	begin
		cspi: component adc_spi_controller
		port map(
			clk and en, not rst, dout, penirq_n, busy,
			din, dclk, cs, irqf, ncf,
			xcoord, ycoord
		);
end architecture;
