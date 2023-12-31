extends Node

@export var mob_scene: PackedScene

func _ready():
	$UserInterface/Retry.hide()
	

func _on_mob_spawner_timeout():
	var mob = mob_scene.instantiate()


	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	mob_spawn_location.progress_ratio = randf()

	var player_position = Vector3.ZERO
	if not $Player == null:
		player_position = $Player.position
	mob.initialize(mob_spawn_location.position, player_position)

	add_child(mob)
	mob.squashed.connect($UserInterface/ScoreLabel._on_mob_squashed.bind())


func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
		# This restarts the current scene.
		get_tree().reload_current_scene()

func _on_player_hit():
	print("Player hit!")
	$MobSpawner.stop()
	$UserInterface/Retry.show()
	
