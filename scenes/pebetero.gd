# pebetero.gd
# Adjunto al nodo RigidBody2D 'Pebetero'
extends RigidBody2D

# Referencias a los nodos hijos
@onready var animated_sprite = $AnimatedSprite2D 
@onready var collision_shape = $CollisionShape2D 

# Bandera para controlar el estado
var esta_encendido = false 

func _ready():
	# 1. Configuración de RigidBody2D para Godot 4.5.x:
	
	# Habilitamos el monitoreo de contactos (OBLIGATORIO)
	set_contact_monitor(true)
	
	# Establecemos el cuerpo como congelado/estático al inicio (la sintaxis directa)
	# ¡ESTA LÍNEA CORRIGE EL ERROR "set_freeze()"!
	freeze = true 
	
	# Bloqueamos la rotación para evitar movimientos extraños
	lock_rotation = true
	
	# 2. Inicializar la animación a "apagado" y asegurar que se muestra:
	
	# Esto asegura que la animación "apagado" sea la que se vea.
	animated_sprite.set_animation("apagado")
	animated_sprite.stop() 
	
	# 3. Conectamos la señal de colisión (body_entered)
	body_entered.connect(_on_body_entered)


# Función que se ejecuta cuando el Jugador (CharacterBody2D) entra en contacto
func _on_body_entered(body: Node2D):
	if body.name == "CharacterBody2D" and not esta_encendido:
		
		# A) Cambiar la animación a "encendido"
		animated_sprite.play("encendido")
		esta_encendido = true
		
		# B) Desactivar la colisión para evitar repeticiones
		collision_shape.disabled = true
		
		# C) Finalizar el juego
		print("Pebetero encendido. ¡Juego Terminado!")
