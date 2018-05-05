# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  ipgui::add_page $IPINST -name "Page 0"


}

proc update_PARAM_VALUE.H_ACT { PARAM_VALUE.H_ACT } {
	# Procedure called to update H_ACT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.H_ACT { PARAM_VALUE.H_ACT } {
	# Procedure called to validate H_ACT
	return true
}

proc update_PARAM_VALUE.H_ALL { PARAM_VALUE.H_ALL } {
	# Procedure called to update H_ALL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.H_ALL { PARAM_VALUE.H_ALL } {
	# Procedure called to validate H_ALL
	return true
}

proc update_PARAM_VALUE.H_BP { PARAM_VALUE.H_BP } {
	# Procedure called to update H_BP when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.H_BP { PARAM_VALUE.H_BP } {
	# Procedure called to validate H_BP
	return true
}

proc update_PARAM_VALUE.H_FP { PARAM_VALUE.H_FP } {
	# Procedure called to update H_FP when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.H_FP { PARAM_VALUE.H_FP } {
	# Procedure called to validate H_FP
	return true
}

proc update_PARAM_VALUE.H_LB { PARAM_VALUE.H_LB } {
	# Procedure called to update H_LB when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.H_LB { PARAM_VALUE.H_LB } {
	# Procedure called to validate H_LB
	return true
}

proc update_PARAM_VALUE.H_RB { PARAM_VALUE.H_RB } {
	# Procedure called to update H_RB when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.H_RB { PARAM_VALUE.H_RB } {
	# Procedure called to validate H_RB
	return true
}

proc update_PARAM_VALUE.H_SYNC { PARAM_VALUE.H_SYNC } {
	# Procedure called to update H_SYNC when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.H_SYNC { PARAM_VALUE.H_SYNC } {
	# Procedure called to validate H_SYNC
	return true
}

proc update_PARAM_VALUE.V_ACT { PARAM_VALUE.V_ACT } {
	# Procedure called to update V_ACT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.V_ACT { PARAM_VALUE.V_ACT } {
	# Procedure called to validate V_ACT
	return true
}

proc update_PARAM_VALUE.V_ALL { PARAM_VALUE.V_ALL } {
	# Procedure called to update V_ALL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.V_ALL { PARAM_VALUE.V_ALL } {
	# Procedure called to validate V_ALL
	return true
}

proc update_PARAM_VALUE.V_BB { PARAM_VALUE.V_BB } {
	# Procedure called to update V_BB when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.V_BB { PARAM_VALUE.V_BB } {
	# Procedure called to validate V_BB
	return true
}

proc update_PARAM_VALUE.V_BP { PARAM_VALUE.V_BP } {
	# Procedure called to update V_BP when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.V_BP { PARAM_VALUE.V_BP } {
	# Procedure called to validate V_BP
	return true
}

proc update_PARAM_VALUE.V_FP { PARAM_VALUE.V_FP } {
	# Procedure called to update V_FP when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.V_FP { PARAM_VALUE.V_FP } {
	# Procedure called to validate V_FP
	return true
}

proc update_PARAM_VALUE.V_SYNC { PARAM_VALUE.V_SYNC } {
	# Procedure called to update V_SYNC when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.V_SYNC { PARAM_VALUE.V_SYNC } {
	# Procedure called to validate V_SYNC
	return true
}

proc update_PARAM_VALUE.V_TB { PARAM_VALUE.V_TB } {
	# Procedure called to update V_TB when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.V_TB { PARAM_VALUE.V_TB } {
	# Procedure called to validate V_TB
	return true
}


proc update_MODELPARAM_VALUE.H_ALL { MODELPARAM_VALUE.H_ALL PARAM_VALUE.H_ALL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.H_ALL}] ${MODELPARAM_VALUE.H_ALL}
}

proc update_MODELPARAM_VALUE.H_SYNC { MODELPARAM_VALUE.H_SYNC PARAM_VALUE.H_SYNC } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.H_SYNC}] ${MODELPARAM_VALUE.H_SYNC}
}

proc update_MODELPARAM_VALUE.H_BP { MODELPARAM_VALUE.H_BP PARAM_VALUE.H_BP } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.H_BP}] ${MODELPARAM_VALUE.H_BP}
}

proc update_MODELPARAM_VALUE.H_LB { MODELPARAM_VALUE.H_LB PARAM_VALUE.H_LB } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.H_LB}] ${MODELPARAM_VALUE.H_LB}
}

proc update_MODELPARAM_VALUE.H_ACT { MODELPARAM_VALUE.H_ACT PARAM_VALUE.H_ACT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.H_ACT}] ${MODELPARAM_VALUE.H_ACT}
}

proc update_MODELPARAM_VALUE.H_RB { MODELPARAM_VALUE.H_RB PARAM_VALUE.H_RB } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.H_RB}] ${MODELPARAM_VALUE.H_RB}
}

proc update_MODELPARAM_VALUE.H_FP { MODELPARAM_VALUE.H_FP PARAM_VALUE.H_FP } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.H_FP}] ${MODELPARAM_VALUE.H_FP}
}

proc update_MODELPARAM_VALUE.V_ALL { MODELPARAM_VALUE.V_ALL PARAM_VALUE.V_ALL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.V_ALL}] ${MODELPARAM_VALUE.V_ALL}
}

proc update_MODELPARAM_VALUE.V_SYNC { MODELPARAM_VALUE.V_SYNC PARAM_VALUE.V_SYNC } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.V_SYNC}] ${MODELPARAM_VALUE.V_SYNC}
}

proc update_MODELPARAM_VALUE.V_BP { MODELPARAM_VALUE.V_BP PARAM_VALUE.V_BP } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.V_BP}] ${MODELPARAM_VALUE.V_BP}
}

proc update_MODELPARAM_VALUE.V_TB { MODELPARAM_VALUE.V_TB PARAM_VALUE.V_TB } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.V_TB}] ${MODELPARAM_VALUE.V_TB}
}

proc update_MODELPARAM_VALUE.V_ACT { MODELPARAM_VALUE.V_ACT PARAM_VALUE.V_ACT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.V_ACT}] ${MODELPARAM_VALUE.V_ACT}
}

proc update_MODELPARAM_VALUE.V_BB { MODELPARAM_VALUE.V_BB PARAM_VALUE.V_BB } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.V_BB}] ${MODELPARAM_VALUE.V_BB}
}

proc update_MODELPARAM_VALUE.V_FP { MODELPARAM_VALUE.V_FP PARAM_VALUE.V_FP } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.V_FP}] ${MODELPARAM_VALUE.V_FP}
}

