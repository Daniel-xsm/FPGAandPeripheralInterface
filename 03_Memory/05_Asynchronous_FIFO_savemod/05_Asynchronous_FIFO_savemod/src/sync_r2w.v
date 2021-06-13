//****************************************************************************//
//# @Author: ����˼
//# @Date:   2019-04-07 03:20:23
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-08-25 01:13:15
//# Description: 
//# @Modification History: 2018-05-28 20:25:36
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2018-05-28 20:25:36
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
`timescale 1ns / 1ps

module sync_r2w
#(
    parameter ADDRSIZE = 4
)
(
    output reg [ADDRSIZE:0] wq2_rptr,   //��ָ��ͬ����дʱ����
    input      [ADDRSIZE:0] rptr,       // ��������ʽ�Ķ�ָ�룬������ĺô������ϸ˵ 
    input                   wclk, wrst_n
);
 
reg [ADDRSIZE:0] wq1_rptr;
 
  always @(posedge wclk or negedge wrst_n)   
      if (!wrst_n) begin
          wq1_rptr <= 0;          
          wq2_rptr <= 0;
      end           
      else begin        
          wq1_rptr<= rptr;
          wq2_rptr<=wq1_rptr;
      end          
  endmodule
