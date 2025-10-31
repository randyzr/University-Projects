###########################################################
#
# Script for synthesis with contraints
# Author: Est. Randy Zamora R
#
###########################################################

# remove any last design
remove_design -designs

# Define the libs to you
set target_library [ls ../libs/saed90nm_max.db]
set link_library [ls ../libs/saed90nm_max.db]

# Read the RTL file by file
set verilog_files [ls ../source/*.v]

foreach file $verilog_files {
	puts "INFO: Reading verilog $file"
	read_file -format verilog $file
}

# Run Analyze

foreach file $verilog_files {
	puts "INFO: Analyzing verilog $files"
	analyze -format verilog $file
}

# Define the top module and run elaborate

current_design ALU
elaborate ALU

# Run linking

link

# Save a initial database
write -hierarchy -format ddc -output ../dbs/precompile_design.ddc

# Source constraints
source ../scripts/constraints.tcl
propagate_constraints

# Check and compile
check_design
compile_ultra

# Final save
write -hierarchy -format ddc -output ../dbs/postcompile_design.ddc
set verilogout_no_tri true
change_names -hierarchy -rules verilog
write -hierarchy -format verilog -output ../dbs/design.v
write_sdc ../dbs/design.sdc

###########################################################



