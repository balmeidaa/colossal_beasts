extends TextureRect

onready var counter = $Counter

func load_buff(icon_name, count):
	var icon_file = GameData.load_action_texture(icon_name)
	texture = load(icon_file)
	set_counter(count)
	

func set_counter(count:int):
	if count <= 1:
		counter.hide()
	else:
		counter.show()
	counter.text = String(count)



