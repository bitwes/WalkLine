extends Node2D

func _ready():
	_populate_level_directions()
	
	$Character.set_speed(400)
	$Character.set_level_node($"Start")

# sets the _line for each level node from the settings on each line.
func _populate_level_directions():
	var kids = get_children()
	for kid in kids:
		if(kid is Line2D):
			if(kid.start_conn != null):
				print('start: ', kid.start_conn)
				kid.get_start_node().set_line(kid, kid.start_dir)
			
			if(kid.end_conn !=  null):
				print('end:  ', kid.end_conn)
				kid.get_end_node().set_line(kid, kid.end_dir)
