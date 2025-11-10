###########################################################
#
# Script for placement and route
# Author: Student Randy Zamora R
#
###########################################################

# Create a data base
create_lib ../dbs/design_08.ndm -ref_libs ../libs/my_ref_lib.ndb
create_block design

# Add the design
read_verilog ../source/design_08.v -top ALU
uniquify
link

# Create the floorplan
initialize_floorplan -control_type core -core_utilization 0.85 -shape R \
-side_length {236.17 177.12}
read_parasitic_tech -tlup ../libs/saed90nm_1p9m_1t_nominal.tluplus

report_tracks > ../reports/tracks_08.txt

# Power
create_net -power VDD
create_net -ground VSS
create_power_domain VCC
create_supply_net VDD -domain VCC
create_supply_net VSS -domain VCC
set_domain_supply_net VCC -primary_power_net VDD -primary_ground_net VSS
commit_upf

# Check and connect power
resolve_pg_nets
connect_pg_net -auto

# Create power mesh
create_pg_mesh_pattern power_mesh -layer { \
	{{vertical_layer M8} {width: 2} {spacing: interleaving} {pitch: 32}} \
	{{vertical_layer M6} {width: 2} {spacing: interleaving} {pitch: 32}} \
	{{horizontal_layer M7} {width: 2} {spacing: interleaving} {pitch: 28}} \
}

set_pg_strategy my_strat -core -pattern \
	{ {name: power_mesh}  {nets: {VDD VSS}} } \
	-extension {stop: design_boundary}

compile_pg -strategies my_strat

# Save_lib
save_lib

# Add constraints
read_sdc ../source/design_08.sdc

# Place ports
place_pins -ports [get_ports]

# The stages above are for floorplan

# Placement
reset_placement -spread_cells
set_app_options -name place.coarse.fix_hard_macros -value false
set_app_options -name plan.place.auto_create_blockages -value auto
create_placement -floorplan
legalize_placement

# Routing
route_global
route_auto

# Save dbs with placement and route
save_lib

###########################################################

