extends Control

var viewport_size
var mouseposition := Vector2(0,0)
@onready var window_size := Vector2(get_window().size)

func _process(delta: float) -> void:
	if get_tree().paused:
		viewport_size = Vector2(get_viewport().size)
		var mousedirection := Input.get_vector("mouseLeft","mouseRight","mouseUp","mouseDown")
		if mousedirection != Vector2(0,0):
			var movement := mousedirection.normalized() * delta * 1000
			mouseposition = clamp(get_viewport().get_mouse_position() + movement, Vector2(0,0), viewport_size - Vector2(1,1))
			get_viewport().warp_mouse(mouseposition)
		
		if Input.is_action_just_pressed("select"):
			fakeClick(mouseposition)

func fakeClick(mouseposition):
	var clickEvent = InputEventMouseButton.new()
	var relativePos := Vector2(window_size.x / viewport_size.x, window_size.y / viewport_size.y)
	clickEvent.button_index = MOUSE_BUTTON_LEFT
	clickEvent.pressed = true
	clickEvent.position = get_viewport().get_mouse_position() / relativePos

	Input.parse_input_event(clickEvent)
	
	await get_tree().create_timer(0.1).timeout  # Small delay for natural behavior
	clickEvent.pressed = false
	Input.parse_input_event(clickEvent)

func _on_button_pressed() -> void:
	# Move speed
	Global.playerspeed += 10
	moreChicken()
	
func moreChicken():
	# All required calls 
	get_tree().paused = false
	hide()
	Global.toLevelUp = Global.toLevelUp*2
	Global.level += 1
	Global.progress = 0
	get_parent().get_node("Level").text = "Level " + str(Global.level) + ":"
	
	# Increase chicken spawn rate
	Global.chickenSpawn = Global.chickenSpawn-0.3
	if Global.level % 3 == 0:
		strongerChicken()
	if Global.level % 5 == 0:
		Global.bigChicken = true

func strongerChicken():
	Global.chickenspeed += 10
	Global.speedChicken += 10
	Global.speedChickenChance += 2

func _on_firerate_pressed() -> void:
	Global.fireRate -= 0.1
	get_parent().get_node("Timer").wait_time = Global.fireRate
	moreChicken()

func _on_damage_pressed() -> void:
	Global.projectileDamage += 0.1
	moreChicken()


func _on_size_pressed() -> void:
	Global.projectileSize += Vector2(0.2, 0.2)
	moreChicken()
