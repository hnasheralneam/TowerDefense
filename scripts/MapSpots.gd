extends Node

var plots = {
	"Spot1x1": {
		"open": true
	},
	"Spot2x1": {
		"open": true
	},
	"Spot3x1": {
		"open": true
	},
	"Spot4x1": {
		"open": true
	},
	"Spot5x1": {
		"open": true
	}
}

var sun = 150

var towers = {
	"sunflower": {
		"cost": 50,
		"recharge": 10
	}
}

var item_held = "sunflower"

# Called when the node enters the scene tree for the first time.
func _ready():
	print("loaded")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func try_place_item(spot):
	if plots[spot]["open"]:
		check_enough_sun(spot)
		print("spot was empty")
	else:
		print("spot was full")

func check_enough_sun(spot):
	if sun >= towers[item_held]["cost"]:
		sun -= towers[item_held]["cost"]
		plots[spot]["open"] = false
		place_plant(spot)
		# should call a function to actually place a plant
	else:
		print("was not enough sun")

func place_plant(spot: String):
	var y = int(spot[4])
	var x = int(spot[6])
	var pixels_y = (y * 16) - 16
	var pixels_x = (x * 16) - 16

	var tower = load("res://" + item_held + ".tscn").instantiate()
	add_child(tower)
	tower.position = Vector2(pixels_x, pixels_y)
	tower.z_index = 5

