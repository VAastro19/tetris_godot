# game.gd
extends Node2D

# Preloading all the possible shape types
var i_scene: PackedScene = preload("res://scenes/shapes/shape_i.tscn")
var t_scene: PackedScene = preload("res://scenes/shapes/shape_t.tscn")
var o_scene: PackedScene = preload("res://scenes/shapes/shape_o.tscn")
var z_scene: PackedScene = preload("res://scenes/shapes/shape_z.tscn")
var s_scene: PackedScene = preload("res://scenes/shapes/shape_s.tscn")
var l_scene: PackedScene = preload("res://scenes/shapes/shape_l.tscn")
var j_scene: PackedScene = preload("res://scenes/shapes/shape_j.tscn")

var controller: Shape

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("rotate"):
		print("generating shape")
		controller = generate_shape(Enums.BlockShape.L, Enums.BlockColor.GREEN, Vector2(53, 21))
	if Input.is_action_pressed("left") and controller:
		pass
	if Input.is_action_pressed("right") and controller:
		pass

## Generates a shape based on provided type, color at given position
func generate_shape(shape: Enums.BlockShape, shape_color: Enums.BlockColor, pos: Vector2) -> Shape:
	match shape:
		
		Enums.BlockShape.I:
			var i_shape = i_scene.instantiate() as Shape
			i_shape.block_color = shape_color
			i_shape.position = pos
			$Shapes.add_child(i_shape)
			return i_shape

		Enums.BlockShape.T:
			var t_shape = t_scene.instantiate() as Shape
			t_shape.block_color = shape_color
			t_shape.position = pos
			$Shapes.add_child(t_shape)
			return t_shape
			
		Enums.BlockShape.O:
			var o_shape = o_scene.instantiate() as Shape
			o_shape.block_color = shape_color
			o_shape.position = pos
			$Shapes.add_child(o_shape)
			return o_shape
			
		Enums.BlockShape.Z:
			var z_shape = z_scene.instantiate() as Shape
			z_shape.block_color = shape_color
			z_shape.position = pos
			$Shapes.add_child(z_shape)
			return z_shape
			
		Enums.BlockShape.S:
			var s_shape = s_scene.instantiate() as Shape
			s_shape.block_color = shape_color
			s_shape.position = pos
			$Shapes.add_child(s_shape)
			return s_shape
			
		Enums.BlockShape.L:
			var l_shape = l_scene.instantiate() as Shape
			l_shape.block_color = shape_color
			l_shape.position = pos
			$Shapes.add_child(l_shape)
			return l_shape
			
		Enums.BlockShape.J:
			var j_shape = j_scene.instantiate() as Shape
			j_shape.block_color = shape_color
			j_shape.position = pos
			$Shapes.add_child(j_shape)
			return j_shape
		
		_:
			return

## Moves all the blocks after set interval passes
func _on_world_timer_timeout() -> void:
	var shapes = $Shapes.get_children()
	for shape in shapes:
		shape.fall()
