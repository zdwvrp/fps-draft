class_name Hiker extends CharacterBody3D

# Node definitions
@onready var collision_shape := $Standing_Collision_Shape
@onready var head := $Head
@onready var twist_pivot := $Head/TwistPivot
@onready var pitch_pivot := $Head/TwistPivot/PitchPivot
@onready var standing_ray := $Standing_Ray
@onready var crouching_ray := $Crouching_Ray
@onready var interact_ray := $Head/TwistPivot/PitchPivot/Interact_Ray

# Import Script Classes
# const Backpack = preload("res://backpack.gd")

# Mouse & Camera Variables
var mouse_sensitivity := 0.1
var twist_input := 0.0
var pitch_input := 0.0


################################
## Speed & Movement Variables ##
################################

var gravity = 2 * ProjectSettings.get_setting("physics/3d/default_gravity") # Get gravity from project settings
var current_speed := 0.0
const jump_velocity := 8.0

# Movement States
var idle = true
var walking = false
var sprinting = false
var crouching = false
var current_movement_state = [true, false, false, false, false]
const movement_state_map = {
	"idle": 0,
	"walk": 1,
	"crouch": 2,
	"sprint": 3,
	"prone": 4
}
var current_movement_state_speed = 0.0
const movement_state_speed_map = {
	"idle": 0.0,
	"walk": 5.0,
	"crouch": 2.5,
	"sprint": 10.0,
	"prone": 1.5
}
var current_movement_state_depth = 2.0
const movement_state_depth_map = {
	"idle": 2.0,
	"walk": 2.0,
	"crouch": 1.2,
	"sprint": 2.0,
	"prone": 0.3
}
var current_movement_state_head_depth = 1.8
const movement_state_head_depth_map = {
	"idle": 1.8,
	"walk": 1.8,
	"crouch": 1.0,
	"sprint": 1.8,
	"prone": 0.1
}

var lerp_speed = 5.0
var collision_lerp_speed = 3.0
var direction = Vector3.ZERO
var throw_direction = Vector3.ZERO

var can_interact = false # Set this to true if a ray shooting out of the camera is intersecting with an interactable object


################################
##          Backpack          ##
################################

var backpack: Backpack = null # For now, null means no backpack. May want to create a "backpack 0" that can be used for this.
var current_weight = 0 # Cumulative weight of all items in inventory.
var inventory = [] # Stores an array of objects that are currently in the player's inventory.

const Backpack_Scene = preload("res://backpack.tscn")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) # Hide mouse cursor
	GlobalScript.player = self

func _physics_process(delta):
	
	if get_movement_state("string") != "prone":
		# Crouch
		if Input.is_action_pressed("crouch"):
			set_movement_state("crouch")
		
		elif !standing_ray.is_colliding():
			# Sprint - Only allow sprint to be toggled when on the ground
			if Input.is_action_pressed("sprint"):
				if is_on_floor():
					set_movement_state("sprint")
			else:
				set_movement_state("walk")
	
	# Prone
	if Input.is_action_just_pressed("prone"):
		if get_movement_state("string") == "prone":
			print("standing up...")
			set_movement_state("walk")
		else:
			print("going prone...")
			set_movement_state("prone")
	

	
	current_speed = lerp(current_speed, current_movement_state_speed, delta * lerp_speed)
	if current_movement_state_depth < 2.0 or !standing_ray.is_colliding():
		head.position.y = lerp(head.position.y, current_movement_state_head_depth - 1.0, delta * lerp_speed)
		collision_shape.shape.height = lerp(collision_shape.shape.height, current_movement_state_depth, delta * collision_lerp_speed)
		collision_shape.position.y = lerp(collision_shape.position.y, current_movement_state_depth - 2.0, delta * collision_lerp_speed)
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump. Can't jump while prone or not on floor
	if Input.is_action_just_pressed("jump") and is_on_floor() and get_movement_state("string") != "prone":
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	direction = lerp(direction, (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(), delta * lerp_speed)
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)
	move_and_slide()

func _process(_delta):
	# Pressing ESC makes mouse visible for closing test window
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	# Check for interactable object that can be interacted with
	if can_interact != interact_ray.is_colliding():
		can_interact = interact_ray.is_colliding()
	if (can_interact):
		var collision = interact_ray.get_collider()
		if collision != null:
			if collision.get_parent().name == "Backpack":
				GlobalScript.ui_context.update_content("Equip Backpack")
				GlobalScript.ui_context.update_icon(GlobalScript.ui_context.default_icon, true)
				if Input.is_action_just_pressed("equip"):
					equip_backpack(collision.get_parent().get_collection_id(), collision.get_parent())
			# print(collision.get_parent().name) # For testings
	else:
		GlobalScript.ui_context.reset()
	
	if (backpack != null and Input.is_action_just_pressed("unequip_backpack")):
		unequip_backpack()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		# Moving the camera
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			rotate_y( deg_to_rad(-event.relative.x * mouse_sensitivity) )
			head.rotate_x( deg_to_rad(-event.relative.y * mouse_sensitivity) )
			head.rotation.x = clamp( head.rotation.x, deg_to_rad(-89), deg_to_rad(89) )
	
	# For Testing: Press "R" to reset sandbox scene
	if event is InputEventKey and event.is_action("reset"):
		get_tree().reload_current_scene()
	



########################
##    Custom Funcs    ##
########################

# set_movement_state: Sets the current movement state of the player to true, and all other movement states to false.
func set_movement_state(new_state: String):
	for state in movement_state_map:
		if state == new_state:
			current_movement_state[movement_state_map[state]] = true
			current_movement_state_speed = movement_state_speed_map[state]
			current_movement_state_depth = movement_state_depth_map[state]
			current_movement_state_head_depth = movement_state_head_depth_map[state]
		else:
			current_movement_state[movement_state_map[state]] = false

# get_movement_state: Returns the current movement state in the specified type. "string" | "int"
func get_movement_state(type: String):
	for state in movement_state_map:
		if current_movement_state[movement_state_map[state]]:
			if type == "string":
				return state
			elif type == "int":
				return movement_state_map[state]
	if type == "string":
		return "-1"
	else:
		return -1

func equip_backpack(id: int, obj):
	print("equip_backpack")
	var new_backpack = Backpack.new(id)
	if new_backpack.collection_id > 0:
		# We can equip this backpack
		backpack = Backpack.new(id)
		# obj.get_parent().queue_free()
		obj.queue_free()
		return 1
	else:
		# PUT LOG HERE
		return -1

func unequip_backpack():
	print("unequip_backpack")
	if backpack != null:
		var backpack_node = Backpack_Scene.instantiate()
		backpack_node.position = head.global_position - (head.global_transform.basis.z * 1.5) # Needs work
		print("head.transform.basis.z: ", head.transform.basis.z)
		get_parent().add_child(backpack_node)
		backpack = null
