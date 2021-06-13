//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-05-19 20:55:44
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-06-23 03:27:46
//# Description: 
//# @Modification History: 2019-05-19 20:58:05
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2019-05-19 20:58:05
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module max7219_ctrlmod
(
    input CLOCK, RST_n,	 
//	 input iCall,
//	 output oDone,
//	 input [63:0]iData,
//	 output oCall,
//	 input iDone,
	 output MAX7219_CS, MAX7219_SCLK,
	 output MAX7219_DATA
//	 output [7:0]oDATA0, oDATA1
);	 
wire [7:0]oDATA0, oDATA1;
wire oCall,iDone;
wire oDone;
max7219_funcmod U1
	 (
	     .CLOCK( CLOCK ),
		  .RST_n( RST_n ),
		  .MAX7219_CS( MAX7219_CS ),   // > top
		  .MAX7219_SCLK( MAX7219_SCLK ),         // > top
		  .MAX7219_DATA( MAX7219_DATA ),         // <> top
		  .iCall( oCall ),            // < U1
		  .oDone( iDone ),              // > U1
		  .iDATA0( oDATA0 ),              // > U1
		  .iDATA1( oDATA1 )              // > U1
	 );

	 reg [7:0]D1,D2;
	 reg [7:0]i;
	 	 reg [1:0]isCall;
	 reg isDone;
	 always @ ( posedge CLOCK or negedge RST_n )
	     if( !RST_n )
		      begin
				    D1 <= 8'd0;
					D2 <= 8'd0;
					i  <= 8'd0;
				end
		  else if ( 1'b1 )
		      case( i )
//************************初始化操作*********************************//
				    8'd0 : // 译码方式：BCD码
					 begin D1 = 8'h09; D2 = 8'h00; i <= i+1; end

				    8'd1 : // 亮度 
					 begin D1 = 8'h0a; D2 = 8'h03; i <= i+1; end

					 8'd2 : // 扫描界限；8个数码管显示
					 begin D1 = 8'h0b; D2 = 8'h07; i <= i+1; end

					 8'd3 : // 掉电模式：0，普通模式：1
					 begin D1 = 8'h0c; D2 = 8'h01; i <= i+1; end
				
					 8'd4 : // 显示测试：1；测试结束，正常显示：0
					 begin D1 = 8'h0f; D2 = 8'h00; i <= i+1; end
//************************初始化操作结束******************************//	
//************************显示第一位*********************************//
//0x40,0x40,0x40,0x40,0x40,0x40,0x40,0x7E	
					8'd5 : 
					 begin D1 =8'h01; D2 = 8'h7E; i <= i+1; end
					 
					8'd6 : 
					 begin D1 = 8'h02; D2 = 8'h40; i <= i+1; end

					8'd7 : 
					 begin D1 = 8'h03; D2 = 8'h40; i <= i+1; end

					8'd8 : 
					 begin D1 = 8'h04; D2 =8'h40; i <= i+1; end

					8'd9 : 
					 begin D1 = 8'h05; D2 =8'h40; i <= i+1; end

					8'd10 : 
					 begin D1 = 8'h06; D2 =8'h40; i <= i+1; end

					8'd11 : 
					 begin D1 = 8'h07; D2 =8'h40; i <= i+1; end

					8'd12 : 
					 begin D1 = 8'h08; D2 =8'h40; i <= i+1; end
	
					8'd13 : // 循环显示
					 begin i <= 8'd5;  end

				endcase
	 
	 reg [1:0] j;

	 
	 always @ ( posedge CLOCK or negedge RST_n )
	     if( !RST_n )
		      begin
				     j <= 2'd0;
					 isCall <= 2'b00;
					 isDone <= 1'b0;
				end
		  else if( 1'b1 ) // Write actioniCall
		      case( j )
				
				    0 :
					 if( iDone ) begin isCall <= 1'b0; j <= j + 1'b1; end
					 else begin isCall <= 1'b1; end
					 
					 1 :
					 begin isDone <= 1'b1; j <= j + 1'b1; end
					 
					 2 :
					 begin isDone <= 1'b0; j <= 2'd0; end
					  
				endcase
	  
	  assign oDone = isDone;
	  assign oCall = isCall;
	  assign oDATA0 = D1;
	  assign oDATA1 = D2;

endmodule
