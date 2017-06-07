# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"

}

proc update_PARAM_VALUE.data_rate_oq { PARAM_VALUE.data_rate_oq } {
	# Procedure called to update data_rate_oq when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.data_rate_oq { PARAM_VALUE.data_rate_oq } {
	# Procedure called to validate data_rate_oq
	return true
}

proc update_PARAM_VALUE.data_rate_tq { PARAM_VALUE.data_rate_tq } {
	# Procedure called to update data_rate_tq when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.data_rate_tq { PARAM_VALUE.data_rate_tq } {
	# Procedure called to validate data_rate_tq
	return true
}

proc update_PARAM_VALUE.data_width { PARAM_VALUE.data_width } {
	# Procedure called to update data_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.data_width { PARAM_VALUE.data_width } {
	# Procedure called to validate data_width
	return true
}

proc update_PARAM_VALUE.serdes_mode { PARAM_VALUE.serdes_mode } {
	# Procedure called to update serdes_mode when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.serdes_mode { PARAM_VALUE.serdes_mode } {
	# Procedure called to validate serdes_mode
	return true
}

proc update_PARAM_VALUE.tristate_width { PARAM_VALUE.tristate_width } {
	# Procedure called to update tristate_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.tristate_width { PARAM_VALUE.tristate_width } {
	# Procedure called to validate tristate_width
	return true
}


proc update_MODELPARAM_VALUE.data_width { MODELPARAM_VALUE.data_width PARAM_VALUE.data_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.data_width}] ${MODELPARAM_VALUE.data_width}
}

proc update_MODELPARAM_VALUE.data_rate_oq { MODELPARAM_VALUE.data_rate_oq PARAM_VALUE.data_rate_oq } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.data_rate_oq}] ${MODELPARAM_VALUE.data_rate_oq}
}

proc update_MODELPARAM_VALUE.data_rate_tq { MODELPARAM_VALUE.data_rate_tq PARAM_VALUE.data_rate_tq } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.data_rate_tq}] ${MODELPARAM_VALUE.data_rate_tq}
}

proc update_MODELPARAM_VALUE.serdes_mode { MODELPARAM_VALUE.serdes_mode PARAM_VALUE.serdes_mode } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.serdes_mode}] ${MODELPARAM_VALUE.serdes_mode}
}

proc update_MODELPARAM_VALUE.tristate_width { MODELPARAM_VALUE.tristate_width PARAM_VALUE.tristate_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.tristate_width}] ${MODELPARAM_VALUE.tristate_width}
}

