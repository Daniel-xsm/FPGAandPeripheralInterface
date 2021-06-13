module	DDS	(
										input wire sclk,
										input wire rst_n,
										input wire [29:0] fc_word,
										input wire [29:0] pc_word,
										output wire [7:0] o_wave,
										output wire  clk_DA
										//output wire pd
										);
										
		//parameter define
//		parameter WIDTH = 32'd30; //data width
//		parameter SIZE = 32'd14;	//da_data width							
										
		reg [29:0] fc_word_r;
		reg [29:0] pc_word_r;							
		reg [9:0] phase_add;		//��λ�ۼ���
		reg [29:0] fc_count;
	  wire [9:0] addr;							
										

	//parameter FC_WORD = 40'd1099512;  // frequency control Word
	//20hz   10995116
	//200hz  109951163 
	//2khz   1099511627
	//2^40 = 1099511627776
//	parameter FRQ_ADD = 32'd9346/2;	
//	parameter INIT_PHASE = 32'd2147483648;	

	always @(posedge sclk or negedge rst_n)  
        if (!rst_n)  
            fc_word_r <= 30'd0;
        else  
            fc_word_r <= fc_word;

  
  always @(posedge sclk or negedge rst_n)  
        if (!rst_n)  
            pc_word_r <= 30'd0;
        else  
            pc_word_r <= pc_word;
//��Ƶ
  always @ (posedge sclk,negedge rst_n)
       if (!rst_n)
          fc_count <= 30'd0;
       else 
          fc_count <= fc_count + fc_word_r;
  
	//����	
	always @ (posedge sclk, negedge rst_n)
		if (!rst_n)
			phase_add <= 10'd0;
		else
			phase_add <= pc_word_r + fc_count[29:20];
			
			
	//assign addr = phase_add [29:20];	
	
	assign clk_DA = sclk;
	 
   
ram1024x8	ram1024x8_inst (
	.address ( phase_add ),
	.clock ( sclk ),
	.data ( 8'd0 ),
	.wren ( 1'b0 ),  //read data
	.q ( o_wave )
	);
	



	
	
endmodule

