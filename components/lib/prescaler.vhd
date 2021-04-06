-- altera vhdl_input_version vhdl_2008
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--Requires counter.vhd

entity prescaler is
	generic(n : integer := 32);
	port(
		en, rst, clk: in std_logic;
		scaler: in std_logic_vector(n-1 downto 0);
		sclk: out std_logic
	);
end entity;

architecture arch of prescaler is
	signal hold, wave: std_logic;
	signal clr, oclk: std_logic;
	signal countr, countf: std_logic_vector(n-2 downto 0);
	signal icount: unsigned(n-1 downto 0);
	signal count: std_logic_vector(n-1 downto 0);
	signal prevscaler, uscaler: unsigned(n-1 downto 0);
	signal urst, srst: std_logic;
	
	
	signal zero: std_logic_vector(n-2 downto 0) := (others => '0'); --constant
	begin
		--Internal counters
		--Cleared if they triggered last update
		--Set to 1 if they did not
		--Counts rising edges
		ccntr: entity work.counter generic map(n => n-1)
		port map('1', en, not clk and clr, (clk and clr) or urst, clk, ((0) => '1', others => '0'), countr);
		--Counts falling edges
		ccntf: entity work.counter generic map(n => n-1)
		port map('1', en, clk and clr, (not clk and clr) or urst, not clk, ((0) => '1', others => '0'), countf);
		
		--Total edge count
		icount <= unsigned('0'&countr) + unsigned('0'&countf);
		count <= std_logic_vector(icount);

		--Match signal
		cedge: entity work.edge_detector port map(clr, urst or not clr, clk, wave);
		
		pclr: process(all)
		begin
			if count = std_logic_vector(uscaler - 1) then
				clr <= '1';
			elsif urst = '1' then
				clr <= '0';
			elsif wave = '1' then
				clr <= '0';
			end if;
		end process;

		--Toggle output
		ppsc: process(all)
		begin
			if urst = '1' then
				oclk <= '0';
			elsif rising_edge(clr) then
				oclk <= not oclk;
			end if;
		end process;

		uscaler <= unsigned(scaler);
		urst <= srst or rst;
		pquickfix1: process (all)
		begin
			if urst = '1' then
				srst <= '0';
			elsif rising_edge(clk) then
				if not (prevscaler = uscaler) then
					srst <= '1';
					prevscaler <= uscaler;
				end if;
			end if;
		end process;
				
		
		pquickfix0: process(all)
		begin
			if uscaler = 0 then
				sclk <= '0';
			elsif uscaler = 1 then
				sclk <= clk;
			else
				sclk <= oclk;
			end if;
		end process;

		--async reset
		--if count = scaler
		--	clear counter(prev edge)
		--		cntr <= clk and clr
		--		ctrf <= not clk and clr
		--	load 1 into counter(next edge)
		--		cntr <= not clk and ld
		--		cntf <= clk and ld
		--	toggle clock output
end architecture;
