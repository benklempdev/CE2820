library ieee;
use ieee.std_logic_1164.all;

entity DE10_Lite_Computer is
port (
	--Clock pins
	CLOCK_50, CLOCK2_50, CLOCK_ADC_10 : in std_logic;

	-- ARDUINO
	ARDUINO_IO : inout std_logic_vector(15 downto 0);
	ARDUINO_RESET_N : inout std_logic;
	
	-- SDRAM
	DRAM_ADDR : out std_logic_vector(12 downto 0);
	DRAM_BA : out std_logic_vector(1 downto 0);
	DRAM_CAS_N : out std_logic;
	DRAM_CKE : out std_logic;
	DRAM_CLK : out std_logic;
	DRAM_CS_N : out std_logic;
	DRAM_DQ: inout std_logic_vector(15 downto 0);
	DRAM_LDQM : out std_logic;
	DRAM_RAS_N : out std_logic;
	DRAM_UDQM: out std_logic;
	DRAM_WE_N: out std_logic;

	-- Accelerometer
	G_SENSOR_CS_N : out std_logic;
	G_SENSOR_INT : in std_logic_vector(2 downto 1);
	G_SENSOR_SCLK : out std_logic;
	G_SENSOR_SDI : inout std_logic;
	G_SENSOR_SDO : inout std_logic;
	
	-- forty pin headers
	GPIO : inout std_logic_vector(35 downto 0);

	-- Seven Segment Displays
	HEX0,HEX1,HEX2, HEX3, HEX4, HEX5 : out std_logic_vector(7 downto 0);

	-- Pushbuttons
	KEY : in std_logic_vector(1 downto 0);

	-- LEDs
	LEDR : out std_logic_vector(9 downto 0);

	-- Slider Switches
	SW : in std_logic_vector(9 downto 0);

	-- VGA
	VGA_B, VGA_G, VGA_R : out std_logic_vector(3 downto 0);
	VGA_HS, VGA_VS : out std_logic
	);

end entity DE10_Lite_Computer;


architecture STRUCTURAL of DE10_Lite_Computer is

 component Computer_System is
        port (
		arduino_gpio_export        : inout std_logic_vector(15 downto 0) := (others => 'X'); -- export
		arduino_reset_n_export     : out   std_logic;                                        -- export
		expansion_jp1_export       : inout std_logic_vector(31 downto 0) := (others => 'X'); -- export
		hex3_hex0_export           : out   std_logic_vector(31 downto 0);                    -- export
		hex5_hex4_export           : out   std_logic_vector(31 downto 0);                    -- export
		leds_export                : out   std_logic_vector(9 downto 0);                     -- export
		pushbuttons_export         : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- export
		sdram_addr                 : out   std_logic_vector(12 downto 0);                    -- addr
		sdram_ba                   : out   std_logic_vector(1 downto 0);                     -- ba
		sdram_cas_n                : out   std_logic;                                        -- cas_n
		sdram_cke                  : out   std_logic;                                        -- cke
		sdram_cs_n                 : out   std_logic;                                        -- cs_n
		sdram_dq                   : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
		sdram_dqm                  : out   std_logic_vector(1 downto 0);                     -- dqm
		sdram_ras_n                : out   std_logic;                                        -- ras_n
		sdram_we_n                 : out   std_logic;                                        -- we_n
		sdram_clk_clk              : out   std_logic;                                        -- clk
		slider_switches_export     : in    std_logic_vector(9 downto 0)  := (others => 'X'); -- export
		servo_control_0_export	   : out   std_logic;
		servo_control_1_export	   : out   std_logic;
		--Yay
		video_lt24_controller_0_lcd_on : out   std_logic;
		video_lt24_controller_0_reset_n : out   std_logic;
		video_lt24_controller_0_csx : out   std_logic;
		video_lt24_controller_0_data : out   std_logic_vector(15 downto 0);
		video_lt24_controller_0_rdx : out   std_logic;
		video_lt24_controller_0_wrx : out   std_logic;
		video_lt24_controller_0_dcx : out   std_logic;
		video_pll_0_ref_clk_clk		: in    std_logic;
		video_pll_0_ref_reset_reset: in    std_logic;
		
		system_pll_ref_clk_clk     : in    std_logic                     := 'X';             -- clk
		system_pll_ref_reset_reset : in    std_logic                     := 'X'              -- reset
        );
    end component Computer_System;
	 
	 signal hex3_hex0 : std_logic_vector(31 downto 0); 
	 signal hex5_hex4 : std_logic_vector(31 downto 0);
	 
	 signal hex3_hex0_out : std_logic_vector(31 downto 0);
	 signal hex5_hex4_out : std_logic_vector(31 downto 0);
	 
	 signal dqm : std_logic_vector(1 downto 0);
	 signal jp1 : std_logic_vector(31 downto 0);
	 
	 signal servo_control_0, servo_control_1: std_logic;
	 
	 signal arduino_io_signal: std_logic_vector(15 downto 0);

    signal lt24_data: std_logic_vector(15 downto 0);


