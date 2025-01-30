extends Control

#@onready var Screen

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
	
	# Increase chicken spawn rate
	Global.chickenSpawn = Global.chickenSpawn-0.3
	if Global.level == 5:
		strongerChicken()

func strongerChicken():
	Global.chickenspeed += 10

func _on_firerate_pressed() -> void:
	Global.fireRate -= 0.1
	get_parent().get_node("Timer").wait_time = Global.fireRate
	moreChicken()

func _on_damage_pressed() -> void:
	Global.projectileDamage += 0.1
	moreChicken()
