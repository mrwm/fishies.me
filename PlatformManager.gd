extends Node2D

# I guess this will be where other things will be
var border_limits = Vector2()
var fish_eaten
var textContainer
var text2Change
var elapsed_seconds = 0
var delay_seconds = 3
var fishFood

func _ready():
  # Prep the fish food
  fishFood = get_tree().get_root().get_node("World/Fish")
  fishFood.connect("eaten_signal", self, "set_fish_eaten")
  fish_eaten = 0

  # Prep the window border size
  get_tree().get_root().connect("size_changed", self, "windowResize")

  # Prep the text container
  textContainer = get_tree().get_root().get_node("World/TextContainer")
  center_textbox()
  print("PlatformManager is ready")

func _process(delta):
  elapsed_seconds += delta
  if elapsed_seconds > delay_seconds:
    var fishMob = load("res://Fish.tscn").instance()
    add_child(fishMob)
    elapsed_seconds = 0
    delay_seconds = rand_num(1,3)

func set_fish_eaten(num):
  fish_eaten += num
  center_textbox()

func windowResize():
  border_limits = get_parent().get_viewport_rect().size

  # Set the new size, but keep height value
  var currentSize = textContainer.get_size()
  textContainer.set_size(Vector2(border_limits.x,currentSize.y))
  #print("Resizing: ", get_viewport_rect().size.x, get_viewport_rect().size.y)

func center_textbox():
  # Set text according to number of eaten fish
  var textChange = get_tree().get_root().get_node("World/TextContainer/CenterContainer/AmountEaten")
  text2Change = "You've eaten " + str(fish_eaten) + " fishies"
  if fish_eaten == 1:
    text2Change = "You've eaten " + str(fish_eaten) + " fishie"
  textChange.set_text(text2Change)

func rand_num(begin, end):
  randomize()
  return int(rand_range(begin, end))