extends Node2D

export var mainGameScene: intro.tscn

func _on_New_Button_button_up():
	get_tree().change_scene(mainGameScene.lvl1.tscn)
