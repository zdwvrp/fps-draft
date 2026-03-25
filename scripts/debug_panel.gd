extends PanelContainer
@onready var property_container = $MarginContainer/VBoxContainer
var property: Label
var fps: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	add_debug_property("FPS", fps)

func _process(delta) -> void:
	fps = "%.2f" % (1.0/delta)
	property.text = property.name + "| " + fps

func _input(event) -> void:
	# Toggle visibility of debug panel
	if event.is_action_pressed("toggle_debug_panel"):
		visible = !visible

func add_debug_property(title: String, value):
	property = Label.new()
	property_container.add_child(property)
	property.name = title
	property.text = property.name + value
