# pebetero.gd
# Adjunto al nodo RigidBody2D 'Pebetero'
extends RigidBody2D

# Referencias a los nodos hijos
@onready var animated_sprite = $AnimatedSprite2D 
@onready var collision_shape = $CollisionShape2D 

# Bandera para controlar el estado
var esta_encendido = false 

func _ready():
	# 1. Configuración de RigidBody2D para Godot 4.x:
	
	# Habilitamos el monitoreo de contactos (OBLIGATORIO)
	set_contact_monitor(true)
	
	# Congelamos el cuerpo para que se comporte como estático al inicio
	freeze = true 
	
	# Bloqueamos la rotación para evitar movimientos extraños
	lock_rotation = true
	
	# 2. Inicializar la animación a "apagado" y asegurar que se muestra:
	animated_sprite.set_animation("apagado")
	animated_sprite.stop() 

# Función que se ejecuta cuando el Player (CharacterBody2D) entra en contacto
func _on_body_entered(body: Node2D):
	# Verificamos si el cuerpo que ha colisionado es el Jugador 
	if body.name == "CharacterBody2D" and not esta_encendido:
		
		# A) Cambiar la animación a "encendido"
		animated_sprite.play("encendido")
		esta_encendido = true
		
		# B) Desactivar la colisión para evitar repeticiones
		collision_shape.disabled = true
		
		# Opcional: Imprimir un mensaje de confirmación
		print("Pebetero encendido.") 
		
		# Lógica de finalización del juego (Ignorada según tu petición)
