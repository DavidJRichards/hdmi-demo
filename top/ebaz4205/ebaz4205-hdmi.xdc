# 50 MHz Clock definition
#set_property -dict { PACKAGE_PIN M21   IOSTANDARD LVCMOS33 } [get_ports { CLOCK_50 }]; 
#create_clock -name CLOCK_50 -period 20.000 [get_ports {CLOCK_50}]

# 33.333 MHz Clock definition
set_property -dict {PACKAGE_PIN N18 IOSTANDARD LVCMOS33} [get_ports CLK_33MHZ]
create_clock -period 30.0 -name CLK_33MHZ [get_ports CLK_33MHZ]

#100 MHz clock
#set_property IOSTANDARD LVCMOS33 [get_ports CLK_100MHZ]
#set_property PACKAGE_PIN N18 [get_ports CLK_100MHZ]
#create_clock -add -name CLK_100MHZ -period 10.00 -waveform {0 5} [get_ports CLK_100MHZ]

#########################################################
# TMDS (DVI, HDMI)                                      #
#########################################################
# Connector DATA 1
set_property -dict {PACKAGE_PIN H17 IOSTANDARD TMDS_33} [get_ports {HDMI_CLK_N}]
set_property -dict {PACKAGE_PIN H16 IOSTANDARD TMDS_33} [get_ports {HDMI_CLK}]
set_property -dict {PACKAGE_PIN D20 IOSTANDARD TMDS_33} [get_ports {HDMI_TX_N[0]}]
set_property -dict {PACKAGE_PIN D19 IOSTANDARD TMDS_33} [get_ports {HDMI_TX[0]}]
set_property -dict {PACKAGE_PIN B20 IOSTANDARD TMDS_33} [get_ports {HDMI_TX_N[1]}]
set_property -dict {PACKAGE_PIN C20 IOSTANDARD TMDS_33} [get_ports {HDMI_TX[1]}]
set_property -dict {PACKAGE_PIN F20 IOSTANDARD TMDS_33} [get_ports {HDMI_TX_N[2]}]
set_property -dict {PACKAGE_PIN F19 IOSTANDARD TMDS_33} [get_ports {HDMI_TX[2]}]

# CEC, SDA, SCL, DPD_DET
#set_property -dict {PACKAGE_PIN B19 IOSTANDARD LVCMOS33 PULLUP true} [get_ports HDMI_CEC] 
#set_property -dict {PACKAGE_PIN D18 IOSTANDARD LVCMOS33 PULLUP true} [get_ports HDMI_SDA] 
#set_property -dict {PACKAGE_PIN K17 IOSTANDARD LVCMOS33 PULLUP true} [get_ports HDMI_SCL] 
#set_property -dict {PACKAGE_PIN E19 IOSTANDARD LVCMOS33 PULLUP true} [get_ports HDMI_HPD] 
# button / HDMI_OEN
set_property -dict {PACKAGE_PIN H18 IOSTANDARD LVCMOS33 PULLUP true} [get_ports led_button]

##################################
# J3, PS2 interface - keyboard
##################################
#set_property -dict {PACKAGE_PIN V13 IOSTANDARD LVCMOS33 PULLUP true} [get_ports PS2_DATA] 
#set_property -dict {PACKAGE_PIN U12 IOSTANDARD LVCMOS33 PULLUP true} [get_ports PS2_CLOCK]

# LEDs
set_property -dict {PACKAGE_PIN A20 IOSTANDARD LVCMOS33} [get_ports {led_blue}]
#set_property -dict {PACKAGE_PIN W13 IOSTANDARD LVCMOS33} [get_ports {led_green}]
#set_property -dict {PACKAGE_PIN W14 IOSTANDARD LVCMOS33} [get_ports {led_red}]
#set_property -dict {PACKAGE_PIN W13 IOSTANDARD LVCMOS33} [get_ports LED[0]]
#set_property -dict {PACKAGE_PIN W14 IOSTANDARD LVCMOS33} [get_ports LED[1]]

##################################
# J5 UART interface
##################################
set_property -dict {PACKAGE_PIN V15 IOSTANDARD LVCMOS33 } [get_ports {pwm_left}]
set_property -dict {PACKAGE_PIN V12 IOSTANDARD LVCMOS33 } [get_ports {pwm_right}]
