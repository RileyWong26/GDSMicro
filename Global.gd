extends Node
var score := 0.0

var playerspeed := 60.0
var fireRate := 1.0
var projectileDamage := 0.1
var projectileSize := Vector2(1.0, 1.0)

var chickenspeed := 50.0
var chickenSpawn := 5.0
var bigChicken := false
var speedChicken := 100.0
var speedChickenChance := 0
var chickenHealth := 1.0
var speedChickenHealth := 0.2 # Change
var bigChickenHealth := 50

var toLevelUp := 3.0
var level := 1
var progress := 0.0

var dead := false

func reset():
	score = 0.0

	playerspeed = 60.0
	fireRate = 1.0
	projectileDamage = 0.1
	projectileSize = Vector2(1.0, 1.0)

	chickenspeed = 50.0
	chickenSpawn = 5.0
	speedChickenChance = 0
	speedChicken = 100.0
	bigChicken = false
	chickenHealth = 1.0
	speedChickenHealth = 0.2
	bigChickenHealth = 50.0

	toLevelUp = 3.0
	level = 1
	progress = 0.0

	dead = false
