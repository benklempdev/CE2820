-- altera vhdl_input_version vhdl_2008
library ieee;
use ieee.std_logic_1164.all;
--Requires reg.vhd

entity edge_reg is
	generic(n : integer := 32);
	port(
		ld, rst, clk: in std_logic;
		d: in std_logic_vector(n-1 downto 0);
		q: out std_logic_vector(n-1 downto 0)
	);
end entity;

architecture arch of edge_reg is
	signal qr, qf: std_logic_vector(n-1 downto 0);
	begin
		cregr: entity work.reg generic map(n => n)
		port map(ld, rst, clk, d, qr);

		cregf: entity work.reg generic map(n => n)
		port map(ld, rst, not clk, d, qf);

		with clk select q <=
			qr when '1',
			qf when others;
end architecture;
