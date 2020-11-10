set path [ file dirname [file normalize [info script] ] ]
puts $path
set name sci2_cyclogram
create_project -force -part xc7a200tfbg676-2 $name -dir $name 
set fs [get_filesets sim_1]
add_files  -fileset $fs -scan_for_includes "$path/src"
set_property top sci2_cyclogram [get_filesets sim_1]
update_compile_order -fileset sim_1

launch_simulation
run 10 us
exit
