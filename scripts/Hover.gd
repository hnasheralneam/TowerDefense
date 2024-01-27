extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


@onready var icon = get_node("Icon")
func _on_mouse_entered():
	icon.visible = true



func _on_mouse_exited():
	icon.visible = false



func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton && event.pressed:
		MapSpots.try_place_item(self.name)

