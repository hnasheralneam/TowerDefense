extends Node

var plots = {
	"Spot1x1": {
		"open": true,
		"reference": null
	},
	"Spot2x1": {
		"open": true,
		"reference": null
	},
	"Spot3x1": {
		"open": true,
		"reference": null
	},
	"Spot4x1": {
		"open": true,
		"reference": null
	},
	"Spot5x1": {
		"open": true,
		"reference": null
	},
	"Spot1x2": {
		"open": true,
		"reference": null
	},
	"Spot2x2": {
		"open": true,
		"reference": null
	},
	"Spot3x2": {
		"open": true,
		"reference": null
	},
	"Spot4x2": {
		"open": true,
		"reference": null
	},
	"Spot5x2": {
		"open": true,
		"reference": null
	},
	"Spot1x3": {
		"open": true,
		"reference": null
	},
	"Spot2x3": {
		"open": true,
		"reference": null
	},
	"Spot3x3": {
		"open": true,
		"reference": null
	},
	"Spot4x3": {
		"open": true,
		"reference": null
	},
	"Spot5x3": {
		"open": true,
		"reference": null
	},
	"Spot1x4": {
		"open": true,
		"reference": null
	},
	"Spot2x4": {
		"open": true,
		"reference": null
	},
	"Spot3x4": {
		"open": true,
		"reference": null
	},
	"Spot4x4": {
		"open": true,
		"reference": null
	},
	"Spot5x4": {
		"open": true,
		"reference": null
	},
	"Spot1x5": {
		"open": true,
		"reference": null
	},
	"Spot2x5": {
		"open": true,
		"reference": null
	},
	"Spot3x5": {
		"open": true,
		"reference": null
	},
	"Spot4x5": {
		"open": true,
		"reference": null
	},
	"Spot5x5": {
		"open": true,
		"reference": null
	},
	"Spot1x6": {
		"open": true,
		"reference": null
	},
	"Spot2x6": {
		"open": true,
		"reference": null
	},
	"Spot3x6": {
		"open": true,
		"reference": null
	},
	"Spot4x6": {
		"open": true,
		"reference": null
	},
	"Spot5x6": {
		"open": true,
		"reference": null
	},
	"Spot1x7": {
		"open": true,
		"reference": null
	},
	"Spot2x7": {
		"open": true,
		"reference": null
	},
	"Spot3x7": {
		"open": true,
		"reference": null
	},
	"Spot4x7": {
		"open": true,
		"reference": null
	},
	"Spot5x7": {
		"open": true,
		"reference": null
	},
	"Spot1x8": {
		"open": true,
		"reference": null
	},
	"Spot2x8": {
		"open": true,
		"reference": null
	},
	"Spot3x8": {
		"open": true,
		"reference": null
	},
	"Spot4x8": {
		"open": true,
		"reference": null
	},
	"Spot5x8": {
		"open": true,
		"reference": null
	},
	"Spot1x9": {
		"open": true,
		"reference": null
	},
	"Spot2x9": {
		"open": true,
		"reference": null
	},
	"Spot3x9": {
		"open": true,
		"reference": null
	},
	"Spot4x9": {
		"open": true,
		"reference": null
	},
	"Spot5x9": {
		"open": true,
		"reference": null
	}
}

var shovel_active: bool = false
var item_held = "sunflower"

# Called when the node enters the scene tree for the first time.
func _ready():
	print("loaded")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func toggle_shovel():
	shovel_active = not shovel_active
	return shovel_active

func shovel_item(spot):
	plots[spot]["reference"].queue_free()
	plots[spot]["reference"] = null
	plots[spot]["open"] = true

	
func spot_full(spot):
	return not plots[spot]["open"]

func try_place_item(spot):
	if plots[spot]["open"]:
		check_enough_sun(spot)
	else:
		print("spot was full")

signal use_sun(amount)

func check_enough_sun(spot):
	if SunTracker.sun >= PlantData.plants[item_held]["cost"]:
		SunTracker.use_sun(PlantData.plants[item_held]["cost"])
		
		emit_signal("use_sun", PlantData.plants[item_held]["cost"])
		plots[spot]["open"] = false
		place_plant(spot)
	else:
		print("was not enough sun")

func place_plant(spot: String):
	var y = int(spot[4])
	var x = int(spot[6])
	var pixels_y = (y * 16) - 16
	var pixels_x = (x * 16) - 16

	var tower = load("res://" + item_held + ".tscn").instantiate()
	tower.init_plant({ "spot": spot })
	plots[spot]["reference"] = tower
	add_child(tower)
	tower.position = Vector2(pixels_x, pixels_y)
	tower.z_index = 2

func change_active_plant(plant):
	print(plant)
	item_held = plant
