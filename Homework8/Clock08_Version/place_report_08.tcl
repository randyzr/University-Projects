###########################################################
#
#  Create Synopsys Reports
#  Author: Randy Zamor R
#
###########################################################

report_power 					> ../reports/power_08.txt
report_cell 					> ../reports/cell_08.txt
report_qor 					> ../reports/qor_08.txt
report_clocks 					> ../reports/clocks_08.txt
report_utilization 				> ../reports/utilization_08.txt
report_port 					> ../reports/ports_08.txt
report_supply_nets				> ../reports/power_nets_08.txt
report_timing -max_paths 20 -delay_type max 	> ../reports/timing_setup_08.txt
report_timing -max_paths 20 -delay_type min 	> ../reports/timing_hold_08.txt

##########################################################
