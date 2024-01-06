extends RigidBody3D

##How much vertical force to apply when moving
@export_range(750.0, 3000.0) var thrust: float = 1000.0

@export var torque: float = 100

var is_transitioning: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * thrust)
		
#Rotating Left on left arrow
	if Input.is_action_pressed("rotate_left"):
		apply_torque(Vector3(0.0, 0.0, torque * delta))
		
#Rotating Right on right arrow
	if Input.is_action_pressed("rotate_right"):
		apply_torque(Vector3(0.0, 0.0, -torque * delta))


func _on_body_entered(body: Node) -> void:
	#print(body.name)
#Using "Goal" as a group for the landing pad
	if is_transitioning == false:
		if "Goal" in body.get_groups():
			complete_level(body.file_path)
		
		if "Hazard" in body.get_groups():
			crash_sequence()

func crash_sequence() -> void:
	print("KABOOM")
	set_process(false)
	is_transitioning = true
	var tween = create_tween()
	tween.tween_interval(1.0)
	tween.tween_callback(get_tree().reload_current_scene)

func complete_level(next_level_file: String) -> void:
	is_transitioning = true
	print("Complete")
	var tween = create_tween()
	tween.tween_interval(1.0)
	tween.tween_callback(get_tree().change_scene_to_file.bind(next_level_file))
