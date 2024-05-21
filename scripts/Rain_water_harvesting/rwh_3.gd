extends StaticBody2D
var minimap_icon = "alert"
@onready var anim = $AnimatedSprite2D
var RWHSI : bool = false
var interactable
var show=false

func _ready():
	$Label.visible = false
	$Watertank.visible = false
	anim.play("default")

func _process(delta):
	if Game.home3_agreed and not Game.rwh3_installed:
		show=true
		self.add_to_group("minimap_objects")
	if Game.rwh3_assesible and Game.home3_agreed and not Game.rwh3_installed and Input.is_action_pressed("Interact"):
		install_rwh()
		Game.rwh3_installed = true
		Game.Water += 15
	if Game.rwh3_installed :
		show=false
		self.remove_from_group("minimap_objects")
		
		
		
	

func install_rwh():
	self.remove_from_group("minimap_objects")
	show=false
	$Watertank.visible = true
	anim.play("Done")
	self.remove_from_group("rain_water_harvesting")

func _on_animated_sprite_2d_animation_finished():
	if anim.animation == "Done":
		anim.visible = false


func _on_area_2d_body_entered(body):
	if body.name == "mayor":
		if show==true:
			$Label.visible = true
		Game.rwh3_assesible = true


func _on_area_2d_body_exited(body):
	if body.name == "mayor":
		if show==false:
			$Label.visible = false
		Game.rwh3_assesible = false
	
