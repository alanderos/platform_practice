extends CharacterBody2D

var jumps := 2
var cJump := 0
var speed := 120
var direccion := 0.0
var jump := 250
const gravity := 9 
@onready var anim = $AnimationPlayer
@onready var sprite = $Sprite2D


func _physics_process(delta):
	direccion = Input.get_axis("ui_left","ui_right")
	velocity.x = direccion * speed
	
	if direccion != 0:
		anim.play("walk")
	else:
		anim.play("idle")
	
	sprite.flip_h = direccion < 0 if direccion != 0 else sprite.flip_h
	
	# if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
	#	velocity.y -= jump
	if is_on_floor(): 
		cJump = 0;
	if Input.is_action_just_pressed("ui_accept") and cJump < jumps:
		if cJump == 0:
			velocity.y -= jump
		else:
			velocity.y -= jump*0.7
		cJump+=1
		
		
	if !is_on_floor():
		velocity.y += gravity
		anim.play("jump");
	
	move_and_slide()
