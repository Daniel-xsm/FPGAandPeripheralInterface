//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-05-19 20:56:01
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-07-07 17:16:46
//# Description: 
//# @Modification History: 2019-05-19 20:57:52
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2019-05-19 20:57:52
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module lcd_basemod
(
    input CLOCK, RST_n,
	 //lcd1602 interface
	output 				LCD_RS,		//H: Data; L: Instruction code
	output				LCD_RW,		//H: Read; L: Write
	output  			LCD_EN,		//LCD1602 Chip enable signal
	output		[7:0]	LCD_D		//LCD1602 Data interface

	// input iCall,
	 //output oDone,
	 //input [5:0]iData

);

//****************************************************************************//
//   取模数据
//****************************************************************************//
//--------------------------------
//Driver of LCD1602
localparam	[127:0]	line_rom1 = " Subscriptions: ";//"Hello World*^_^*";//第一行固定显示
wire 	[127:0]  line_rom2; //= "OpenFPGA   *^_^*";//"I am OpenFPGA!";	//第二行滚动显示
localparam	[127:0]	line_rom3 = " I am OpenFPGA!!";
localparam	[127:0]	line_rom4 = "!!!!Welcome!!!!";

//***************************************************************************//
wire DoneU1;
//wire [7:0] oDATA; 


	 lcd_funcmod U1
	 (
	     .CLOCK( CLOCK ),
		  .RST_n( RST_n ),
		  .LCD_RS( LCD_RS ),   // > top
		  .LCD_RW( LCD_RW ),         // > top
		  .LCD_EN( LCD_EN ),         // <> top
		  .LCD_D(LCD_D),
		  .line_rom1( line_rom1 ),    // > top
		  .line_rom2( line_rom2 ),  // > U2
		  .line_rom3( line_rom3 ),  // > U2
		  .line_rom4( line_rom4  ),  // > U2
		  .iCall( 1'b1 ),            // < U1
		  .oDone( DoneU1 )             // > U1


	 );
	 
	 reg [7:0]i;
//	 reg [127:0]isLine_rom2;
    reg [23:0] Data;
	 reg [7:0]isData;
	 always @ ( posedge CLOCK or negedge RST_n )
	     if( !RST_n )
		      begin
					i  <= 8'd0;
					Data <= 24'd0;
					isData <= 8'd0;
//					isLine_rom2 <= {"Number:",Data};
				end
		  else 
		      case( i )
//************************初始化操作*********************************//
					 0 :

					 if( DoneU1 ) begin i <= i + 1'b1;end
					 
					 
					 1 :
					 if( DoneU1) begin  isData<= isData+1'b1;i <= i + 1'b1; end
//					 else begin isCall[1]<= 1'b1; end//Display off
					 
					 2 :
					 if( DoneU1 ) begin 
					 
							if(isData==16) begin isData<=8'd0;i <= i + 1'b1; end
					      else begin i <= i + 1'b1; end
							
					 end//Clear the LCD
					 
					 3:
					  case (isData)
					   0:
							begin Data = "00";i <=i+1'b1;  end
						1:
						   begin Data = "01";i <=i+1'b1;  end
					   2:
							begin Data = "02";i <=i+1'b1;  end
						3:
						   begin Data = "03";i <=i+1'b1;  end						
					   4:
							begin Data = "04";i <=i+1'b1;  end
						5:
						  begin Data = "05";i <=i+1'b1;  end
					   6:
							begin Data = "06";i <=i+1'b1;  end
						7:
						   begin Data = "07";i <=i+1'b1;  end			
					   8:
							begin Data = "08";i <=i+1'b1;  end
						9:
						   begin Data = "09";i <=i+1'b1;  end
					   10:
							begin Data = "10";i <=i+1'b1;  end
						11:
						   begin Data = "11";i <=i+1'b1;  end
						12:
						   begin Data = "12";i <=i+1'b1;  end			
					   13:
							begin Data = "13";i <=i+1'b1;  end
						14:
						   begin Data = "14";i <=i+1'b1;  end
					   15:
							begin Data = "15";i <=i+1'b1;  end
						16:
						   begin Data = "16";i <=i+1'b1;  end						
						
						default :begin Data = "000";i <=i+1'b1;  end	
						
					  endcase
			
					 4:
					 i <= 8'd0;//8'd7
		endcase

	  
	  assign line_rom2 = {" My  Number:",Data};//;
//	  assign oDATA = D1;


endmodule
