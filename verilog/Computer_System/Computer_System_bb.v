
module Computer_System (
	arduino_gpio_export,
	arduino_reset_n_export,
	blinky_export,
	expansion_jp1_export,
	hex3_hex0_export,
	hex5_hex4_export,
	leds_export,
	lt24_touch_dout,
	lt24_touch_penirq_n,
	lt24_touch_busy,
	lt24_touch_din,
	lt24_touch_dclk,
	lt24_touch_cs,
	pushbuttons_export,
	sdram_addr,
	sdram_ba,
	sdram_cas_n,
	sdram_cke,
	sdram_cs_n,
	sdram_dq,
	sdram_dqm,
	sdram_ras_n,
	sdram_we_n,
	sdram_clk_clk,
	servo_control_0_export,
	servo_control_1_export,
	slider_switches_export,
	system_pll_ref_clk_clk,
	system_pll_ref_reset_reset,
	video_lt24_controller_0_lcd_on,
	video_lt24_controller_0_reset_n,
	video_lt24_controller_0_csx,
	video_lt24_controller_0_data,
	video_lt24_controller_0_rdx,
	video_lt24_controller_0_wrx,
	video_lt24_controller_0_dcx,
	video_pll_0_ref_clk_clk,
	video_pll_0_ref_reset_reset,
	i2c_0_serial_sda_in,
	i2c_0_serial_scl_in,
	i2c_0_serial_sda_oe,
	i2c_0_serial_scl_oe);	

	inout	[15:0]	arduino_gpio_export;
	output		arduino_reset_n_export;
	output		blinky_export;
	inout	[31:0]	expansion_jp1_export;
	output	[31:0]	hex3_hex0_export;
	output	[31:0]	hex5_hex4_export;
	output	[9:0]	leds_export;
	input		lt24_touch_dout;
	input		lt24_touch_penirq_n;
	input		lt24_touch_busy;
	output		lt24_touch_din;
	output		lt24_touch_dclk;
	output		lt24_touch_cs;
	input	[1:0]	pushbuttons_export;
	output	[12:0]	sdram_addr;
	output	[1:0]	sdram_ba;
	output		sdram_cas_n;
	output		sdram_cke;
	output		sdram_cs_n;
	inout	[15:0]	sdram_dq;
	output	[1:0]	sdram_dqm;
	output		sdram_ras_n;
	output		sdram_we_n;
	output		sdram_clk_clk;
	output		servo_control_0_export;
	output		servo_control_1_export;
	input	[9:0]	slider_switches_export;
	input		system_pll_ref_clk_clk;
	input		system_pll_ref_reset_reset;
	output		video_lt24_controller_0_lcd_on;
	output		video_lt24_controller_0_reset_n;
	output		video_lt24_controller_0_csx;
	output	[15:0]	video_lt24_controller_0_data;
	output		video_lt24_controller_0_rdx;
	output		video_lt24_controller_0_wrx;
	output		video_lt24_controller_0_dcx;
	input		video_pll_0_ref_clk_clk;
	input		video_pll_0_ref_reset_reset;
	input		i2c_0_serial_sda_in;
	input		i2c_0_serial_scl_in;
	output		i2c_0_serial_sda_oe;
	output		i2c_0_serial_scl_oe;
endmodule
