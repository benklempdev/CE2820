-- altera vhdl_input_version vhdl_2008
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity servo_control is
	port(
		en, rst, clk: in std_logic;
		pos: in std_logic_vector(7 downto 0);
		control: out std_logic
	);
end entity;

architecture arch of servo_control is
	constant ms_cycles: unsigned(8 downto 0) := "0" & x"c8";  --200
	
	constant prescaler: std_logic_vector(7 downto 0) := x"f4";  --250
	constant period: std_logic_vector(11 downto 0) := x"fa0";  --4000

	signal psc, clr, ltp: std_logic;
	signal count: std_logic_vector(11 downto 0);
	signal cpos: std_logic_vector(7 downto 0);
	signal pulse: unsigned(8 downto 0);
	begin

		--Prescaler (x250)
		cpsc: entity work.prescaler generic map(n => 8)
		port map(en, rst, clk, prescaler, psc);

		--Counter
		ccnt: entity work.counter generic map(n => 12)
		port map('1', en, '0', clr or rst, psc, x"000", count);
		
		--Pulse width
		pulse <= unsigned("0"&cpos) + ms_cycles;

		--Control signal
		ltp <= '1' when count < std_logic_vector("000" & pulse) else '0';
		control <= ltp and not rst and en;

		--Period clear signal
		clr <= '1' when count >= period else '0';
		
		--Clamped position signal
		cpos <= x"c8" when (pos > x"c8") else pos;
end architecture;
