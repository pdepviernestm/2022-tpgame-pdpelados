import wollok.game.*
import visuales.*

object puntaje{
	var property primeraCifra
	var property segundaCifra
	var property terceraCifra
	var property cuartaCifra
	var property puntaje = 0
	const property blanco = "FFFFFFF"
	method matarAUnEnemigo() {
		puntaje += 50
	}
	method pasarDeNivel() {
		puntaje += 1000
	}
	method perderPuntosAlMorir(){
		puntaje -= 100
	}
	method position() = game.at(game.width()-1,game.height()-1)
	method text() = puntaje.toString()
	method textColor() = blanco
	method finalScore(){
		if(puntaje <= 0){
			game.addVisual(score)
			primeraCifra = 0
			segundaCifra = 0
			terceraCifra = 0
			cuartaCifra = 0
			game.addVisual(primeraCifraDelPuntaje)
			game.addVisual(segundaCifraDelPuntaje)
			game.addVisual(terceraCifraDelPuntaje)
			game.addVisual(cuartaCifraDelPuntaje)
		}
		else{
			game.addVisual(score)
			game.addVisual(primeraCifraDelPuntaje)
			game.addVisual(segundaCifraDelPuntaje)
			game.addVisual(terceraCifraDelPuntaje)
			game.addVisual(cuartaCifraDelPuntaje)
		}
	}
	method calculoDePrimeraCifra() = self.puntaje()%10
	method valorDePrimeraCifra(valor){ primeraCifra = valor }
	method calculoDeSegundaCifra() = (self.puntaje()%100 - self.puntaje()%10)/10
	method valorDeSegundaCifra(valor){ segundaCifra = valor }
	method calculoDeTerceraCifra() = (self.puntaje()%1000 - self.puntaje()%100)/100
	method valorDeTerceraCifra(valor){ terceraCifra = valor }
	method calculoDeCuartaCifra() = (self.puntaje()%10000 - self.puntaje()%1000)/1000
	method valorDeCuartaCifra(valor){ cuartaCifra = valor }
}