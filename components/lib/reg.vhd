-- altera vhdl_input_version vhdl_2008
library ieee;
use ieee.std_logic_1164.all;

--register (default 32-bit)
--active low load
--active low asyncronous reset
entity reg is
	generic (n : integer := 32);
	port(
		ld, rst, clk: in std_logic;
		d: in std_logic_vector(n-1 downto 0);
		q: out std_logic_vector(n-1 downto 0)
	);
end entity;

architecture arch of reg is
	begin
		preg: process(all)
			begin
				if rst='0' then
					q <= (others => '0');
				elsif rising_edge(clk) then
					if ld='0' then
						q <= d;
					end if;
				end if;
		end process;
end architecture;
