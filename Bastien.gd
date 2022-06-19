extends CSGMesh3D

@onready var baba = preload('res://assets/models/RPG_ITENS_V.1/OBJ/Antidote.obj')
@onready var hehe = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("change_object"):
		hehe.mesh = baba
