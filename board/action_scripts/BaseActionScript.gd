extends Node

class_name BaseAction
#crear scripts basicos
#daño
#movimiento
#buff/debuff
#formula daño
# (daño * mod_mult) + mod_sum

#{
#	"card_played": "@Card@8:[Sprite3D:1555]",
#	"objective_type": "enemy",
#	"action_icon": "action-melee",
#	"script_name": "claw_swipe",
#	"target": "@Card@11:[Sprite3D:1602]"
#}
func increase_defense(target, amount):
	target.increase_defense(amount)
	
func set_buff(target, buff_name):
	var buff_dat = GameData.buff_list[buff_name]
	target.modifiers['buff_name'] = buff_dat.duplicate()
	
func deal_damage(target, damage):
	target.recieve_damage(damage)

