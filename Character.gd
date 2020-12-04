extends Sprite


enum {
	FORWARD,
	BACKWARD
}


var _speed = 0
# line to walk, resets to null at end of line
var _line = null

# starting index for the line to walk
var _start_index = 0
# The next point in the line currently being walked
var _next_point = null
# 1/-1 to indicate how to get _next_point
var _point_dir

# current level node.  This is null while traveling
var _level_node = null


func _process(delta):
	if(_line == null or _speed == 0):
		return

	_move(delta * _speed)


# picks the line to travel from the current level node.  If level node does
# not have a line for that direction then nothing happens.  Does nothing 
# if we are currently traveling.
func _handle_key(dir):
	if(_level_node == null):
		return
	else:
		var conn = _level_node.get_line(dir)
		if(conn != null):
			if(conn.get_start_node() == _level_node):
				set_line(conn, FORWARD)
			else:
				set_line(conn, BACKWARD)
				
			set_level_node(null)


func _input(event):
	if(event is InputEventKey and event.pressed):
		if(event.scancode == KEY_UP):
			_handle_key(global.DIRECTION.UP)
		elif(event.scancode ==  KEY_DOWN):
			_handle_key(global.DIRECTION.DOWN)
		elif(event.scancode == KEY_RIGHT):
			_handle_key(global.DIRECTION.RIGHT)
		elif(event.scancode == KEY_LEFT):
			_handle_key(global.DIRECTION.LEFT)


# formula ripped from https://math.stackexchange.com/questions/96328/finding-point-on-line-1-unit-next-from-start-point
func _move(amt):
	var x1 = position.x
	var y1 = position.y

	var x2 = _next_point.x
	var y2 = _next_point.y

	var n = sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2))

	var x = x1 + (amt/n) * (x2 - x1)
	var y = y1 + (amt/n) * (y2 - y1)

	position = Vector2(x, y)

	if(position.distance_to(_next_point) <= amt):
		_start_index += _point_dir
		if(_line.points.size() > _start_index + 1 and _start_index > 0):
			_set_points(_start_index, _start_index + _point_dir)
		else:
			if(_point_dir == 1):
				set_level_node(_line.get_end_node())
			else:
				set_level_node(_line.get_start_node())
			set_line(null, -1)


func _set_points(s, e):
	_next_point = _line.get_point_position(e) + _line.global_position
	position = _line.get_point_position(s) + _line.global_position


func set_line(l, dir):
	if(_line !=  null):
		_line.default_color = Color(0, 0, 0)
	
	_line = l
		
	if(l != null):
		l.default_color = Color(1, 0, 0)
		
		if(dir == FORWARD):
			_point_dir = 1
			_start_index = 0
		elif(dir == BACKWARD):
			_point_dir = -1
			_start_index = l.points.size() -1

		_set_points(_start_index, _start_index + _point_dir)


func set_speed(s):
	_speed = s


func get_level_node():
	return _level_node


func set_level_node(n):
	if(_level_node != null):
		_level_node.modulate = Color(1, 1, 1)
	
	_level_node = n
	
	if(_level_node != null):
		position = _level_node.rect_position
		_level_node.modulate = Color(1, 0, 0)
