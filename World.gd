extends Node2D

var toggleMaximized = false

func _ready():
  #OS.set_window_maximized(true)
  print("World is ready")
  #pass

func _process(delta):
  # Called every frame. Delta is time since last frame.
  # Update game logic here.
  pass

func _input(event):
  if event.is_action_pressed("toggle_fullscreen"):
    OS.set_window_maximized(!toggleMaximized)
    toggleMaximized = !toggleMaximized
  if event.is_action_pressed("ui_cancel"):
    get_tree().quit()