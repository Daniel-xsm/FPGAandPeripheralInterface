#------------------GLOBAL--------------------#
set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"
set_global_assignment -name ENABLE_INIT_DONE_OUTPUT OFF

#��λ����
set_location_assignment	PIN_M1	-to RST_n

#ʱ������
set_location_assignment	PIN_R9	-to CLOCK



#��λ����
set_location_assignment	PIN_M1	-to RSTn

#ʱ������
set_location_assignment	PIN_R9	-to CLK

#Һ������Ӧ������
#LCD_CS
set_location_assignment	PIN_J16	-to SPI_Out[3]	
#LCD_A0
set_location_assignment	PIN_N1	-to SPI_Out[2]	
#LCD_SCL
set_location_assignment	PIN_L16	-to SPI_Out[1]
#LCD_SI
set_location_assignment	PIN_K16	-to SPI_Out[0]






