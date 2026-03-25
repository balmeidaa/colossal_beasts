extends CanvasLayer

onready var tween = $Tween
#si algo sale mal cambiar a nodo control
onready var vbox = $Control/VBox

export var anim_time := 1.2

var viewport_size: Vector2
var is_hiding = true


func _ready():
	viewport_size = get_viewport().size
	vbox.rect_position.x =  - viewport_size.x 
	
func toggle_menu():
	is_hiding = !is_hiding
	
	if is_hiding:
		hide_menu()
	else:
		show_menu()

func show_menu():
	tween.interpolate_property(vbox, "rect_position:x",
		vbox.rect_position.x, (vbox.rect_position.x +  viewport_size.x), anim_time,
		Tween.TRANS_CIRC, Tween.EASE_IN_OUT)
	tween.start()

func hide_menu():
	tween.interpolate_property(vbox, "rect_position:x",
		vbox.rect_position.x, (vbox.rect_position.x -  viewport_size.x), anim_time,
		Tween.TRANS_CIRC, Tween.EASE_IN_OUT)
	tween.start()

