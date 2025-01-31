extends Chicken


func _ready() -> void:
	health = Global.speedChickenHealth
	scaled = 1.0 / health

func _physics_process(delta: float) -> void:
	var target = get_parent().get_node("Player").global_position
	velocity = (target - global_position).normalized() * Global.speedChicken
	
	var angle := velocity.angle() * (180/PI) - 90
	$Sprite2D.rotation_degrees = angle
	$Area2D/CollisionShape2D.rotation_degrees = angle
	move_and_slide()
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Projectile:
		health -= Global.projectileDamage
		$Sprite2D.scale = Vector2(health, health) * scaled
		$Area2D/CollisionShape2D.scale = Vector2(health, health) * scaled
		if $Sprite2D.scale.x <= 0.01:
			Global.progress += 1
			get_parent().get_node("Player/LevelProgress").value = float(Global.progress/Global.toLevelUp) * 100
			
			if get_parent().get_node("Player/LevelProgress").value == 100:
				
				get_parent().get_node("Player/LevelProgress").value = 0
				get_tree().paused = true
				PlayerUpgrades.show()
				
			Global.score += 10
			queue_free()
		body.queue_free()
	if body is Player:
		Global.dead = true
		get_tree().paused = true
