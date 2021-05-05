-- altera vhdl_input_version vhdl_2008
library ieee;
use ieee.std_logic_1164.all;

entity blinky_test_port is
	port(
		clk, reset: in std_logic;
--		address: in std_logic_vector(0 downto 0);
--		bytenable: in std_logic_vector(0 downto 0);
--		write, read: in std_logic;
--		writedata: in std_logic_vector(7 downto 0);
--		readdata: out std_logic_vector(7 downto 0);
		oblinky: out std_logic
	);
end entity;

architecture arch of blinky_test_port is
	signal data: std_logic_vector(7 downto 0);
	begin
--		cportreg: entity work.port_reg generic map(n => 8)
--		port map(clk, reset, read, write, data, writedata, readdata, data);

		coblinky: entity work.blinky_test port map(reset, clk, oblinky);
end architecture;
