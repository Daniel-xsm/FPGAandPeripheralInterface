module lcd_interface
(
    input CLOCK,
	 input RST_n,
	 
	 input Write_En_Sig,
	 input [9:0]Write_Addr_Sig,
	 input [7:0]Write_Data,
	 
	 output [3:0]SPI_Out // [3]CS [2]A0 [1]SCLOCK [0]SDA
);

    /********************************/
	 
	 wire [7:0]Read_Data;
	 
	 lcd_ram_module U1
	 (
	     .CLOCK( CLOCK ),
		  .RST_n( RST_n ),
		  .Write_En_Sig( Write_En_Sig ),       // input - from top
		  .Write_Addr_Sig( Write_Addr_Sig ),   // input - from top
		  .Write_Data( Write_Data ),           // input - from top
		  .Read_Addr_Sig( Read_Addr_Sig ),     // input - from U2
		  .Read_Data( Read_Data )              // output - to U2
	 );
	 
	 /*********************************/
	 
	 wire [9:0]Read_Addr_Sig;
	 wire SPI_Start_Sig;
	 wire [9:0]SPI_Data;
	 
	 lcd_control_module U2
	 (
	     .CLOCK( CLOCK ),
		  .RST_n( RST_n ),
		  .Read_Data( Read_Data ),           // input - from U1
		  .Read_Addr_Sig( Read_Addr_Sig ),   // output - to U1
		  .SPI_Done_Sig( SPI_Done_Sig ),     // input - from U3
		  .SPI_Start_Sig( SPI_Start_Sig ),   // output - to U3
		  .SPI_Data( SPI_Data )              // output - to U3
	 );


 /************************************
	spi U3
(
	.CLOCK( CLOCK ),
	.RST_n( RST_n ),
	.I_rx_en(SPI_Data[8]),
	.I_tx_en(!SPI_Data[9]),
	.iData (SPI_Data[7:0]),
	.oData(),
	.iDone(SPI_Done_Sig),
	.oDone(),
	.I_spi_miso(SPI_Out[2])  , // SPI串行输入，用来接收从机的数据
    .O_spi_sck(SPI_Out[1])   , // SPI时钟
    .O_spi_cs(SPI_Out[3])    , // SPI片选信号
    .O_spi_mosi(SPI_Out[0])    // SPI输出，用来给从机发送数据
);
	 ************************************/	 
	 /************************************/
	 
	 wire SPI_Done_Sig;
	 
	 spi_write_module U3
	 (
	     .CLOCK( CLOCK ),
		  .RST_n( RST_n ),
		  .Start_Sig( SPI_Start_Sig ),   // input - from U2
		  .SPI_Data( SPI_Data ),         // input - from U2
		  .Done_Sig( SPI_Done_Sig ),     // output - to U2
		  .SPI_Out( SPI_Out )            // output - to top
	 );
	 
	/************************************/

endmodule
