//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-05-19 21:06:32
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-06-27 21:00:34
//# Description: 
//# @Modification History: 2019-05-19 20:58:19
//# Date			    By			   VerDATAn			   Change Description: 
//# ========================================================================= #
//# 2019-05-19 20:58:19
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module lcd1602_funcmod
(
    input CLOCK, RST_n,

	//lcd1602 interface
	output 				LCD1602_RS,		//H: Data; L: Instruction code
	output				LCD1602_RW,		//H: Read; L: Write
	output  			LCD1602_EN,		//LCD1602 Chip enable signal
	output		[7:0]	LCD1602_D,		//LCD1602 Data interface

	//Signal
	input iCall,
	output oDone,
	input [7:0]iDATA
);	 
	 //parameter DELAY_TIME = 1000_000;   //Delay for 20ms
	 localparam DELAY_TIME = 20'd1000;		//Just for test
	 //parameter FCLK = 20'd100_000, FHALF = 20'd50_000; // 500hz,(1/500hz)/(1/50Mhz) FCLK 为一个周期
	 localparam FCLK = 20'd100, FHALF = 20'd50;        //Just for test
	 //parameter FF_Write = 6'd16;//FHALF 为半周期  //tsp1的延时
	 localparam FF_Write = 20'd16;        //Just for test
	
	 
	 assign LCD1602_RW=1'b1;
	 reg [19:0]C1,C2;
    reg [5:0]i,Go;
	 reg [7:0]T; //D1 为暂存读取结果 T 为伪函数的操作空间
	 reg rRS, rEN; 
	 reg [7:0]rDATA;
	 reg isDone; //isQ 为 IO 的控制输出
	 
    always @ ( posedge CLOCK or negedge RST_n )	
	     if( !RST_n )
		      begin
				    { C1,C2 } <={ 20'd0,20'd0 };
				    { i,Go } <= { 6'd0,6'd0 };
					 T  <= 8'd0;
					 { rRS, rEN, rDATA } <= 3'b000;
					  isDone <= 1'b0;
				end
/***********************************************************************
下面步骤是写一个字节的伪函数。步骤 0 拉高片选，准备访问字节，并且进入伪函数。
步骤 1 准备写入数据并且进入伪函数。
步骤 2 拉低片选，步骤 3~4 则是用来产生完成信号。
***********************************************************************/
		   else if( iCall )
			    case( i )
				     
					0://延时20ms
					    begin 
					    	{ rRS,rEN } <= 2'b00; 
					  		if( C2 == DELAY_TIME -1) begin C2 <= 20'd0; i <= i + 1'b1; end
							else C2 <= C2 + 1'b1;
					    end
				
					1:
					    begin { rRS,rEN } <= 2'b10; i <= i + 1'b1; end 
					2:
					    begin T <= iDATA; i <= FF_Write; Go <= i + 1'b1; end
					3:
					    begin { rRS,rEN } <= 2'b00; i <= i + 1'b1; end
					  
					  4:
					  begin isDone <= 1'b1; i <= i + 1'b1; end
					  
					  5:
					  begin isDone <= 1'b0; i <= 6'd1; end
					  
					  /******************/
					  
					  16:
					  begin

					      rDATA <= T;//
							
						if( C1 == 0 ) rEN <= 1'b1;
 					    else if( C1 == FHALF ) rEN <= 1'b0;
					  
					    if( C1 == FCLK -1) begin C1 <= 20'd0; i <= i + 1'b1; end
						else C1 <= C1 + 1'b1;
					  end
					  
					  17:
					  i <= Go;
					  
				 endcase
       
/***********************************************************************
以下内容为相关输出驱动声明，其中 rDATA 驱动 LCD1602_D_DATA， D 驱动 oData	。
***********************************************************************/
		assign { LCD1602_RS,LCD1602_EN } = { rRS,rEN };
		assign LCD1602_D = rDATA ;  //isQ ? rDATA : 1'bz;
		assign oDone = isDone;

endmodule