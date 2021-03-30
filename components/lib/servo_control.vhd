-- Use x250 prescaler (200 cycles per 1ms on 50MHz clock)
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
	constant scaler: std_logic_vector(7 downto 0) := x"fa"; --250
	constant period: std_logic_vector(11 downto 0) := x"fa0"; --4000

	signal ipos: std_logic_vector(7 downto 0);
	signal value: std_logic_vector(7 downto 0);
	signal count: std_logic_vector(11 downto 0);
	signal psc, clr: std_logic;
	begin
		--use ipos for compare register value
		--keep internal count
		--run counter on en
		--load sets compare register
		--reset all on rst
		--control outputs to servo (pin mapping?)
		
		--Prescaler
		cpsc: entity work.prescaler generic map(n => 8)
		port map(en, rst, clk, scaler, psc);
		
		--Count
		ccnt: entity work.counter generic map(n => 12)
		port map('1', en, '0', clr, psc, x"000", count);

		--Clear output pulse on match
		pctrl: process(all)
		begin
			if rst = '1' then
				control <= '0';
			elsif rising_edge(clk) then
				if unsigned(x"0"&ipos) + 200 = unsigned(count) then
					control <= '0';
				elsif en = '1' and count = x"000" then
					control <= '1';
				end if;
			end if;
		end process;

		--Clear signal for counter
		pclr: process(all)
		begin
			if rst = '1' or period = count then
				clr <= '1';
			else
				clr <= '0';
			end if;
		end process;

		pipos: process(all)
		begin
			if unsigned(pos) > 200 then
				ipos <= x"c8";
			else
				ipos <= pos;
			end if;
		end process;
end architecture;
