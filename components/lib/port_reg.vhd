-- altera vhdl_input_version vhdl_2008
library ieee;
use ieee.std_logic_1164.all;

entity port_reg is
	generic(n: integer := 32);
	port(
		clk, rst: in std_logic;
		read, write: in std_logic;
		iread, iwrite: in std_logic_vector(n-1 downto 0);
		oread, owrite: out std_logic_vector(n-1 downto 0)
	);
end entity;

architecture arch of port_reg is
	signal readdata, writedata: std_logic_vector(n-1 downto 0);
	begin
		--Component output
		pregread: process(all)
		begin
			if falling_edge(clk) then
				if rst = '1' then
					readdata <= (others => '0');
				else
					readdata <= iread;
				end if;
			end if;
		end process;

		with read select oread <=
			readdata when '1',
			(others => '0') when others;

		--Component input
		pregwrite: process(all)
		begin
			if falling_edge(clk) then
				if rst = '1' then
					writedata <= (others => '0');
				elsif write = '1' then
					writedata <= iwrite;
				end if;
			end if;
		end process;

		owrite <= writedata;
end architecture;
