extends Line2D


export (NodePath) var start_conn = null
# side of the node the start comes in on.  Translates to the direction you 
# would press to take this line from the start node.
export (global.DIRECTION) var start_dir = global.DIRECTION.LEFT

export (NodePath) var end_conn = null
# side of the node the end comes in on.  Translates to the direction you 
# would press to take this line from the end node.
export (global.DIRECTION) var end_dir = global.DIRECTION.RIGHT


func get_start_node():
	return get_node(start_conn)


func get_end_node():
	return get_node(end_conn)
