#------------------GLOBAL--------------------#
set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"
set_global_assignment -name ENABLE_INIT_DONE_OUTPUT OFF

#��λ����
set_location_assignment	PIN_M1	-to RST_n

#ʱ������
set_location_assignment	PIN_R9	-to CLOCK
set_location_assignment	PIN_A9	-to CLOCK_40M



#���ڶ�Ӧ������
set_location_assignment	PIN_A8	-to RXD
set_location_assignment	PIN_G5	-to TXD
