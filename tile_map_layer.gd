extends Node2D

# Number of buffers
var buffer_count = 5

# Screen width and height (adjust based on your game window or camera size)
var screen_width = 1920
var screen_height = 1080

# TileMap buffer list
var buffers = []

# Reference to the camera (or player) to track its position
var camera_position = Vector2()

# Position of each TileMap chunk in the world
var buffer_positions = []

# Your TileSet resource (adjust the path to your TileSet)
var tile_set : TileSet

func _ready():
	# Load your tileset (replace with the actual path to your TileSet resource)
	tile_set = preload("res://Assets/railroad_builder.tres")
	
	# Create multiple TileMap buffers (5 buffers)
	for i in range(buffer_count):
		var buffer = TileMapLayer.new()
		buffers.append(buffer)
		add_child(buffer)
		buffer_positions.append(Vector2(i * screen_width, 0))  # Position buffers horizontally

		# Assign the TileSet to the buffer
		buffer.tile_set = tile_set
		print($".".cell_size)
		# Set the cell size (this is the grid size in pixels, should match your tile's size)
		buffer.cell_size = Vector2(16, 16)  # Set the tile size to match your tiles (e.g., 64x64)

		# Set the initial position of each buffer
		buffer.position = buffer_positions[i]

		# Optionally, set up the TileMap (adding tiles, if necessary)
		# Example: buffer.set_cell(0, 0, 0) for placing a tile in the first position

func _process(delta):
	# Get the camera position (or player position if using player movement)
	camera_position = get_viewport().get_camera().position

	# Loop through each buffer to update their position based on the camera
	for i in range(buffer_count):
		var buffer = buffers[i]
		var buffer_pos = buffer_positions[i]

		# Check if the camera has moved past the current buffer on the X axis
		if camera_position.x > buffer_pos.x + screen_width:
			# Move this buffer to the right side
			buffer_positions[i].x += screen_width * buffer_count
			buffer.position = buffer_positions[i]

		if camera_position.x < buffer_pos.x:
			# Move this buffer to the left side
			buffer_positions[i].x -= screen_width * buffer_count
			buffer.position = buffer_positions[i]

		# Optionally, apply similar logic for vertical scrolling (Y axis)
		if camera_position.y > buffer_pos.y + screen_height:
			buffer_positions[i].y += screen_height * buffer_count
			buffer.position = buffer_positions[i]

		if camera_position.y < buffer_pos.y:
			buffer_positions[i].y -= screen_height * buffer_count
			buffer.position = buffer_positions[i]

		# Optionally, trigger an update if the changes are not automatically reflected
		buffer.queue_redraw()
