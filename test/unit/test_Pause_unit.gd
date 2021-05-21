extends "res://addons/gut/test.gd"
var Pause = preload("res://Source/UserInterface/Script/Pause.gd").new()
func test_read():
	Pause.visible = true
	Pause._read()
	assert_eq(Pause.visible, false, "Should succeed: visible doit être false après l'application de la fonction")