begin 

	
	DRAM_UDQM <= dqm(1);
	DRAM_LDQM <= dqm(0);
	

	u0 : component Computer_System
        port map (
				system_pll_ref_clk_clk     => CLOCK_50,     --   system_pll_ref_clk.clk
            system_pll_ref_reset_reset => '0',  -- system_pll_ref_reset.reset
    
				arduino_gpio_export        => ARDUINO_IO_signal,        --         arduino_gpio.export
            arduino_reset_n_export     => ARDUINO_RESET_N,     --      arduino_reset_n.export

				slider_switches_export     => SW,     --      slider_switches.export

				pushbuttons_export         => not KEY,         --          pushbuttons.export

				
            expansion_jp1_export       => jp1,       --        expansion_jp1.export


            hex3_hex0_export           => hex3_hex0,           --            hex3_hex0.export
            hex5_hex4_export           => hex5_hex4,           --            hex5_hex4.export
 
				leds_export                => LEDR,                --                 leds.export
				
				servo_control_0_export	=> servo_control_0,
				servo_control_1_export  => servo_control_1,
				
				video_lt24_controller_0_lcd_on => GPIO(35),
				video_lt24_controller_0_reset_n => GPIO(33),
				video_lt24_controller_0_csx => GPIO(25),
				video_lt24_controller_0_data => lt24_data,
				video_lt24_controller_0_rdx => GPIO(10),
				video_lt24_controller_0_wrx => GPIO(11),
				video_lt24_controller_0_dcx => GPIO(12),
				
				video_pll_0_ref_clk_clk		=> CLOCK_50,
				video_pll_0_ref_reset_reset=> '0',


				sdram_addr                 => DRAM_ADDR,                 --                sdram.addr
            sdram_ba                   => DRAM_BA,                   --                     .ba
            sdram_cas_n                => DRAM_CAS_N,                --                     .cas_n
            sdram_cke                  => DRAM_CKE,                  --                     .cke
            sdram_cs_n                 => DRAM_CS_N,                 --                     .cs_n
            sdram_dq                   => DRAM_DQ,                   --                     .dq
            sdram_dqm                  => dqm,                  --                     .dqm
            sdram_ras_n                => DRAM_RAS_N,                --                     .ras_n
            sdram_we_n                 => DRAM_WE_N,                 --                     .we_n
            sdram_clk_clk              => DRAM_CLK              --            sdram_clk.clk
                        
        );

	chex0: entity work.periph_7seg port map(hex5_hex4(16), hex3_hex0(7 downto 0), hex3_hex0_out(7 downto 0));
	chex1: entity work.periph_7seg port map(hex5_hex4(16), hex3_hex0(15 downto 8), hex3_hex0_out(15 downto 8));
	chex2: entity work.periph_7seg port map(hex5_hex4(16), hex3_hex0(23 downto 16), hex3_hex0_out(23 downto 16));
	chex3: entity work.periph_7seg port map(hex5_hex4(16), hex3_hex0(31 downto 24), hex3_hex0_out(31 downto 24));
	chex4: entity work.periph_7seg port map(hex5_hex4(16), hex5_hex4(7 downto 0), hex5_hex4_out(7 downto 0));
	chex5: entity work.periph_7seg port map(hex5_hex4(16), hex5_hex4(15 downto 8), hex5_hex4_out(15 downto 8));
		  
	phex: process(all)
	begin
		if hex5_hex4(17) = '1' then
			HEX0 <= not hex3_hex0_out(7 downto 0);
			HEX1 <= not hex3_hex0_out(15 downto 8);
			HEX2 <= not hex3_hex0_out(23 downto 16);
			HEX3 <= not hex3_hex0_out(31 downto 24);
			HEX4 <= not hex5_hex4_out(7 downto 0);
			HEX5 <= not hex5_hex4_out(15 downto 8);
		else
			HEX0 <= not hex3_hex0(7 downto 0);
			HEX1 <= not hex3_hex0(15 downto 8);
			HEX2 <= not hex3_hex0(23 downto 16);
			HEX3 <= not hex3_hex0(31 downto 24);
			HEX4 <= not hex5_hex4(7 downto 0);
			HEX5 <= not hex5_hex4(15 downto 8);
		end if;
	end process;
	
	GPIO(24 downto 13) <= lt24_data(15 downto 4);
	GPIO(5) <= lt24_data(3);
	GPIO(6) <= lt24_data(2);
	GPIO(7) <= lt24_data(1);
	GPIO(8) <= lt24_data(0);
	
	ARDUINO_IO <= arduino_io_signal(15 downto 11) & servo_control_1 & servo_control_0 & arduino_io_signal(8 downto 0);
	
	
end architecture STRUCTURAL;
