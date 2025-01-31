class_name Projectile extends CharacterBody2D
var timed := false
func _physics_process(delta: float) -> void:
	move_and_slide()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _ready() -> void:
	$Sprite2D.scale = Global.projectileSize
	$Area2D/CollisionShape2D.scale = Global.projectileSize
	$CollisionShape2D.scale = Global.projectileSize

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player and timed:
		queue_free()
	elif body is TileMap and timed:
		queue_free()
	elif body is Projectile and timed:
		queue_free()


func _on_timer_timeout() -> void:
	timed = true
