extends CanvasLayer

##enviarse a si mismo al game-handler
onready var player_q_ui = $HBox/Player
onready var opponent_q_ui = $HBox/Opponent

var mini_card = preload("res://assets/board/ui/CardMini.tscn")

const max_q_size = 5

var player_q = []
var opponent_q = []

func _ready():
	GameHandler.action_queue = self

func add_ui_action_Q(action_taken, entity = 'player'):
	var new_mini = mini_card.instance()
	## TO DO
	## * hacer distincion al agregar acciones del oponente en un futuro
	## * Agregar limite de acciones por cola
	
	if entity == 'player' and player_q.size() <= max_q_size:
		player_q.append(action_taken)
		player_q_ui.add_child(new_mini)
		new_mini.load_mini(action_taken, player_q.size())
		player_q_ui.move_child(new_mini, 0) #solo para la cola de acciones del jugador, no de oponente
	else:
		opponent_q.append(action_taken)
		opponent_q_ui.add_child(new_mini)
		new_mini.load_mini(action_taken, opponent_q.size())
	 

#aqui no se hace distincion de jugadores ya que solo tendria que modificar la cola del jugador
# y recibir la cola de acciones  completa del oponente
func remove_mini_at(q_position):
	#removido de la cola logica de acciones
	player_q.remove (q_position-1)
	
	var current_minis = _get_all_minis()

	var q_size = player_q.size()
	print(player_q.size())
	#ewmovido de la ui
	for mini in current_minis:
		if mini.initiative_rank == q_position:
			player_q_ui.remove_child(mini)
			mini.queue_free()
		else:
			mini.update_initiative_order(q_size)
		q_size = q_size - 1
		
#limpia ambas colas de acciones		
func clear_all_Qs():
	player_q = []
	opponent_q = []
	_clear_Q(player_q_ui)
	_clear_Q(opponent_q_ui)

func _clear_Q(Q):
	for mini in Q.get_children():
		Q.remove_child(mini)
		mini.queue_free()
		
	

func _get_all_minis():
	return player_q_ui.get_children()
