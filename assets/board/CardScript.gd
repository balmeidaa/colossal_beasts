extends Sprite3D

export var desired_world_height  := 12.0
onready var action_menu = $ActionMenu
 

func _ready():
	# cambiar tamaño de la textura
	var img_h = texture.get_height() 
	pixel_size = desired_world_height / img_h


func _on_ClickableArea_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			action_menu.toggle_menu()

		
