# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"

}

proc update_PARAM_VALUE.data_rate { PARAM_VALUE.data_rate } {
	# Procedure called to update data_rate when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.data_rate { PARAM_VALUE.data_rate } {
	# Procedure called to validate data_rate
	return true
}

proc update_PARAM_VALUE.data_width { PARAM_VALUE.data_width } {
	# Procedure called to update data_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.data_width { PARAM_VALUE.data_width } {
	# Procedure called to validate data_width
	return true
}

proc update_PARAM_VALUE.init_sr_value { PARAM_VALUE.init_sr_value } {
	# Procedure called to update init_sr_value when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.init_sr_value { PARAM_VALUE.init_sr_value } {
	# Procedure called to validate init_sr_value
	return true
}

proc update_PARAM_VALUE.init_value { PARAM_VALUE.init_value } {
	# Procedure called to update init_value when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.init_value { PARAM_VALUE.init_value } {
	# Procedure called to validate init_value
	return true
}

proc update_PARAM_VALUE.interface_type { PARAM_VALUE.interface_type } {
	# Procedure called to update interface_type when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.interface_type { PARAM_VALUE.interface_type } {
	# Procedure called to validate interface_type
	return true
}

proc update_PARAM_VALUE.num_ce { PARAM_VALUE.num_ce } {
	# Procedure called to update num_ce when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.num_ce { PARAM_VALUE.num_ce } {
	# Procedure called to validate num_ce
	return true
}


proc update_MODELPARAM_VALUE.data_width { MODELPARAM_VALUE.data_width PARAM_VALUE.data_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.data_width}] ${MODELPARAM_VALUE.data_width}
}

proc update_MODELPARAM_VALUE.num_ce { MODELPARAM_VALUE.num_ce PARAM_VALUE.num_ce } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.num_ce}] ${MODELPARAM_VALUE.num_ce}
}

proc update_MODELPARAM_VALUE.data_rate { MODELPARAM_VALUE.data_rate PARAM_VALUE.data_rate } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.data_rate}] ${MODELPARAM_VALUE.data_rate}
}

proc update_MODELPARAM_VALUE.interface_type { MODELPARAM_VALUE.interface_type PARAM_VALUE.interface_type } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.interface_type}] ${MODELPARAM_VALUE.interface_type}
}

proc update_MODELPARAM_VALUE.init_value { MODELPARAM_VALUE.init_value PARAM_VALUE.init_value } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.init_value}] ${MODELPARAM_VALUE.init_value}
}

proc update_MODELPARAM_VALUE.init_sr_value { MODELPARAM_VALUE.init_sr_value PARAM_VALUE.init_sr_value } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.init_sr_value}] ${MODELPARAM_VALUE.init_sr_value}
}

