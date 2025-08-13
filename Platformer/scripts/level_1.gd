extends Node2D

func _ready():
	var player = $player
	var coin_ui = $CoinUI
#	player.coins_updated.connect(coin_ui.update_coin_display)
	
	# Set initial spawn if no checkpoints touched
	#if GlobalPlatformer.checkpoint_position == Vector2.ZERO:
		#GlobalPlatformer.checkpoint_position = $player.global_position
