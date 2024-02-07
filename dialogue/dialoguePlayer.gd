extends CanvasLayer

#@export  var d_file = (String, FILE, "*.json")
@export_file("*.json") var d_file : String
#@export(String, FILE, "*.json") var d_file : String
@export_file var File
var dialogue = [] 

func _ready():
	start()

func start():
	dialogue = load_dialogue()
	
	$NinePatchRect/Name.text = dialogue[0]['name']
	$NinePatchRect/Text.text = dialogue[0]['text']

func load_dialogue():
	var file = File.new()
	if file.file_exists(d_file):
		file.open(d_file,file.READ)
		return parse_json(file.get_as_text)
