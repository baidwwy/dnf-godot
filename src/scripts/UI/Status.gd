extends Control

onready var roleBtn:Button = $roleBtn;
onready var hp:Label = $ScrollContainer/Control/hpItem/valueLabel;
onready var mp:Label = $ScrollContainer/Control/mpItem/valueLabel;
onready var STR:Label = $ScrollContainer/Control/STRItem/valueLabel;
onready var WIS:Label = $ScrollContainer/Control/WISItem/valueLabel;
onready var VIT:Label = $ScrollContainer/Control/VITItem/valueLabel;
onready var MND:Label = $ScrollContainer/Control/MNDItem/valueLabel;
onready var physical_attack = $ScrollContainer/Control/physical_attackItem/valueLabel;
onready var magical_attack = $ScrollContainer/Control/magical_attackItem/valueLabel;
onready var physical_defense = $ScrollContainer/Control/physical_defenseItem/valueLabel;
onready var magical_defense = $ScrollContainer/Control/magical_defenseItem/valueLabel;
onready var physical_critical = $ScrollContainer/Control/physical_criticalItem/valueLabel;
onready var magical_critcal = $ScrollContainer/Control/magical_criticalItem/valueLabel;
onready var attack_speed = $ScrollContainer/Control/attack_speedItem/valueLabel;
onready var cast_speed = $ScrollContainer/Control/cast_speedItem/valueLabel;
onready var move_speed = $ScrollContainer/Control/move_speedItem/valueLabel;
onready var stuck = $ScrollContainer/Control/stuckItem/valueLabel;
onready var stuck_resistance = $ScrollContainer/Control/stuck_resistanceItem/valueLabel;
onready var hp_regen_speed = $ScrollContainer/Control/hp_regen_speedItem/valueLabel;
onready var mp_regen_speed = $ScrollContainer/Control/mp_regen_speedItem/valueLabel;
onready var immobility = $ScrollContainer/Control/immobilityItem/valueLabel;
onready var hit_recovery = $ScrollContainer/Control/hit_recoveryItem/valueLabel;
onready var fire_attack = $ScrollContainer/Control/fire_attackItem/valueLabel;
onready var fire_resistance = $ScrollContainer/Control/fire_resistanceItem/valueLabel;
onready var water_attack = $ScrollContainer/Control/water_attackItem/valueLabel;
onready var water_resistance = $ScrollContainer/Control/water_resistanceItem/valueLabel;
onready var light_attack = $ScrollContainer/Control/light_attackItem/valueLabel;
onready var light_resistance = $ScrollContainer/Control/light_resistanceItem/valueLabel;
onready var dark_attack = $ScrollContainer/Control/dark_attackItem/valueLabel;
onready var dark_resistance = $ScrollContainer/Control/dark_resistanceItem/valueLabel;


func _ready():
	roleBtn.pressed = true;
	initStatus();

func initStatus():
	var role:RoleData = DataManager.roleData;
	hp.text = str(role.hp) + "/" + str(role.max_hp);
	mp.text = str(role.mp) + "/" + str(role.max_mp);
	STR.text = "â–²â–¼ â†‘â†“í ½í¸€í ½í¸€í ½í¸€" + str(role.STR);
	WIS.text = "â–³" + str(role.WIS);
	VIT.text = str(role.VIT);
	MND.text = str(role.MND);
	physical_attack.text = str(role.physical_attack);
	magical_attack.text = str(role.magical_attack);
	physical_defense.text = str(role.physical_defense);
	magical_defense.text = str(role.magical_defense);
	physical_critical.text = "%*.*f%%" % [7,1,role.physical_critical];
	magical_critcal.text = "%*.*f%%" % [7,1,role.magical_critical];
	attack_speed.text = "%*.*f%%" % [7,1,role.attack_speed];
	cast_speed.text = "%*.*f%%" % [7,1,role.cast_speed];
	move_speed.text = "%*.*f%%" % [7,1,role.move_speed];
	stuck.text = "%*.*f%%" % [7,1,role.stuck];
	stuck_resistance.text = "%*.*f%%" % [7,1,role.stuck_resistance];
	hp_regen_speed.text = str(role.hp_regen_speed);
	mp_regen_speed.text = str(role.mp_regen_speed);
	immobility.text = str(role.immobility);
	hit_recovery.text = str(role.hit_recovery);
	fire_attack.text = str(role.fire_attack);
	fire_resistance.text = str(role.fire_resistance);
	water_attack.text = str(role.water_attack);
	water_resistance.text = str(role.water_resistance);
	light_attack.text = str(role.light_attack);
	light_resistance.text = str(role.lightning_resistance);
	dark_attack.text = str(role.dark_attack);
	dark_resistance.text = str(role.dark_resistance);
	


func _on_closeBtn_pressed():
	GlobalManager.main._on_open_status();


func _on_Status_visibility_changed():
	$windowSound.play();
