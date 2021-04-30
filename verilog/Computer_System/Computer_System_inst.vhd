	component Computer_System is
		port (
			arduino_gpio_export             : inout std_logic_vector(15 downto 0) := (others => 'X'); -- export
			arduino_reset_n_export          : out   std_logic;                                        -- export
			blinky_export                   : out   std_logic;                                        -- export
			expansion_jp1_export            : inout std_logic_vector(31 downto 0) := (others => 'X'); -- export
			hex3_hex0_export                : out   std_logic_vector(31 downto 0);                    -- export
			hex5_hex4_export                : out   std_logic_vector(31 downto 0);                    -- export
			leds_export                     : out   std_logic_vector(9 downto 0);                     -- export
			pushbuttons_export              : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- export
			sdram_addr                      : out   std_logic_vector(12 downto 0);                    -- addr
			sdram_ba                        : out   std_logic_vector(1 downto 0);                     -- ba
			sdram_cas_n                     : out   std_logic;                                        -- cas_n
			sdram_cke                       : out   std_logic;                                        -- cke
			sdram_cs_n                      : out   std_logic;                                        -- cs_n
			sdram_dq                        : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			sdram_dqm                       : out   std_logic_vector(1 downto 0);                     -- dqm
			sdram_ras_n                     : out   std_logic;                                        -- ras_n
			sdram_we_n                      : out   std_logic;                                        -- we_n
			sdram_clk_clk                   : out   std_logic;                                        -- clk
			servo_control_0_export          : out   std_logic;                                        -- export
			servo_control_1_export          : out   std_logic;                                        -- export
			slider_switches_export          : in    std_logic_vector(9 downto 0)  := (others => 'X'); -- export
			system_pll_ref_clk_clk          : in    std_logic                     := 'X';             -- clk
			system_pll_ref_reset_reset      : in    std_logic                     := 'X';             -- reset
			video_lt24_controller_0_lcd_on  : out   std_logic;                                        -- lcd_on
			video_lt24_controller_0_reset_n : out   std_logic;                                        -- reset_n
			video_lt24_controller_0_csx     : out   std_logic;                                        -- csx
			video_lt24_controller_0_data    : out   std_logic_vector(15 downto 0);                    -- data
			video_lt24_controller_0_rdx     : out   std_logic;                                        -- rdx
			video_lt24_controller_0_wrx     : out   std_logic;                                        -- wrx
			video_lt24_controller_0_dcx     : out   std_logic;                                        -- dcx
			video_pll_0_ref_clk_clk         : in    std_logic                     := 'X';             -- clk
			video_pll_0_ref_reset_reset     : in    std_logic                     := 'X';             -- reset
			iservo_input_0_export           : out   std_logic_vector(15 downto 0);                    -- export
			iservo_input_1_export           : out   std_logic_vector(15 downto 0)                     -- export
		);
	end component Computer_System;

	u0 : component Computer_System
		port map (
			arduino_gpio_export             => CONNECTED_TO_arduino_gpio_export,             --            arduino_gpio.export
			arduino_reset_n_export          => CONNECTED_TO_arduino_reset_n_export,          --         arduino_reset_n.export
			blinky_export                   => CONNECTED_TO_blinky_export,                   --                  blinky.export
			expansion_jp1_export            => CONNECTED_TO_expansion_jp1_export,            --           expansion_jp1.export
			hex3_hex0_export                => CONNECTED_TO_hex3_hex0_export,                --               hex3_hex0.export
			hex5_hex4_export                => CONNECTED_TO_hex5_hex4_export,                --               hex5_hex4.export
			leds_export                     => CONNECTED_TO_leds_export,                     --                    leds.export
			pushbuttons_export              => CONNECTED_TO_pushbuttons_export,              --             pushbuttons.export
			sdram_addr                      => CONNECTED_TO_sdram_addr,                      --                   sdram.addr
			sdram_ba                        => CONNECTED_TO_sdram_ba,                        --                        .ba
			sdram_cas_n                     => CONNECTED_TO_sdram_cas_n,                     --                        .cas_n
			sdram_cke                       => CONNECTED_TO_sdram_cke,                       --                        .cke
			sdram_cs_n                      => CONNECTED_TO_sdram_cs_n,                      --                        .cs_n
			sdram_dq                        => CONNECTED_TO_sdram_dq,                        --                        .dq
			sdram_dqm                       => CONNECTED_TO_sdram_dqm,                       --                        .dqm
			sdram_ras_n                     => CONNECTED_TO_sdram_ras_n,                     --                        .ras_n
			sdram_we_n                      => CONNECTED_TO_sdram_we_n,                      --                        .we_n
			sdram_clk_clk                   => CONNECTED_TO_sdram_clk_clk,                   --               sdram_clk.clk
			servo_control_0_export          => CONNECTED_TO_servo_control_0_export,          --         servo_control_0.export
			servo_control_1_export          => CONNECTED_TO_servo_control_1_export,          --         servo_control_1.export
			slider_switches_export          => CONNECTED_TO_slider_switches_export,          --         slider_switches.export
			system_pll_ref_clk_clk          => CONNECTED_TO_system_pll_ref_clk_clk,          --      system_pll_ref_clk.clk
			system_pll_ref_reset_reset      => CONNECTED_TO_system_pll_ref_reset_reset,      --    system_pll_ref_reset.reset
			video_lt24_controller_0_lcd_on  => CONNECTED_TO_video_lt24_controller_0_lcd_on,  -- video_lt24_controller_0.lcd_on
			video_lt24_controller_0_reset_n => CONNECTED_TO_video_lt24_controller_0_reset_n, --                        .reset_n
			video_lt24_controller_0_csx     => CONNECTED_TO_video_lt24_controller_0_csx,     --                        .csx
			video_lt24_controller_0_data    => CONNECTED_TO_video_lt24_controller_0_data,    --                        .data
			video_lt24_controller_0_rdx     => CONNECTED_TO_video_lt24_controller_0_rdx,     --                        .rdx
			video_lt24_controller_0_wrx     => CONNECTED_TO_video_lt24_controller_0_wrx,     --                        .wrx
			video_lt24_controller_0_dcx     => CONNECTED_TO_video_lt24_controller_0_dcx,     --                        .dcx
			video_pll_0_ref_clk_clk         => CONNECTED_TO_video_pll_0_ref_clk_clk,         --     video_pll_0_ref_clk.clk
			video_pll_0_ref_reset_reset     => CONNECTED_TO_video_pll_0_ref_reset_reset,     --   video_pll_0_ref_reset.reset
			iservo_input_0_export           => CONNECTED_TO_iservo_input_0_export,           --          iservo_input_0.export
			iservo_input_1_export           => CONNECTED_TO_iservo_input_1_export            --          iservo_input_1.export
		);

