extends Node2D

var plant = "sunflower"
var cooldown = Time.get_unix_time_from_system()
var data

func init_plant(data_obj):
	data = data_obj

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var now = Time.get_unix_time_from_system()
	if (now - cooldown) > PlantData.plants[plant]["recharge"]:
		create_sun()
		cooldown = now

func create_sun():
	var sun = load("res://sun.tscn").instantiate()
	add_child(sun)
	var rng = RandomNumberGenerator.new()
	sun.position = Vector2(rng.randf_range(-2, 6), 10)
	sun.z_index = 3
