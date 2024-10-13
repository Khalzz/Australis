extends Area2D

var touching = false
var touching_counter = 0
var climbing_pos
var top_max
var bottom_max

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if touching:
		if climbing_pos:
			$"../..".climbing_pos = climbing_pos
			$"../ClimbingPos".global_position = climbing_pos
		if top_max:
			$"../Top".global_position = top_max
		if bottom_max:
			$"../Bottom".global_position = bottom_max

func check_top_and_bottom(base_tile_coords: Vector2, tilemap: TileMapLayer):
	var top_pos: Vector2
	var bottom_pos: Vector2
	var moded_tile = base_tile_coords

	while true:
		moded_tile.y -= 1  
		var tile_data = tilemap.get_cell_tile_data(moded_tile)

		if tile_data == null or tile_data.get_custom_data("ice") != 1:
			break

		top_pos = tilemap.to_global(tilemap.map_to_local(moded_tile))
		
	moded_tile = base_tile_coords

	while true:
		moded_tile.y += 1  
		var tile_data = tilemap.get_cell_tile_data(moded_tile)

		if tile_data == null or tile_data.get_custom_data("ice") != 1:
			break

		bottom_pos = tilemap.to_global(tilemap.map_to_local(moded_tile))

	if top_pos:
		top_max = top_pos
		
	if bottom_pos:
		bottom_max = bottom_pos

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int):
	# Increment the touching counter
	touching_counter += 1
	touching = true
	
	var tile_coords = body.get_coords_for_body_rid(body_rid)
	var tile_data = body.get_cell_tile_data(tile_coords)
	check_top_and_bottom(tile_coords, body)
	climbing_pos = body.to_global(body.map_to_local(tile_coords))

func _on_body_shape_exited(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int):
	# Decrement the touching counter
	touching_counter -= 1
	
	# Ensure touching is only false if the player is not touching any tile
	if touching_counter <= 0:
		touching = false
		touching_counter = 0  # Prevent the counter from going negative
