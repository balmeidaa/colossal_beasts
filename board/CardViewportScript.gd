extends Viewport

var ui_container = null

func _ready():
	var node_child = get_children()
	if node_child == null:
		return
	## solo deberia tener un hijo el viewport
	ui_container = node_child[0].get_node("Control/VBox")
	ui_container.connect("container_resized", self, "_resize_viewport")
	### DEBUG FUNC
	#_resize()


func _resize():	
	if ui_container == null:
		return
	size = ui_container.rect_size

func _resize_viewport(new_size):
	size = new_size
