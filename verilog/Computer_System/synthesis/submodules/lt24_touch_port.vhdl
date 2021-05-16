library ieee;
use ieee.std_logic_1164.all;

entity lt24_touch_port is
	port(
		clk, rst: in std_logic;
		address: in std_logic_vector(0 downto 0);
		byteenable: in std_logic_vector(3 downto 0);
		write, read: in std_logic;
		writedata: in std_logic_vector(31 downto 0);
		readdata: out std_logic_vector(31 downto 0);
		irq: out std_logic;
		--External signals
		adc_dout, adc_penirq_n, adc_busy: in std_logic;
		adc_din, adc_dclk, adc_cs: out std_logic
	);
end entity;

architecture arch of lt24_touch_port is
	signal en, irqe, nc, irqf: std_logic;
	signal xcoord, ycoord: std_logic_vector(11 downto 0);

	signal r0, r1: std_logic;
	
	signal wr0: std_logic;

	signal idata0, odata0: std_logic_vector(31 downto 0);
	signal idata1, odata1: std_logic_vector(31 downto 0);
	signal readdata0, readdata1: std_logic_vector(31 downto 0);
	begin
		--Address line
		r0 <= not address(0);
		r1 <= address(0);

		--Holds
		wr0 <= r0 and write;
		crs0: entity work.rs_latch port map(set=>nc, reset=>rst or (wr0 and not writedata(1)), q=>odata0(1));
		crs1: entity work.rs_latch port map(set=>irqf, reset=>rst or (wr0 and not writedata(3)), q=>odata0(3));

		--Inputs
		en <= idata0(0);
		irqe <= idata0(2);

		--Outputs
		irq <= irqf and irqe;
		
		odata0(0) <= en;
		--odata0(1) Latched in holds
		odata0(2) <= irqe;
		--odata0(3) Latched in holds
		odata0(31 downto 4) <= (others => '0');

		odata1(11 downto 0) <= xcoord;
		odata1(15 downto 12) <= (others => '0');
		odata1(27 downto 16) <= ycoord;
		odata1(31 downto 28) <= (others => '0');

		--Port registers
		cportreg0: entity work.port_reg generic map(n => 32)
		port map(
			clk, rst, read, write, r0, byteenable,
			odata0, writedata, readdata0, idata0
		);

		cportreg1: entity work.port_reg generic map(n => 32)
		port map(
			clk, rst, read, write, r1, byteenable,
			odata1, writedata, readdata1, idata1
		);
		
		with address(0) select readdata <=
			readdata0 when '0',
			readdata1 when others;

		--Component
		cltt: entity work.lt24_touch
		port map(
			clk, rst, en,
			adc_dout, adc_penirq_n, adc_busy,
			nc, irqf,
			xcoord, ycoord,
			adc_din, adc_dclk, adc_cs
		);
end architecture;
