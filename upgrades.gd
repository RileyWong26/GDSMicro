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
	if Input.is_action_just_pressed("1"):
		_on_button_pressed()
	elif Input.is_action_just_pressed("2"):
		_on_firerate_pressed()
	elif Input.is_action_just_pressed("3"):
		_on_damage_pressed()
	elif Input.is_action_just_pressed("4"):
		_on_size_pressed()

func fakeClick(mouseposition):
	var clickEvent = InputEventMouseButton.new()
	var relativePos := Vector2(window_size.x / viewport_size.x, window_size.y / viewport_size.y)
	clickEvent.button_index = MOUSE_BUTTON_LEFT
	clickEvent.pressed = true
	clickEvent.position = get_viewport().get_mouse_position() / relativePos
	print(clickEvent.position)
	print($Grid/HFlowContainer3/Button.position)

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
	Global.toLevelUp *= 1.5
	Global.level += 1
	Global.progress = 0
	get_parent().get_node("Level").text = "Level " + str(Global.level) + ":"
	
	# Increase chicken spawn rate
	if Global.chickenSpawn > 0.2:
		Global.chickenSpawn = Global.chickenSpawn-0.2
	if Global.level % 3 == 0:
		strongerChicken()
	if Global.level % 4 == 0:
		healthierChicken()
	if Global.level % 5 == 0:
		if Global.level > 5:
			Global.bigChickenHealth += 10
		Global.bigChicken = true

func healthierChicken():
	Global.chickenHealth *= 1.2
	Global.speedChicken *= 1.2

func strongerChicken():
	if Global.level > 3:
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
