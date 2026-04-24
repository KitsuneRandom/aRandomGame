extends CharacterBody2D

@onready var sprite=$Sprite
@onready var collision =$Collision
@onready var up_ray: RayCast2D = $UpRay
@onready var down_ray: RayCast2D = $DownRay
@onready var left_ray: RayCast2D = $LeftRay
@onready var right_ray: RayCast2D = $RightRay

var tile_size :Vector2 =Vector2(32,32)
var movement_tween : Tween
var move_speed =0.4

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if !movement_tween || !movement_tween.is_running():
		if Input.is_action_pressed("left"):
			sprite.flip_h=false
			if !left_ray.is_colliding():
				sprite.play("walk")
				await move(Vector2(-1,0))
		elif Input.is_action_pressed("right"):
			sprite.flip_h=true
			if !right_ray.is_colliding():
				sprite.play("walk")
				await move(Vector2(1,0))
		elif Input.is_action_pressed("down"):
			sprite.flip_h=true
			if !down_ray.is_colliding():
				sprite.play("walk")
				await move(Vector2(0,1))
		elif Input.is_action_pressed("up") :
			sprite.flip_h=false
			if !up_ray.is_colliding():
				sprite.play("walk")
				await move(Vector2(0,-1))
		else:
			sprite.play("idle")

func move(dir : Vector2):
	movement_tween= create_tween()
	movement_tween.set_trans(Tween.TRANS_QUAD)
	movement_tween.tween_property(self,"global_position",self.global_position+dir*tile_size,move_speed)
