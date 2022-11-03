import wollok.game.*

object movimiento {
	method configurarFlechas(visual){
		keyboard.left().onPressDo{self.mover(izquierda,visual)}
		keyboard.right().onPressDo{self.mover(derecha,visual)}
   }
	method mover(direccion,personaje){
		personaje.position(direccion.siguiente(personaje.position()))
	}
}

object izquierda { 
	method siguiente(position) = position.left(1) 
	method opuesto() = derecha
}

object derecha { 
	method siguiente(position) = position.right(1) 
	method opuesto() = izquierda
}