#------------------GLOBAL--------------------#
set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"
set_global_assignment -name ENABLE_INIT_DONE_OUTPUT OFF

#��λ����
set_location_assignment	PIN_M1	-to RSTn

#ʱ������
set_location_assignment	PIN_R9	-to CLK

#VGA��Ӧ������
set_location_assignment	PIN_E6	-to Green_Sig
set_location_assignment	PIN_D5	-to Blue_Sig
set_location_assignment	PIN_C6	-to Red_Sig
set_location_assignment	PIN_D3	-to HSYNC_Sig
set_location_assignment	PIN_C3	-to VSYNC_Sig



