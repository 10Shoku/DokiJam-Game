extends CanvasLayer


func _ready():
	pass
	print("=== DEBUG ===")
	print("CoinUI loaded in main scene? ", self != null)  # Should be true
	print("Label reference: ", $Label)  # Should NOT be null
	print("Label text: ", $Label.text if $Label else "NO LABEL")

func update_coin_display(coins: int):
	#if $Label == null:
		#printerr("Label is null! Check node path.")
		#return  # Exit to prevent crash

	$Label.text = "Coins: {0}".format({"0": GlobalPlatformer.coins})
