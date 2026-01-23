# block.gd
extends Area2D
class_name Block

# Preloads all of the possible colors for shapes
var blue: Texture2D = load("res://assets/graphics/blocks/blue.png")
var purple: Texture2D = load("res://assets/graphics/blocks/purple.png")
var green: Texture2D = load("res://assets/graphics/blocks/green.png")
var yellow: Texture2D = load("res://assets/graphics/blocks/yellow.png")
var red: Texture2D = load("res://assets/graphics/blocks/red.png")

# Preloads all of the possible shadow colors for shapes
var blue_shadow: Texture2D = load("res://assets/graphics/shadows/blue_shadow.png")
var purple_shadow: Texture2D = load("res://assets/graphics/shadows/purple_shadow.png")
var green_shadow: Texture2D = load("res://assets/graphics/shadows/green_shadow.png")
var yellow_shadow: Texture2D = load("res://assets/graphics/shadows/yellow_shadow.png")
var red_shadow: Texture2D = load("res://assets/graphics/shadows/red_shadow.png")

var block_color: Enums.BlockColor

# Make shadow invisible at the beginning
func _ready() -> void:
	$SpriteShadow.visible = false

# Make blocks above screen invisible
func _process(_delta: float) -> void:
	if global_position.y < 0:
		visible = false
	else:
		visible = true

## Sets the color of the block based on attribute set by shape class
func set_block_color(color: Enums.BlockColor) -> void:
	match color:

		Enums.BlockColor.BLUE:
			get_node("Sprite2D").texture = blue
			get_node("SpriteShadow").texture = blue_shadow

		Enums.BlockColor.PURPLE:
			get_node("Sprite2D").texture = purple
			get_node("SpriteShadow").texture = purple_shadow

		Enums.BlockColor.GREEN:
			get_node("Sprite2D").texture = green
			get_node("SpriteShadow").texture = green_shadow

		Enums.BlockColor.YELLOW:
			get_node("Sprite2D").texture = yellow
			get_node("SpriteShadow").texture = yellow_shadow

		Enums.BlockColor.RED:
			get_node("Sprite2D").texture = red
			get_node("SpriteShadow").texture = red_shadow

		_:
			get_node("Sprite2D").texture = red
			get_node("SpriteShadow").texture = red_shadow

func disappear() -> void:
	remove_from_group("Blocks")
	$AnimationPlayer.play("disappear")

func _on_animation_finished(_anim_name: StringName) -> void:
	queue_free()
