#------------------GLOBAL--------------------#
set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"
set_global_assignment -name ENABLE_INIT_DONE_OUTPUT OFF

#��λ����
set_location_assignment	PIN_M1	-to RST_n

#ʱ������
set_location_assignment	PIN_R9	-to CLOCK

#Һ������Ӧ������
set_location_assignment	PIN_L1	-to LCD_CS
set_location_assignment	PIN_N1	-to LCD_A0
set_location_assignment	PIN_L2	-to LCD_SCL
set_location_assignment	PIN_P1	-to LCD_SI


#��λ����
set_location_assignment	PIN_M1	-to RSTn

#ʱ������
set_location_assignment	PIN_R9	-to CLK
#Һ������Ӧ������
#LCD_CS
set_location_assignment	PIN_L1	-to SPI_Out[3]	
#LCD_A0
set_location_assignment	PIN_N1	-to SPI_Out[2]	
#LCD_SCL
set_location_assignment	PIN_L2	-to SPI_Out[1]
#LCD_SI
set_location_assignment	PIN_P1	-to SPI_Out[0]







