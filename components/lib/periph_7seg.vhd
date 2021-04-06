-- altera vhdl_input_version vhdl_2008
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity periph_7seg is
	port(
		enable: in std_logic;
		digit: in std_logic_vector(7 downto 0);
		display: out std_logic_vector(7 downto 0)
	);
end entity;

architecture arch of periph_7seg is
	signal disp_buf: std_logic_vector(7 downto 0);
	begin
		with digit select disp_buf <=
			x"3f" when x"00",
			x"06" when x"01",
			x"5b" when x"02",
			x"4f" when x"03",
			x"66" when x"04",
			x"6d" when x"05",
			x"7d" when x"06",
			x"07" when x"07",
			x"7f" when x"08",
			x"6f" when x"09",
			x"77" when x"0a",
			x"7c" when x"0b",
			x"39" when x"0c",
			x"5e" when x"0d",
			x"79" when x"0e",
			x"71" when x"0f",
			x"00" when others;

		pdisp: process(all)
		begin
			if enable = '1' then
				display <= disp_buf;
			else
				display <= x"00";
			end if;
		end process;
end architecture;
