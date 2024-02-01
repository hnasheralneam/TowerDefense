extends Node

var sun = 250

# Called when the node enters the scene tree for the first time.
func _ready():
	update_sun_label()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func get_sun():
	return sun

func use_sun(amount):
	sun -= amount
	update_sun_label()
	
func add_sun(amount):
	sun += amount
	update_sun_label()
	
func update_sun_label():
	var sun_amount = get_tree().get_root().get_node("Node2D").get_node("CanvasLayer").get_node("HBoxContainer").get_node("sun_amount")
	sun_amount.text = str(sun) + " sun"
