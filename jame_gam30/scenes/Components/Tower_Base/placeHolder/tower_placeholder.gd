extends StaticBody3D


@export var material_blue : Material
@export var material_red : Material

@export var tower_parts :Array[MeshInstance3D]
@onready var range_indicator:Node3D =$Range_Indicator
var state :int = 0 # 0 is Blue - 1 is Red
func _ready():
	# START ANIMATION FOR RANGE INDICATOR
	range_indicator.range_placeholder_spawn()

func set_material_red():
	if state != 1:
		state =1 
		for x in tower_parts:
			x.set_surface_override_material(0,material_red)

func set_material_blue():
	if state != 0:
		state = 0
		for x in tower_parts:
			x.set_surface_override_material(0,material_blue)
			
