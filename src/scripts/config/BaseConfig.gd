#数据
var data:Array = [];

func load_json(file_add:String):
	var file = File.new();
	file.open(file_add,File.READ);
#	var json_data:JSONParseResult = JSON.parse(file.get_as_text());
	var temp = file.get_as_text();
	data = parse_json(temp);
	file.close();
