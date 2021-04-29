-- altera vhdl_input_version vhdl_2008
-- Use x500 prescaler (200 cycles per 1ms on 50MHz clock)
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
	constant scaler_s: integer := 9;
	constant period_s: integer := 12;
	constant scaler: std_logic_vector(scaler_s-1 downto 0) := "1" & x"f4"; --500
	constant period: std_logic_vector(period_s-1 downto 0) := x"fa0"; --4000

	signal cpos, ipos: std_logic_vector(7 downto 0);
	signal count: std_logic_vector(period_s-1 downto 0);
	signal psc, irst, clr: std_logic;
	begin
		--use ipos for compare register value
		--keep internal count
		--run counter on en
		--load sets compare register
		--reset all on irst
		--control outputs to servo (pin mapping?)
		
		--Prescaler
		cpsc: entity work.prescaler generic map(n => scaler_s)
		port map(en, irst, clk, scaler, psc);
		
		--Count
		ccnt: entity work.counter generic map(n => period_s)
		port map('1', en, '0', clr, psc, x"000", count);

		--Clear output pulse on match
		pctrl: process(all)
		begin
			if irst = '1' then
				control <= '0';
			elsif rising_edge(clk) then
				if unsigned(x"0"&cpos) + 200 = unsigned(count) then
					control <= '0';
				elsif en = '1' and count = x"000" then
					control <= '1';
				end if;
			end if;
		end process;

		--Clear signal for counter
		pclr: process(all)
		begin
			if irst = '1' or period = count then
				clr <= '1';
			else
				clr <= '0';
			end if;
		end process;

		--Clamp max value
		pcpos: process(all)
		begin
			if unsigned(ipos) > 200 then
				cpos <= x"c8";
			else
				cpos <= ipos;
			end if;
		end process;
		
		--Only change value at period border
		pipos: process(all)
		begin
			if clr = '1' then
				ipos <= pos;
			end if;
		end process;

		pirst: process(all)
		begin
			if rst = '1' or pos = x"ff" then
				irst <= '1';
			else
				irst <= '0';
			end if;
		end process;
end architecture;
