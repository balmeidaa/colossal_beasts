extends GridMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const Y := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0,5):
		set_cell_item(i,Y,0,0,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
