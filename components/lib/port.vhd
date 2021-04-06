-- altera vhdl_input_version vhdl_2008
library ieee;
use ieee.std_logic_1164.all;

package port_pkg is
	type port8_t is record
		clk, rst: std_logic;
		address: std_logic_vector(0 downto 0);
		byteenable: std_logic_vector(0 downto 0);
		write, read: std_logic;
	end record;
	type port16_t is record
		clk, rst: std_logic;
		address: std_logic_vector(0 downto 0);
		byteenable: std_logic_vector(1 downto 0);
		write, read: std_logic;
	end record;
	type port32_t is record
		clk, rst: std_logic;
		address: std_logic_vector(0 downto 0);
		byteenable: std_logic_vector(3 downto 0);
		write, read: std_logic;
	end record;

	subtype bus8_t is std_logic_vector(7 downto 0);
	subtype bus16_t is std_logic_vector(15 downto 0);
	subtype bus32_t is std_logic_vector(31 downto 0);
end package;
