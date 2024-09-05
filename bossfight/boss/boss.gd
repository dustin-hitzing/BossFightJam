extends Node2D
class_name Boss

@export var lightning_attack: PackedScene
@export var boss_speed: float = 1000

enum BossMove {
	IDLE,
	SYRINGE,
	MOVE,
	LIGHTNING,
}

var move_list : Array[BossMove] = [BossMove.IDLE, BossMove.SYRINGE, BossMove.MOVE, BossMove.LIGHTNING]

var current_move : BossMove = BossMove.IDLE
var boss_nodes : Array[Node2D]

func _ready() -> void:
	var temp_boss_nodes = get_tree().get_nodes_in_group("boss_node")
	for node in temp_boss_nodes:
		if node is Node2D:
			boss_nodes.append(node)
	pass


func _process(delta: float) -> void:
	match (current_move):
		BossMove.IDLE:
			await get_tree().create_timer(2).timeout
			current_move = move_list.pick_random()
			pass
		BossMove.SYRINGE:
			perform_lightning_attack()
			current_move = BossMove.IDLE
			pass
		BossMove.MOVE:
			move_to_a_boss_node(delta)
			current_move = BossMove.IDLE
			pass
		BossMove.LIGHTNING:
			perform_lightning_attack()
			current_move = BossMove.IDLE
			pass

	pass


func perform_lightning_attack() -> void:
	var la_instance = lightning_attack.instantiate()
	la_instance.global_position = global_position
	get_tree().current_scene.add_child(la_instance)
	la_instance.attack()
	pass


func move_to_a_boss_node(delta: float) -> void:
	var move_to_node = boss_nodes.pick_random()
	global_position = global_position.move_toward(move_to_node.global_position, boss_speed * delta)
	pass
