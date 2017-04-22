# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "DATA_RATE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "INTERFACE_TYPE" -parent ${Page_0}


}

proc update_PARAM_VALUE.DATA_RATE { PARAM_VALUE.DATA_RATE } {
	# Procedure called to update DATA_RATE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DATA_RATE { PARAM_VALUE.DATA_RATE } {
	# Procedure called to validate DATA_RATE
	return true
}

proc update_PARAM_VALUE.INTERFACE_TYPE { PARAM_VALUE.INTERFACE_TYPE } {
	# Procedure called to update INTERFACE_TYPE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INTERFACE_TYPE { PARAM_VALUE.INTERFACE_TYPE } {
	# Procedure called to validate INTERFACE_TYPE
	return true
}


proc update_MODELPARAM_VALUE.DATA_RATE { MODELPARAM_VALUE.DATA_RATE PARAM_VALUE.DATA_RATE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DATA_RATE}] ${MODELPARAM_VALUE.DATA_RATE}
}

proc update_MODELPARAM_VALUE.INTERFACE_TYPE { MODELPARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.INTERFACE_TYPE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INTERFACE_TYPE}] ${MODELPARAM_VALUE.INTERFACE_TYPE}
}

