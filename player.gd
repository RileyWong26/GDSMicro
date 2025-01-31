class_name Player extends CharacterBody2D
@export var projectileScene: PackedScene

func _ready() -> void:
	$Upgrades.hide()

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	if direction:
		velocity = direction * Global.playerspeed
	else: 
		velocity = Vector2i(0,0)
	move_and_slide()
	
	var angle := get_angle_to(get_global_mouse_position())* (180/PI) + 90
	var mousedirection := Input.get_vector("mouseLeft","mouseRight","mouseUp","mouseDown").normalized()
	if mousedirection:
		angle = get_angle_to(global_position + mousedirection)* (180/PI) + 90
	$Sprite2D.rotation_degrees = angle
	$CollisionShape2D.rotation_degrees = angle
	#$SpawnNode.global_position = global_position + get_global_mouse_position().normalized()
	$TextEdit.text = "Score: " + str(Global.score)
	

func shoot():
	var projectile = projectileScene.instantiate()
	get_parent().add_child(projectile)
	projectile.global_position = $Sprite2D/SpawnNode.global_position
	var target = (get_global_mouse_position() - global_position).normalized()
	
	var mousedirection := Input.get_vector("mouseLeft","mouseRight","mouseUp","mouseDown").normalized()
	if mousedirection != Vector2(0,0):
		target = (mousedirection)
		
	projectile.velocity = target * 300
func _on_timer_timeout() -> void:
	shoot()
