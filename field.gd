extends Node2D
@export var chickenScene : PackedScene
@export var speedChickenScene : PackedScene
@export var bigChickenScene : PackedScene
var rng = RandomNumberGenerator.new()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_tree().paused == true and Global.dead and Input.is_action_just_pressed("select"):
		get_tree().paused = false
		get_tree().reload_current_scene()
		Global.reset()
	
func _on_timer_timeout() -> void:
	if get_tree().paused == false:
		var roll = rng.randi_range(1, 10)
		if roll <= Global.speedChickenChance:
			var speedChicken = speedChickenScene.instantiate()
			add_child(speedChicken)
			var ranx := rng.randi_range(500, 500)
			var rany := rng.randi_range(100, 500)
			var negativex := rng.randi_range(0,1)
			var negativey := rng.randi_range(0,1)
			if negativex == 0:
				ranx = -1 * ranx
			if negativey == 0:
				rany = -1 * rany
			speedChicken.global_position = $Player.global_position + Vector2(ranx, rany)
			
		if Global.bigChicken:
			var bigChicken = bigChickenScene.instantiate()
			add_child(bigChicken)
			var ranx2 = 800
			var rany2 = 800
			var negativex2 := rng.randi_range(0,1)
			var negativey2 := rng.randi_range(0,1)
			if negativex2 == 0:
				ranx2 = -1 * ranx2
			if negativey2 == 0:
				rany2 = -1 * rany2
			bigChicken.global_position = $Player.global_position + Vector2(ranx2, rany2)
			Global.bigChicken = false
		
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
		$Timer.wait_time = Global.chickenSpawn
		
	
