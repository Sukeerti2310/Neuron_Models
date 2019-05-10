# Elaborating the model #
elaborate neuron -architecture verilog -library WORK

# Create user defined variables # 
set CLK_PERIOD 100000.00 
set CLK_SKEW   [expr {$CLK_PERIOD} * 0.04]

# Create user-defined clock just for getting timing information #
# It doesn't mean there is a clock in the logic circuit #
create_clock -period $CLK_PERIOD -name clk
set_clock_uncertainty $CLK_SKEW clk

# Compile the model #
compile -map_effort medium

# Create output files for collecting metrics #
report_area                                                                                                                  > neuron.area
report_power                                                                                                                 > neuron.pow

report_timing  -from { i_excitatory[0] } -path full -delay max -nworst 1 -max_paths 1 -significant_digits 2 -sort_by group  > neuron.tim

report_timing  -to { o_spike } -path full -delay max -nworst 1 -max_paths 1 -significant_digits 2 -sort_by group  > neuron1.tim

check_timing
check_design
