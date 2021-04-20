# TCL File Generated by Component Editor 18.1
# Tue Apr 20 11:44:47 CDT 2021
# DO NOT MODIFY


# 
# servo_control "servo_control" v1.1
# Ben Klemp 2021.04.20.11:44:47
# Servo control interface
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module servo_control
# 
set_module_property DESCRIPTION "Servo control interface"
set_module_property NAME servo_control
set_module_property VERSION 1.1
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP Custom
set_module_property AUTHOR "Ben Klemp"
set_module_property DISPLAY_NAME servo_control
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL servo_control_port
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file servo_control_port.vhd VHDL PATH ../components/lib/servo_control_port.vhd TOP_LEVEL_FILE
add_fileset_file servo_control.vhd VHDL PATH ../components/lib/servo_control.vhd
add_fileset_file counter.vhd VHDL PATH ../components/lib/counter.vhd
add_fileset_file edge_detector.vhd VHDL PATH ../components/lib/edge_detector.vhd
add_fileset_file prescaler.vhd VHDL PATH ../components/lib/prescaler.vhd
add_fileset_file reg.vhd VHDL PATH ../components/lib/reg.vhd
add_fileset_file port.vhd VHDL PATH ../components/lib/port.vhd
add_fileset_file port_reg.vhd VHDL PATH ../components/lib/port_reg.vhd

add_fileset SIM_VHDL SIM_VHDL "" ""
set_fileset_property SIM_VHDL TOP_LEVEL servo_control_port
set_fileset_property SIM_VHDL ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VHDL ENABLE_FILE_OVERWRITE_MODE true
add_fileset_file servo_control_port.vhd VHDL PATH ../components/lib/servo_control_port.vhd
add_fileset_file servo_control.vhd VHDL PATH ../components/lib/servo_control.vhd
add_fileset_file counter.vhd VHDL PATH ../components/lib/counter.vhd
add_fileset_file edge_detector.vhd VHDL PATH ../components/lib/edge_detector.vhd
add_fileset_file prescaler.vhd VHDL PATH ../components/lib/prescaler.vhd
add_fileset_file reg.vhd VHDL PATH ../components/lib/reg.vhd
add_fileset_file port.vhd VHDL PATH ../components/lib/port.vhd
add_fileset_file port_reg.vhd VHDL PATH ../components/lib/port_reg.vhd


# 
# parameters
# 


# 
# display items
# 


# 
# connection point clk
# 
add_interface clk clock end
set_interface_property clk clockRate 0
set_interface_property clk ENABLED true
set_interface_property clk EXPORT_OF ""
set_interface_property clk PORT_NAME_MAP ""
set_interface_property clk CMSIS_SVD_VARIABLES ""
set_interface_property clk SVD_ADDRESS_GROUP ""

add_interface_port clk clk clk Input 1


# 
# connection point rst
# 
add_interface rst reset end
set_interface_property rst associatedClock clk
set_interface_property rst synchronousEdges DEASSERT
set_interface_property rst ENABLED true
set_interface_property rst EXPORT_OF ""
set_interface_property rst PORT_NAME_MAP ""
set_interface_property rst CMSIS_SVD_VARIABLES ""
set_interface_property rst SVD_ADDRESS_GROUP ""

add_interface_port rst rst reset Input 1


# 
# connection point servo_control_slave
# 
add_interface servo_control_slave avalon end
set_interface_property servo_control_slave addressUnits WORDS
set_interface_property servo_control_slave associatedClock clk
set_interface_property servo_control_slave associatedReset rst
set_interface_property servo_control_slave bitsPerSymbol 8
set_interface_property servo_control_slave burstOnBurstBoundariesOnly false
set_interface_property servo_control_slave burstcountUnits WORDS
set_interface_property servo_control_slave explicitAddressSpan 0
set_interface_property servo_control_slave holdTime 0
set_interface_property servo_control_slave linewrapBursts false
set_interface_property servo_control_slave maximumPendingReadTransactions 0
set_interface_property servo_control_slave maximumPendingWriteTransactions 0
set_interface_property servo_control_slave readLatency 0
set_interface_property servo_control_slave readWaitTime 1
set_interface_property servo_control_slave setupTime 0
set_interface_property servo_control_slave timingUnits Cycles
set_interface_property servo_control_slave writeWaitTime 0
set_interface_property servo_control_slave ENABLED true
set_interface_property servo_control_slave EXPORT_OF ""
set_interface_property servo_control_slave PORT_NAME_MAP ""
set_interface_property servo_control_slave CMSIS_SVD_VARIABLES ""
set_interface_property servo_control_slave SVD_ADDRESS_GROUP ""

add_interface_port servo_control_slave readdata readdata Output 16
add_interface_port servo_control_slave writedata writedata Input 16
add_interface_port servo_control_slave read read Input 1
add_interface_port servo_control_slave write write Input 1
add_interface_port servo_control_slave address address Input 1
add_interface_port servo_control_slave byteenable byteenable Input 2
set_interface_assignment servo_control_slave embeddedsw.configuration.isFlash 0
set_interface_assignment servo_control_slave embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment servo_control_slave embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment servo_control_slave embeddedsw.configuration.isPrintableDevice 0


# 
# connection point external_connection
# 
add_interface external_connection conduit end
set_interface_property external_connection associatedClock clk
set_interface_property external_connection associatedReset rst
set_interface_property external_connection ENABLED true
set_interface_property external_connection EXPORT_OF ""
set_interface_property external_connection PORT_NAME_MAP ""
set_interface_property external_connection CMSIS_SVD_VARIABLES ""
set_interface_property external_connection SVD_ADDRESS_GROUP ""

add_interface_port external_connection control out_signal Output 1

