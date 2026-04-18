extends Node

## maneja todos los eventos dentro del juego
var active_menu = null
var action_queue = null
var target_solver = null

func _ready():
	pass
	
########
### action menu
########
func update_ui_action_menu(menu_node):
	# menu_activo es nulo se asigna
	# menu es distinto se esconde el menu activo y cambia al nuevo
	# si es el mismo se libera, ya que se esconde asi mismo
	if active_menu == null:
		active_menu = menu_node
	elif active_menu != menu_node:
		active_menu.toggle_menu()
		active_menu = menu_node
	else:
		active_menu = null

#revisa si se hizo click afuera del menu y lo cierra
func _input(event):
	if active_menu == null:
		return
		#TODO
	# tal vez resetear el target solver si no obtiene click en ningun objeto valido
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_LEFT:
			if !Rect2(Vector2(0,0),active_menu.get_rect_size()).has_point(event.position):
				active_menu.toggle_menu()
				#DEBUG
				#print("Clicked at: ", event.position)
		 

