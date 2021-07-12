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


# HDMI
#set_property -dict { PACKAGE_PIN G2   IOSTANDARD TMDS_33 } [get_ports { HDMI_TX[2]   }];
#set_property -dict { PACKAGE_PIN G1   IOSTANDARD TMDS_33 } [get_ports { HDMI_TX_N[2] }];

#set_property -dict { PACKAGE_PIN F2   IOSTANDARD TMDS_33 } [get_ports { HDMI_TX[1]   }];
#set_property -dict { PACKAGE_PIN E2   IOSTANDARD TMDS_33 } [get_ports { HDMI_TX_N[1] }];

#set_property -dict { PACKAGE_PIN E1   IOSTANDARD TMDS_33 } [get_ports { HDMI_TX[0]   }];
#set_property -dict { PACKAGE_PIN D1   IOSTANDARD TMDS_33 } [get_ports { HDMI_TX_N[0] }];

#set_property -dict { PACKAGE_PIN D4   IOSTANDARD TMDS_33 } [get_ports { HDMI_CLK     }];
#set_property -dict { PACKAGE_PIN C4   IOSTANDARD TMDS_33 } [get_ports { HDMI_CLK_N   }];

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
set_property IOSTANDARD LVCMOS33 [get_ports HDMI_CEC] 
set_property IOSTANDARD LVCMOS33 [get_ports HDMI_SDA] 
set_property IOSTANDARD LVCMOS33 [get_ports HDMI_SCL] 
set_property IOSTANDARD LVCMOS33 [get_ports HDMI_HPD] 

set_property PULLTYPE PULLUP [get_ports HDMI_CEC]
set_property PULLTYPE PULLUP [get_ports HDMI_SDA]
set_property PULLTYPE PULLUP [get_ports HDMI_SCL]
set_property PULLTYPE PULLUP [get_ports HDMI_HPD]

set_property PACKAGE_PIN B19 [get_ports HDMI_CEC]
set_property PACKAGE_PIN D18 [get_ports HDMI_SDA]
set_property PACKAGE_PIN K17 [get_ports HDMI_SCL]
set_property PACKAGE_PIN E19 [get_ports HDMI_HPD]

# Keyboard
#set_property -dict { PACKAGE_PIN AC26   IOSTANDARD LVCMOS33 } [get_ports { PS2_CLOCK   }];
#set_property -dict { PACKAGE_PIN AB26   IOSTANDARD LVCMOS33 } [get_ports { PS2_DATA    }];
##################################
# J3, PS2 interface
##################################
set_property PACKAGE_PIN V13 [get_ports {PS2_DATA}]
set_property PULLUP true [get_ports {PS2_DATA}]
set_property IOSTANDARD LVCMOS33 [get_ports {PS2_DATA}]

set_property PACKAGE_PIN U12 [get_ports {PS2_CLOCK}]
set_property PULLUP true [get_ports {PS2_CLOCK}]
set_property IOSTANDARD LVCMOS33 [get_ports {PS2_CLOCK}]

# LEDs
#set_property IOSTANDARD LVCMOS33 [get_ports LED[0]]
#set_property IOSTANDARD LVCMOS33 [get_ports LED[1]]
#set_property PACKAGE_PIN J1 [get_ports LED[0]]
#set_property PACKAGE_PIN A13 [get_ports LED[1]]

## LEDS
set_property -dict {PACKAGE_PIN W13 IOSTANDARD LVCMOS33} [get_ports LED[0]]
set_property -dict {PACKAGE_PIN W14 IOSTANDARD LVCMOS33} [get_ports LED[1]]

set_property -dict {PACKAGE_PIN H18 IOSTANDARD LVCMOS33} [get_ports clk_audio]
set_property -dict {PACKAGE_PIN H18 IOSTANDARD LVCMOS33} [get_ports clk_pixel]
# button
#set_property PACKAGE_PIN H18 [get_ports clk_pixel]
#set_property PULLUP true [get_ports ext_irq]
#set_property IOSTANDARD LVCMOS33 [get_ports clk_pixel]
