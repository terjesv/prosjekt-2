extends TileMap

var isGettingBrighter
var modulateNumber

func _ready():
	isGettingBrighter = true
	modulateNumber = 0.6
	pass

func _process(delta):
	if isGettingBrighter:
		modulateNumber += 0.005
	else:
		modulateNumber -= 0.005
		
	if modulateNumber >= 0.9:
		isGettingBrighter = false
	elif modulateNumber <= 0.6:
		isGettingBrighter = true
		
	self.modulate = Color(modulateNumber,modulateNumber,modulateNumber)
	
