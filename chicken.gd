extends CharacterBody2D


const SPEED = 300.0


func _physics_process(delta: float) -> void:
	var target = get_parent().get_node("Player").global_position
	velocity = (target - global_position).normalized() * 50
	
	var angle := velocity.angle() * (180/PI) - 90
	$Sprite2D.rotation_degrees = angle
	$Area2D/CollisionShape2D.rotation_degrees = angle
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Projectile:
		$Sprite2D.scale = $Sprite2D.scale - Vector2(0.1,0.1)
		$Area2D/CollisionShape2D.scale = $Area2D/CollisionShape2D.scale - Vector2(0.1,0.1)
		if $Sprite2D.scale.x <= 0:
			queue_free()
		body.queue_free()
