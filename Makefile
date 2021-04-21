mux: 4to1_mux_tb.vhdl 4to1_mux.vhdl
	ghdl -a 4to1_mux.vhdl
	ghdl -a 4to1_mux_tb.vhdl
	ghdl -e mux_tb
	ghdl -r mux_tb --vcd=mux.vcd

shift_reg: shift_reg_tb.vhdl shift_reg.vhdl
	ghdl -a shift_reg.vhdl
	ghdl -a shift_reg_tb.vhdl
	ghdl -e shift_reg_tb
	ghdl -r shift_reg_tb