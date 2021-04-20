-- altera vhdl_input_version vhdl_2008
library ieee;
use ieee.std_logic_1164.all;
use work.port_pkg.all;

entity servo_control_port is
	port(
		clk, rst: in std_logic;
		address : in std_logic_vector(0 downto 0);
		byteenable: in std_logic_vector(1 downto 0);
		write, read: in std_logic;
		writedata: in bus16_t;
		readdata: out bus16_t;
		control: out std_logic
	);
end entity;

architecture arch of servo_control_port is
	signal en: std_logic;
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
		port map(clk, rst, read, write, data, writedata, readdata, data);

		--servo_control component
		csrvctrl: entity work.servo_control port map(en, rst, clk, pos, control);
end architecture;
