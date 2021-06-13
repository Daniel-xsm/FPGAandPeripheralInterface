module lcd_control_module
(
    input CLK,
	 input RSTn,
	 
	 input [7:0]Read_Data,
	 output [9:0]Read_Addr_Sig,
	 
	 input SPI_Done_Sig,
	 output SPI_Start_Sig,
	 output [9:0]SPI_Data
);

	 /************************/
	 
	 parameter T25MS = 21'd1_249_999; // 40Hz 50M*0.025-1=1_249_999
	 
	 /************************/
	 
	 reg [20:0]C1;
	 
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
		      C1 <= 21'd0;
		  else if( C1 == T25MS )
		      C1 <= 21'd0;
		  else
		      C1 <= C1 + 1'b1;
				
	 /************************/
	 
	 reg [1:0]isStart;
	 
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
		      isStart <= 2'b10;
		  else if( C1 == T25MS )
		      isStart <= 2'b01;
		  else if( isDone )
		      isStart <= 2'b00;
	 
	 /*************************/
	 
	 reg [5:0]i;
	 reg [9:0]rData;
	 reg [7:0]x;
	 reg [3:0]y;
	 reg isSPI_Start;
	 reg isDone;
	 
	 always @ ( posedge CLK or negedge RSTn )
        if( !RSTn )
		      begin
		          i <= 6'd0;
				    rData <= { 2'b11, 8'h2f };
					 x <= 8'd0;
					 y <= 4'd0;
					 isSPI_Start <= 1'b0;
					 isDone <= 1'b0;
				end	 
		  else if( isStart[1] ) // Initial Function
		      case( i )
				
                0: 
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 2'b00, 8'haf }; isSPI_Start <= 1'b1; end
					 
					 1:
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 2'b00, 8'h40 }; isSPI_Start <= 1'b1; end
					 
					 2:
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 2'b00, 8'ha6 }; isSPI_Start <= 1'b1; end
					 
					 3:
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 2'b00, 8'ha0 }; isSPI_Start <= 1'b1; end
					 
					 4: 
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 2'b00, 8'hc8 }; isSPI_Start <= 1'b1; end
					 
					 5:
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 2'b00, 8'ha4 }; isSPI_Start <= 1'b1; end
					 
					 6:
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 2'b00, 8'ha2 }; isSPI_Start <= 1'b1; end
					 
					 7:
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 2'b00, 8'h2f }; isSPI_Start <= 1'b1; end
					 
					 8:
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 2'b00, 8'h24 }; isSPI_Start <= 1'b1; end
					 
					 9:
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 2'b00, 8'h81 }; isSPI_Start <= 1'b1; end
					 
					 10:
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 2'b00, 8'h24 }; isSPI_Start <= 1'b1; end
					 
					 11:
					 begin rData <= { 2'b11, 8'h2f }; isDone <= 1'b1; i <= i + 1'b1; end
					 
					 12:
					 begin isDone <= 1'b0; i <= 6'd0; end 
		
				endcase
			else if( isStart[0] ) // Draw Function
			    case( i )
				    
					 // Setting Y address ( row of lcd )
				    0, 4, 8, 12, 16, 20, 24, 28:
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 2'b00, 4'hb, y }; isSPI_Start <= 1'b1; end

					 // Setting X address ( column for each row ) [7..4]
					 1, 5, 9, 13, 17, 21, 25, 29:
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 2'b00, 4'h1, 4'h0 }; isSPI_Start <= 1'b1; end
					 
					 // Setting X address ( column for each row ) [3..0]
					 2, 6, 10, 14, 18, 22, 26, 30:
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 2'b00, 4'h0, 4'h0 }; isSPI_Start <= 1'b1; end
					 
					 // Column filling 128 times
					 3, 7, 11, 15, 19, 23, 27, 31:
					 if( x == 8'd128 ) begin y <= y + 1'b1; x <= 8'd0; i <= i + 1'b1; end
                else if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; x <= x + 1'b1; end
					 else begin rData <= { 2'b01, Read_Data }; isSPI_Start <= 1'b1; end
					 
                32:
                begin rData <= { 2'b11, 8'd0 }; y <= 4'd0; isDone <= 1'b1; i <= i + 1'b1; end			
			
                33:
			       begin isDone <= 1'b0; i <= 6'd0; end		 
					
				 endcase	
	/***********************************/
	 
	 assign Read_Addr_Sig = x + (y << 7);
	  
	 assign SPI_Start_Sig = isSPI_Start;
	 assign SPI_Data = rData;
	
	 /*************************************/
	 
endmodule
