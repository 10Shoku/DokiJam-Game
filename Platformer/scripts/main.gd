extends Node2D

# In your game scene script
func _ready():
	var player = $Player
	var coin_ui = $CoinUI
	player.coins_updated.connect(coin_ui.update_coin_display)
