extends ColorRect

const hpColors:Array = [Color8(222,0,0),Color8(255,131,0),Color8(148,205,0),Color8(0,123,205),Color8(139,131,255)]

#第一层
var foreground_rect:Rect2;
#第一层颜色
var foreground_color;
#第二层
var background_rect:Rect2;
#
var background_color;


func _ready() -> void:
	pass


func showHPLayer():
	var currentHP = get_parent().currentHP;
	var singleLayerHP = get_parent().singleLayerHP;
	if currentHP == 0:
		foreground_rect = Rect2(0,0,0,rect_size.y);
		background_rect = Rect2(foreground_rect.size.x,0,rect_size.x - foreground_rect.size.x,rect_size.y);
		owner.get_node("hp_layer_num").visible = false;
	else:
		#首先计算出当前血量是第几层血
		var layerNum:int = currentHP / singleLayerHP;
		#无法整除的情况下多加1层
		if currentHP % singleLayerHP != 0:
			layerNum += 1;
		owner.get_node("hp_layer_num").text = "x " + str(layerNum);
		if layerNum > 1:
			owner.get_node("hp_layer_num").visible = true;
		else:
			owner.get_node("hp_layer_num").visible = false;
		#根据层数获取对应前景色
		var foregroundColorIndex:int = (layerNum % hpColors.size()) - 1;
		if foregroundColorIndex == -1:
			foregroundColorIndex = hpColors.size() - 1;
		foreground_color = hpColors[foregroundColorIndex];
		if layerNum  == 1:
			background_color = Color.black;
		else:
			var backgroundColorIndex:int = 0;
			if foregroundColorIndex != 0:
				backgroundColorIndex = foregroundColorIndex - 1;
			else:
				backgroundColorIndex = hpColors.size() - 1;
			background_color = hpColors[backgroundColorIndex];
			
		
		var length:float = 1.0 * (currentHP % singleLayerHP) / singleLayerHP;
		if length == 0:
			length = 1;
		foreground_rect = Rect2(0,0,rect_size.x * length,rect_size.y);
		background_rect = Rect2(foreground_rect.size.x,0,rect_size.x - foreground_rect.size.x,rect_size.y);
	update();

func _draw() -> void:
	draw_rect(foreground_rect,foreground_color);
	draw_rect(background_rect,background_color);
#	draw_texture_rect(ts_red,rect1,true)
#	draw_texture_rect(ts_purple,rect2,true)
