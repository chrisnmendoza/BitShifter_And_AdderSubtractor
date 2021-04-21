mux: 4to1_mux_tb.vhdl 4to1_mux.vhdl
	ghdl -a 4to1_mux.vhdl
	ghdl -a 4to1_mux_tb.vhdl
	ghdl -e mux_tb
	ghdl -r mux_tb --vcd=mux.vcd