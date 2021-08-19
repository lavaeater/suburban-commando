extends Spatial  # or whatever object type it's attached to

# Preloads script to be attached

func _ready():  # Runs when scene is initialized
	# STEP 1: add a cube to the scene
		# Step 1.1, create a Physics body.
		# I'm using a static body but this can be any
		# other type of Physics Body
	var cube = StaticBody.new()
	cube.transform.origin = Vector3(0, 0, 0)  # change initial pos here

	# STEP 3: attach script
		# It is actually required to have the script
		# attached before a node is defined as a child node
		# to the parent. So your step 3 goes here
	#cube.set_script(my_script)

	self.add_child(cube)  # Add as a child node to self
		# Step 1.2, add a collision shape to the
		# Physics body, defining its shape to a Box (cube)
	var coll = CollisionShape.new()
	coll.shape = BoxShape.new()
	cube.add_child(coll)  # Add as a child node to cube
		# Step 1.3, add a mesh, so that it's visible
	var mesh = MeshInstance.new()
	mesh.mesh = CubeMesh.new()
	cube.add_child(mesh)  # Add as a child to cube

	# STEP 2: change texture
		# Step 2.1, load your texture from pc
#	var new_texture = ImageTexture.new()
#	new_texture.load("res://path/to/new_texture.png")
		# Step 2.2, get material from cube
#	var cube_material = mesh.get_surface_material(0)
#		# Step 2.3, change texture from material to your new texture
#	cube_material.albedo_texture = new_texture
