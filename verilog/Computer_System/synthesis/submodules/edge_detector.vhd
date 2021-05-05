-- altera vhdl_input_version vhdl_2008
library ieee;
use ieee.std_logic_1164.all;

entity edge_detector is
	port(
		en, rst, sig: in std_logic;
		edge: out std_logic
	);
end entity;

architecture arch of edge_detector is
	signal sr, sf: std_logic;
	begin
		psr: process(sig)
		begin
			if rst = '1' then
				sr <= '0';
			elsif rising_edge(sig) then
				sr <= en;
			end if;
		end process;

		psf: process(sig)
		begin
			if rst = '1' then
				sf <= '0';
			elsif falling_edge(sig) then
				sf <= en;
			end if;
		end process;

		edge <= sr or sf;
end architecture;
