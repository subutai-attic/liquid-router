# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "DIV_CLOCK" -parent ${Page_0}
  ipgui::add_param $IPINST -name "FBOUT_CLOCK" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TX_CLOCK" -parent ${Page_0}


}

proc update_PARAM_VALUE.DIV_CLOCK { PARAM_VALUE.DIV_CLOCK } {
	# Procedure called to update DIV_CLOCK when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DIV_CLOCK { PARAM_VALUE.DIV_CLOCK } {
	# Procedure called to validate DIV_CLOCK
	return true
}

proc update_PARAM_VALUE.FBOUT_CLOCK { PARAM_VALUE.FBOUT_CLOCK } {
	# Procedure called to update FBOUT_CLOCK when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FBOUT_CLOCK { PARAM_VALUE.FBOUT_CLOCK } {
	# Procedure called to validate FBOUT_CLOCK
	return true
}

proc update_PARAM_VALUE.TX_CLOCK { PARAM_VALUE.TX_CLOCK } {
	# Procedure called to update TX_CLOCK when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TX_CLOCK { PARAM_VALUE.TX_CLOCK } {
	# Procedure called to validate TX_CLOCK
	return true
}


proc update_MODELPARAM_VALUE.TX_CLOCK { MODELPARAM_VALUE.TX_CLOCK PARAM_VALUE.TX_CLOCK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TX_CLOCK}] ${MODELPARAM_VALUE.TX_CLOCK}
}

proc update_MODELPARAM_VALUE.DIV_CLOCK { MODELPARAM_VALUE.DIV_CLOCK PARAM_VALUE.DIV_CLOCK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DIV_CLOCK}] ${MODELPARAM_VALUE.DIV_CLOCK}
}

proc update_MODELPARAM_VALUE.FBOUT_CLOCK { MODELPARAM_VALUE.FBOUT_CLOCK PARAM_VALUE.FBOUT_CLOCK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FBOUT_CLOCK}] ${MODELPARAM_VALUE.FBOUT_CLOCK}
}

