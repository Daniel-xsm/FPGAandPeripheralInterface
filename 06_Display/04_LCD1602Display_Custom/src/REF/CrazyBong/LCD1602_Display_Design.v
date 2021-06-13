/*-----------------------------------------------------------------------
								 \\\|///
							   \\  - -  //
								(  @ @  )  
+-----------------------------oOOo-(_)-oOOo-----------------------------+
CONFIDENTIAL IN CONFIDENCE
This confidential and proprietary software may be only used as authorized
by a licensing agreement from CrazyBingo (Thereturnofbingo).
In the event of publication, the following notice is applicable:
Copyright (C) 2012-20xx CrazyBingo Corporation
The entire notice above must be reproduced on all authorized copies.
Author				:		CrazyBingo
Technology blogs 	: 		www.crazyfpga.com
Email Address 		: 		crazyfpga@vip.qq.com
Filename			:		LCD1602_Display_Design.v
Date				:		2013-10-28
Description			:		Design for LCD1602 Display.
Modification History	:
Date			By			Version			Change Description
=========================================================================
11/06/25		CrazyBingo	1.0				Original
13/10/28		CrazyBingo	2.0				Modification
-------------------------------------------------------------------------
|                                     Oooo								|
+-------------------------------oooO--(   )-----------------------------+
                               (   )   ) /
                                \ (   (_/
                                 \_)
-----------------------------------------------------------------------*/

`timescale 1ns/1ns
module LCD1602_Display_Design
(
	//global clock
	input				CLOCK,
	input				RST_n,

	//lcd1602 interface
	output 				LCD1602_RS,		//H: Data; L: Instruction code
	output				LCD1602_RW,		//H: Read; L: Write
	output  			LCD1602_EN,		//LCD1602 Chip enable signal
	output		[7:0]	LCD1602_D		//LCD1602 Data interface
	
); 


//--------------------------------
//Driver of LCD1602
localparam	[127:0]	line_rom1 = "Hello World*^_^*";
localparam 	[127:0] line_rom2 = "I am CrazyBingo!";	
lcd1602_driver	u_lcd1602_driver
(
	//global clock
	.clk				(CLOCK),			//50MHz
	.rst_n				(RST_n),

	//lcd1602 interface
	.lcd_rs				(LCD1602_RS),	//H: Data; L: Instruction code
	.lcd_rw				(LCD1602_RW),	//H: Read; L: Write
	.lcd_en				(LCD1602_EN),	//LCD1602 Chip enable signal
	.lcd_data			(LCD1602_D),	//LCD1602 Data interface
	
	//user interface
	.line_rom1			(line_rom1),	//LCD1602 1th row display
	.line_rom2			(line_rom2)		//LCD1602 2th row display
); 


endmodule
	
