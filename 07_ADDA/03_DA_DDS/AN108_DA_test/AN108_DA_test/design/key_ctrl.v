module key_ctrl (
   input wire sclk,
   input wire rst_n,
   input wire key_f,
   input wire key_p,
   
   output wire [29:0] fc_word,
   output wire [29:0] pc_word,
	output wire led0
);
 
 
 // 2^30 = 1073741824
 //��ʼƵ��20hz��fc_word = 430,
 
 
 reg [29:0] fc_word_r;
 reg [29:0] pc_word_r;
 reg led0_r;
 
 wire key_flagf;
 wire key_flagp;
 
 //===============================================================
 //����Ƶ�ʿ�����
 always @ (posedge key_f,negedge rst_n) 
    if (!rst_n) 
       fc_word_r <= 30'd1074;
    else //if ( key_flagf)
       fc_word_r <= fc_word_r + 30'd2;//Ƶ�ʲ���0.1
//    else 
//	    fc_word_r <= fc_word_r;
 
 //================================================================
 //������λ������      
  always @ (posedge key_p,negedge rst_n) 
    if (!rst_n) 
       pc_word_r <= 30'd0;//��ʼ��λ0
    else //if ( key_flagf)
       pc_word_r <= pc_word_r + 30'd2;//
//	 else 
//	    pc_word_r <= pc_word_r;
		 
  always @ (posedge key_p,negedge rst_n) 
     if (!rst_n) 
	     led0_r <= 1'b1;
	  else //if ( key_flagp)
	     led0_r <= ~led0_r;
 
 
 assign fc_word = fc_word_r;
 assign pc_word = pc_word_r;
 assign led0 = led0_r;
 
 key_debounce key_debounce_instf(

  .sclk (sclk),
  .rst_n (rst_n),
  .key_in(key_f),
  .key_out(key_flagf)
);

 key_debounce key_debounce_instp(

  .sclk (sclk),
  .rst_n (rst_n),
  .key_in(key_p),
  .key_out(key_flagp)
);
 
endmodule
 
