extends "res://addons/gut/test.gd"
#Ce script teste les différentes méthodes de la classe TimeControl

var timeControl = preload("res://Source/Autoload/Script/TimeControl.gd").new() #On load TimeControl
var timeControl_scene = preload("res://Source/Autoload/Scene/TimeControl.tscn").instance()
var timer = timeControl_scene.get_node("TimeResetTimer")

func test_set_player_inputs():
	timeControl.set_player_inputs("move")
	assert_eq(timeControl.player_inputs, ["move"], "Should succeed : player_inputs=[move] que l'on ajoute par set_player_inputs(move)")

func test_get_player_inputs():
	var timeControl = preload("res://Source/Autoload/Script/TimeControl.gd").new() #On reload une nouvelle instance de TimeControl
	timeControl.set_player_inputs("paw")
	timeControl.set_player_inputs("pow")
	var out = timeControl.get_player_inputs()
	assert_eq(out, ["paw","pow"], "Should succeed : la liste modifiée [paw,pow] est relevée par get_player_inputs")

func test_set_clone_exists():
	timeControl.set_clone_exists(true)
	assert_eq(timeControl.clone_exists, false, "Should fail : clone_exists a été mis à true")

func test_get_clone_exists():
	timeControl.set_clone_exists(true)
	var out = timeControl.get_clone_exists()
	assert_eq(out, true, "Should succeed : clone_exists=true donc get_clone_exists va donner true")
