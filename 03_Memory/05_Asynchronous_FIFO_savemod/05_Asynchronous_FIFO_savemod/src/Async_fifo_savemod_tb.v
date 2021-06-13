`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:19:14 05/28/2018
// Design Name:   fifo
// Module Name:   D:/work/jpf/tst_fpga/async_fifo/test.v
// Project Name:  async_fifo
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fifo
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Async_fifo_savemod_tb();
reg  [7:0] wdata;
reg           winc, wclk, wrst_n; 
reg           rinc, rclk, rrst_n;
wire [7:0] rdata;  
wire           wfull;  
wire          rempty;  

fifo u_fifo (
               .rdata(rdata),  
               .wfull(wfull),  
               .rempty(rempty),  
               .wdata (wdata),  
               .winc  (winc), 
               .wclk  (wclk), 
               .wrst_n(wrst_n), 
               .rinc(rinc), 
               .rclk(rclk), 
               .rrst_n(rrst_n)
 );
localparam CYCLE = 20;
localparam CYCLE1 = 40;



        //ʱ�����ڣ���λΪns�����ڴ��޸�ʱ�����ڡ�
     
            //���ɱ���ʱ��50M
            initial begin
                wclk = 0;
                forever
                #(CYCLE/2)
                wclk=~wclk;
            end
            initial begin
                rclk = 0;
                forever
                #(CYCLE1/2)
                rclk=~rclk;
            end

            //������λ�ź�
            initial begin
                wrst_n = 1;
                #2;
                wrst_n = 0;
                #(CYCLE*3);
                wrst_n = 1;
            end
            
             initial begin
                rrst_n = 1;
                #2;
                rrst_n = 0;
                #(CYCLE*3);
                rrst_n = 1;
            end

            always  @(posedge wclk or negedge wrst_n)begin
                if(wrst_n==1'b0)begin
                    winc <= 0;
                    rinc <= 0;
                end
                else begin
                    winc <= $random;
                    rinc <= $random;
                end
            end

            always  @(posedge rclk or negedge rrst_n)begin
                if(rrst_n==1'b0)begin                  
                    rinc <= 0;
                end
                else begin                
                    rinc <= $random;
                end
            end
always@(*)begin
  if(winc == 1)
    wdata= $random ;
  else
    wdata = 0;
end  
endmodule