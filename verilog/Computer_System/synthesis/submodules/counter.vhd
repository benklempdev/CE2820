-- altera vhdl_input_version vhdl_2008
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--Requires reg.vhd

--Active high	rst, ld, en
--Upcounter on u=1
entity counter is
	generic(n : integer := 32);
	port(
		u, en, ld, rst, clk: in std_logic;
		value: in std_logic_vector(n-1 downto 0);
		count: out std_logic_vector(n-1 downto 0)
	);
end entity;

architecture arch of counter is
	signal go: std_logic;
	signal d, q: std_logic_vector(n-1 downto 0);
	signal nval, incr: unsigned(n-1 downto 0);
	begin
		--Register
		creg: entity work.reg generic map(n => n)
		port map('0', not rst, clk, d, q);

		--q -> new value -> count -> d
		--Count / Load
		with ld select nval <=
			unsigned(q) when '0',
			unsigned(value) when others;

		--Decrement / Increment
		with u select incr <=
			nval + 1 when '1',
			nval - 1 when others;

		--Hold / Update
		with go select d <=
			std_logic_vector(incr) when '1',
			q when others;

		pgo: process(all)
		begin
			if rst = '1' then
				go <= '0';
			elsif rising_edge(clk) then
				go <= en;
			end if;
		end process;
		
		count <= d;
end architecture;
