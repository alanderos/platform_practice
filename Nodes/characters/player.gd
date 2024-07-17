extends CharacterBody2D
class_name Player


var jumps := 2
var cJump := 0
var speed := 120
var direccion := 0.0
var jump := 250
const gravity := 9 
@onready var anim = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var frutas_label = $PlayerGUI/HBoxContainer/FrutasLabel

func _ready():
	Global.player = self

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
		jumping()
		
	if !is_on_floor():
		velocity.y += gravity
		anim.play("jump");
	wallJumping()
	
	move_and_slide()
	
func jumping():
	if cJump == 0:
			velocity.y -= jump
	else:
		velocity.y -= jump*0.7
	cJump+=1
	


func wallSlide():
	if is_on_wall() and Input.is_action_pressed("ui_accept") and not is_on_floor() and not Input.is_action_just_pressed("ui_accept"):
		velocity.y = gravity * .9
		
	
func wallJumping():
	if not is_on_wall(): return
	
	var wall_normal = get_wall_normal()
	print("normal: ",wall_normal)
	print("Vector2 ",Vector2.LEFT)
	if Input.is_action_pressed("ui_right") and Input.is_action_just_pressed("ui_accept") and Vector2.LEFT == wall_normal:
		velocity.x = -wall_normal.x * speed
		velocity.y = -jump
		print("jump left")
	if Input.is_action_pressed("ui_left") and Input.is_action_just_pressed("ui_accept") and Vector2.RIGHT == wall_normal:
		velocity.x = -wall_normal.x * speed
		velocity.y = -jump
		print("jump right")
	#else: wallSlide()
func actualizaInterfazFrutas():
	frutas_label.text = str(Global.frutas)
