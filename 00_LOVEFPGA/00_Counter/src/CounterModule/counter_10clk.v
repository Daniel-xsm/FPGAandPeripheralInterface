module counter_10clk
(
   CLOCK, RST_n,
	en,
	dout
);

   input CLOCK, RST_n;   //全局时钟信号输入
	input en;             //计数器使能信号
	output reg dout;          //计数器输出信号

parameter counter_value= 4'd10;  //计数时钟个数


reg [7:0] cnt;
wire add_cnt,end_cnt;


always @ ( posedge CLOCK or negedge RST_n )
	    if( !RST_n )
		       begin
				    cnt <= 0;
				 end
		else if(add_cnt)
			begin
		        if(end_cnt)
		        	cnt <= 0;
		        else
		        	cnt <= cnt + 1;
		    end
always @ ( posedge CLOCK or negedge RST_n )
	    if( !RST_n )
		   begin
				   dout <= 1;
		   end
		else if(en)
			begin
		         dout <= 1;
		    end
		else if(end_cnt)
		   begin
		        	dout <= 0;
		   end
		    
assign add_cnt = dout == 1'b1;
assign end_cnt = add_cnt && cnt == counter_value-1;

endmodule