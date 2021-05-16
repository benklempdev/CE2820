-- altera vhdl_input_version vhdl_2008
library ieee;
use ieee.std_logic_1164.all;

entity port_reg is
	generic(n: integer := 32);
	port(
		clk, rst: in std_logic;
		read, write, en: in std_logic;
		byteenable: in std_logic_vector(n/8-1 downto 0);
		iread, iwrite: in std_logic_vector(n-1 downto 0);
		oread, owrite: out std_logic_vector(n-1 downto 0)
	);
end entity;

architecture arch of port_reg is
	signal readdatab, writedatab: std_logic_vector(n-1 downto 0);
	signal readdata, writedata: std_logic_vector(n-1 downto 0);
	signal we: std_logic;
	begin
		--Byteenable
		gber: for i in n/8-1 downto 0 generate
			readdatab(i*8+7 downto i*8) <=
				iread(i*8+7 downto i*8) when byteenable(i) = '1'
				else readdata(i*8+7 downto i*8);
		end generate;

		gbew: for i in n/8-1 downto 0 generate
			writedatab(i*8+7 downto i*8) <=
				iwrite(i*8+7 downto i*8) when byteenable(i) = '1'
				else writedata(i*8+7 downto i*8);
		end generate;

		--Component output
		pregread: process(all)
		begin
			if falling_edge(clk) then
				if rst = '1' then
					readdata <= (others => '0');
				elsif en = '1' then
					readdata <= readdatab;
				end if;
			end if;
		end process;

		with read select oread <=
			readdata when '1',
			(others => '0') when others;

		--Component input
		we <= write and en;
		pregwrite: process(all)
		begin
			if falling_edge(clk) then
				if rst = '1' then
					writedata <= (others => '0');
				elsif we = '1' then
					writedata <= writedatab;
				end if;
			end if;
		end process;

		owrite <= writedata;
end architecture;
