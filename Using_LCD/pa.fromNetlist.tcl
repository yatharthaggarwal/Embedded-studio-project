
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name Using_LCD -dir "C:/Users/Yatharth/Documents/CIC semesters/Sem 5/Embedded Systems Studio/Project/Using_LCD/planAhead_run_3" -part xc6slx9tqg144-2
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Users/Yatharth/Documents/CIC semesters/Sem 5/Embedded Systems Studio/Project/Using_LCD/lcd_disp.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Users/Yatharth/Documents/CIC semesters/Sem 5/Embedded Systems Studio/Project/Using_LCD} }
set_property target_constrs_file "Sample.ucf" [current_fileset -constrset]
add_files [list {Sample.ucf}] -fileset [get_property constrset [current_run]]
link_design
