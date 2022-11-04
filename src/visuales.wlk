import wollok.game.*
import movimientos.*
import juego.*
import hud.*

object fondo{
	method position() = game.at(-1,-1)
	method image() = "fondo.png"
}

object startGame{
	method position() = game.at(3,4)
	method image() = "startGame.png"
}

object startButton{
	method position() = game.at(3,4)
	method image() = "startButton.png"
}

object gameOver{
	method position() = game.at(3,2)
	method image() = "gameOver.png"
}

object youWon{
	var property image = "youWon.png"
	method position() = game.at(3,2)
	method efectoVictoria(imagen){
		game.removeVisual(self)
		image = imagen
		game.addVisual(self)
	}
}

object leaveTheGame{
	method position() = game.at(3,2)
	method image() = "leaveTheGame.png"
}

object score{
	method position() = game.at(5,7)
	method image() = "score.png"
}

object nivel{
	method position() = game.at(5,7)
	method image() = "level.png"
}

class Numero{
	var property image
	var property position = game.at(7,5)
}

const numero1 = new Numero(image = "1.png")
const numero2 = new Numero(image = "2.png")
const numero3 = new Numero(image = "3.png")
const numero4 = new Numero(image = "4.png")
const numero5 = new Numero(image = "5.png")

const primeraCifraDelPuntaje = new Numero(image = puntaje.primeraCifra().toString() + ".png", position = game.at(10,5))
const segundaCifraDelPuntaje = new Numero(image = puntaje.segundaCifra().toString() + ".png", position = game.at(8,5))
const terceraCifraDelPuntaje = new Numero(image = puntaje.terceraCifra().toString() + ".png", position = game.at(6,5))
const cuartaCifraDelPuntaje = new Numero(image = puntaje.cuartaCifra().toString() + ".png", position = game.at(4,5))

class AgujeroNegro{
	var property position
	method image() = "agujeroNegro.png"
}

class Rayo{
	var property position = game.at(0,5)
	var property image = "rayo.png"
}

object muroDerecha{
	var property position = game.at(game.width(),0)
	method chocar(){
		movimiento.mover(izquierda,nave)
	}	
}

object muroIzquierda{
	var property position = game.at(-1,0)
	method chocar(){
		movimiento.mover(derecha,nave)
	}
}