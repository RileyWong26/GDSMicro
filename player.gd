extends CharacterBody2D
@export var projectileScene: PackedScene

const SPEED = 100.0

func _physics_process(delta: float) -> void:

	#var direction := Input.get_axis("ui_left", "ui_right")
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		velocity = direction * SPEED
	else: 
		velocity = Vector2i(0,0)
	move_and_slide()
	
	var angle := get_angle_to(get_global_mouse_position())* (180/PI) + 90
	$Sprite2D.rotation_degrees = angle
	
func shoot():
	var projectile = projectileScene.instantiate()
	get_parent().add_child(projectile)
	projectile.global_position = global_position
	var target = (get_global_mouse_position() - global_position).normalized()
	projectile.velocity = target * 300
	
func _on_timer_timeout() -> void:
	shoot()
