extends BaseAction

func execute(action_dat):
	deal_damage(action_dat['target'], 2)
#	var pretty = JSON.print(action_dat, "\t")
#	print(pretty)
#	print(GameData.action_list['move'])
