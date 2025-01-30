extends Node2D
@export var chickenScene : PackedScene
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var chicken = chickenScene.instantiate()
	add_child(chicken)
	var ranx := rng.randi_range(500, 500)
	var rany := rng.randi_range(100, 500)
	var negativex := rng.randi_range(0,1)
	var negativey := rng.randi_range(0,1)
	if negativex == 0:
		ranx = -1 * ranx
	if negativey == 0:
		rany = -1 * rany
	chicken.global_position = $Player.global_position + Vector2(ranx, rany)
	
