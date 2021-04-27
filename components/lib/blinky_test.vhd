-- altera vhdl_input_version vhdl_2008
library ieee;
use ieee.std_logic_1164.all;

entity blinky_test is
	port(
		rst, clk: in std_logic;
		blinky: out std_logic
	);
end entity;

architecture arch of blinky_test is
	constant max: std_logic_vector(7 downto 0) := x"4a";

	signal psc, clr, ctrl: std_logic;
	signal count: std_logic_vector(7 downto 0);
	begin
		cpsc: entity work.prescaler generic map(n => 12)
		port map('1', rst, clk, x"fff", psc);

		ccnt: entity work.counter generic map(n => 8)
		port map('1', '1', '0', clr, psc, x"00", count);

		blinky <= ctrl;
		pctrl: process(all)
		begin
			if rst = '1' then
				ctrl <= '0';
			elsif rising_edge(clk) then
				if clr = '1' then
					ctrl <= not ctrl;
				end if;
			end if;
		end process;

		pclr: process(all)
		begin
			if count = max then
				clr <= '1';
			else
				clr <= '0';
			end if;
		end process;
end architecture;
