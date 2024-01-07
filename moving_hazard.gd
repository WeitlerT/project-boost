extends AnimatableBody3D

@export var destination: Vector3
@export var duration: float = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Animating the box to move up and down
	var tween = create_tween()
	#Will loop the tween infinitely unless we set a paramater (amount of times to loop)
	tween.set_loops()
	#Makes the animation smoother not as robotic
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "global_position", global_position + destination, duration)
	tween.tween_property(self, "global_position", global_position, duration)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
