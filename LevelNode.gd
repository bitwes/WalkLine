extends Control
tool

# indexes in here are to match global.DIRECTION enum.  These are populated in 
# Main.gd from the lines that exist in that scene.  That way you don't have to
# do twice the config.
var _lines = [null, null, null, null]


func _draw():
	draw_rect(Rect2(Vector2(0, 0), rect_size), Color(.5, .5, 1))

func get_line(direction):
	return _lines[direction]

func set_line(line, direction):
	_lines[direction] = line


func _un_color_lines():
	for l in _lines:
		if(l != null):
			l.default_color = Color(0, 0, 0)

func _color_lines():
	for l in _lines:
		if(l != null):
			if(l.get_start_node() == self):
				l.default_color = Color(0, 1, 0)
			else:
				l.default_color = Color(0, 0, 1)


func _on_LevelNode_mouse_entered():
	_color_lines()


func _on_LevelNode_mouse_exited():
	_un_color_lines()
