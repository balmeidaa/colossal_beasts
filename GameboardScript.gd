extends Spatial

var card_maker = load("res://board/Card.tscn")
onready var player_cards = $PlayerCards
onready var opponent_cards = $OpponentCards
## posiciones iniciales de las cartas
var player_cards_pos = [] 
var opponent_cards_pos = []


#inyectar nombres de cartas
func _ready():
	player_cards_pos = player_cards.get_children()
	opponent_cards_pos = opponent_cards.get_children()
	
	##TEST PURPOSES ONLY
	for _i in range(3):
		_add_card('teryx')
		_add_card('hydra', 'opponent')
	
	GameHandler.emit_signal('game_ready', GameData.States.PRECOMBAT)

## para evitar bugs 
## 1. crear instancia
## 2. agregar instancia
## 3. cargar datos
func _add_card(card_name, entity = 'player'):
	var new_card = card_maker.instance()
	var card_position = null
	if entity == 'player':
		player_cards.add_child(new_card)
		card_position = player_cards_pos.pop_back()
		new_card.add_to_group("player_cards")
	else:
		opponent_cards.add_child(new_card)
		card_position = opponent_cards_pos.pop_back()
		new_card.add_to_group("opponent_cards")
		
	new_card.load_card(card_name, entity)
	new_card.translation = card_position.translation
	
