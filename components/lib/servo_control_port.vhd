-- altera vhdl_input_version vhdl_2008
library ieee;
use ieee.std_logic_1164.all;
use work.port_pkg.all;

entity servo_control_port is
	port(
		avalon: in port16_t;
		writedata: in bus16_t;
		readdata: out bus16_t;
		control: out std_logic
	);
end entity;

architecture arch of servo_control_port is
	signal en, rst, clk: std_logic;
	signal pos: std_logic_vector(7 downto 0);

	signal data: std_logic_vector(15 downto 0);
	begin
		--Map signals
		rst <= avalon.rst;
		clk <= avalon.clk;
		en <= data(8);
		pos <= data(7 downto 0);

		--Port registers
		cportreg: entity work.port_reg generic map(n => 16)
		port map(clk, rst, avalon.read, avalon.write, data, writedata, readdata, data);

		--servo_control component
		csrvctrl: entity work.servo_control port map(en, rst, clk, pos, control);
end architecture;
