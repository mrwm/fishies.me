extends KinematicBody2D

var border_limits = Vector2()
var fish_location = Vector2()
var direction = Vector2(rand_num(4),rand_num(4))
var elapsed_seconds = 0
var delay_seconds = 3
var first_run = true
var fish_size

signal eaten_signal(num)

func _ready():
    # Called when the node is added to the scene for the first time.
    # Initialization here
    border_limits = get_viewport_rect().size
    get_tree().get_root().connect("size_changed", self, "windowResize")

    fish_location.x = rand_num(1)
    fish_location.y = rand_num(2)
    self.position = fish_location

    # Set a random size of fish (in terms of value)
    fish_size = rand_num(3)

    self.hide()
    print(self.get_name())

func _process(delta):
  elapsed_seconds += delta

  if not get_node("Sprite/Visible").is_on_screen():
    fish_location.x = rand_num(1)
    fish_location.y = rand_num(2)
    self.position = fish_location

  self.position += direction
  if self.position.x >= border_limits.x or self.position.x <= 0:
    direction.x = -(direction.x)
  if self.position.y >= border_limits.y or self.position.y <= 0:
    direction.y = -(direction.y)

  if direction.x > 0:
    $Sprite.flip_h = true
  else:
    $Sprite.flip_h = false

  # Change the directions + delay!
  if elapsed_seconds > delay_seconds:
    if first_run:
      first_run = false
      self.show()
    direction = Vector2(rand_num(4),rand_num(4))
    elapsed_seconds = 0
    delay_seconds = rand_num(3)

func windowResize():
  #print("Resizing: ", get_viewport_rect().size)
  #print("Resizing: ", get_viewport_rect().size.x, get_viewport_rect().size.y)
  border_limits = get_viewport_rect().size

func rand_num(location):
  match location:
    1: # Switch case for X
      randomize()
      return int(rand_range(0, border_limits.x))
    2: # Switch case for Y
      randomize()
      return int(rand_range(0, border_limits.y))
    3: # Switch case for delay
      randomize()
      return int(rand_range(1, 3))
    4: # Switch case for speed
      randomize()
      return int(rand_range(-15, 15))
    _:
      print("IT'S AN ERROR!!!")

func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
  #print(self.get_instance_id(),":",self.get_name())
  emit_signal("eaten_signal", fish_size)
  queue_free()
