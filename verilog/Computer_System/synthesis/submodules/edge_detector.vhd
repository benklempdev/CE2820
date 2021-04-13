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
	signal last: std_logic;
	begin
		pedge: process(all)
		begin
			last <= sig;
			if rst = '1' then
				edge <= '0';
			elsif en = '1' then
				if sig xor last then
					edge <= '1';
				end if;
			end if;
		end process;
end architecture;
