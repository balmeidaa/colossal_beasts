extends Node


enum States {IDLE, PRECOMBAT, TURN, POSTCOMBAT}
##variables de control de turno
var state = States.IDLE
var active_turn = ''
var turn_finished = false
#acciones
var action_q = []
##donde evaluar que el jugador ya hizo todas sus acciones posibles?
##al momento de ejecutar accion como saber esperar y ejecutar la siguiente?

func _ready():
	GameHandler.connect("game_ready", self, 'set_state')
	GameHandler.connect("turn_finished", self, 'turn_finished') #necesita boton de terminar turno para aplicar
	GameHandler.turn_system = self
	active_turn = 'player'

## un ciclo de la maquina es un turno completo x jugador, despues se cambia al turno del oponente	
func _process(_delta):
	match(state):
		States.PRECOMBAT:
			#obtener y aplicar efectos que apliquen antes de combate
			set_state(States.TURN)
		States.TURN: ## solo este estado aguarda hasta q el jugador termine el turno
			#procesar acciones pendientes
			if turn_finished:
				try_wrap_turn()
				

		States.POSTCOMBAT:
			#obtener y aplicar efectos que apliquen despues de combate
			pass
			change_turn()
			set_state(States.PRECOMBAT)
		States.IDLE:
			pass
		

func change_turn():
	if active_turn == 'player':
		active_turn = 'opponent'
		get_tree().call_group("opponent_cards", "reset_actions_remaining")
	else:
		active_turn = 'player'
		get_tree().call_group("player_cards", "reset_actions_remaining")


func try_wrap_turn():
	if action_q.empty(): ## tal vez esperar que termine alguna animacion pendiente antes de cambiar turno
		set_state(States.POSTCOMBAT)
	
# no agregar mas accion si el jugador ya termino su turno
# no abrir el menu de accion
func add_action(action):
	if turn_finished:
		return
	action_q.append(action)

func turn_finished():
	turn_finished = true

func set_state(new_state):
	state = new_state
	

