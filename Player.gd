extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const ACCELERATION = 10

var motion = Vector2()
var oldMousePos = Vector2()
func _ready():
  # Called when the node is added to the scene for the first time.
  # Initialization here
  oldMousePos = get_local_mouse_position()
  print("Player is ready")
  #pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func _physics_process(delta):
  #motion = get_viewport().get_mouse_position()
  #print(motion)
  movement_loop(delta)
  pass

func movement_loop(input):
  var mousePos = get_local_mouse_position()
  $CollisionShape2D.position = $CollisionShape2D.position.linear_interpolate(mousePos, input * ACCELERATION)
  if oldMousePos.x > mousePos.x:
    #print("left")
    $CollisionShape2D/Sprite.flip_h = false
  elif oldMousePos.x < mousePos.x:
    #print("right")
    $CollisionShape2D/Sprite.flip_h = true
  if oldMousePos.y > mousePos.y:
    #print("up")
    pass
  elif oldMousePos.y < mousePos.y:
    #print("down")
    pass
  oldMousePos = get_local_mouse_position()