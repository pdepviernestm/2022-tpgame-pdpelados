import wollok.game.*
import enemigos.*
import movimientos.*
import hud.*
import visuales.*
import sonidos.*
import niveles.*
import enemigosNivel1.*
import enemigosNivel2.*
import enemigosNivel3.*
import enemigosNivel4.*

const velocidad = 250
const corazon1 = new Corazon(position = game.at(0,game.height()-1))
const corazon2 = new Corazon(position = game.at(1,game.height()-1))
const corazon3 = new Corazon(position = game.at(2,game.height()-1))

object juego{
	var property nivelActual = nivel1
	method configurar(){
		game.width(17)
		game.height(12)
		game.title("Universe Battle")
		game.addVisual(fondo)
		game.addVisual(nave)
		game.addVisual(startGame)
		
		game.schedule(8500,{
			game.addVisual(startButton)
			keyboard.enter().onPressDo{game.removeVisual(startGame) game.removeVisual(startButton) nivel1.presentacion()}
		})
		soundProgram.reproducirMusicaDeInicio()
	}
	method iniciar(){
		nave.iniciar()
	}
	method jugar(){
		if(nave.vidasRestantes()>0){
			game.addVisual(muroDerecha)
			game.addVisual(muroIzquierda)
			game.addVisual(puntaje)
			nave.vidas().forEach{x => game.addVisual(x)}
			keyboard.right().onPressDo{movimiento.mover(derecha,nave)}
			keyboard.left().onPressDo{movimiento.mover(izquierda,nave)}
			keyboard.space().onPressDo{new Disparo().ejecutarUnDisparo()}
			nivelActual.comenzar()
			
			game.onCollideDo(nave,{x => x.chocar()})
		}
	}
	method seMurio(unEnemigo){
		nivelActual.seMurio(unEnemigo)
	}
	method cambiarNivel(nroDelNivel){ nivelActual = nroDelNivel }
	method finDelJuego(){
		game.clear()
		game.addVisual(fondo)
		game.addVisual(youWon)
		game.onTick(300,"cartelDeLaVictoria",{
			youWon.efectoVictoria("youWon2.png")
			game.schedule(150,{
				youWon.efectoVictoria("youWon.png")
			})
		})
		soundProgram.reproducirSonido("victorySound.mp3")
		puntaje.valorDePrimeraCifra(puntaje.calculoDePrimeraCifra())
		puntaje.valorDeSegundaCifra(puntaje.calculoDeSegundaCifra())
		puntaje.valorDeTerceraCifra(puntaje.calculoDeTerceraCifra())
		puntaje.valorDeCuartaCifra(puntaje.calculoDeCuartaCifra())
		game.schedule(11500,{game.removeTickEvent("cartelDeLaVictoria")})
		game.schedule(12000,{
			game.removeVisual(youWon)
			puntaje.finalScore()
			if(corazon1.lleno() && corazon2.lleno() && corazon3.lleno()) soundProgram.reproducirSonido("perfectScoreSound.mp3")
			else soundProgram.reproducirSonido("finalScoreSound.mp3")
			game.schedule(8000,{game.addVisual(leaveTheGame) keyboard.l().onPressDo{game.stop()}})
		})
	}
}

object nave{
	var property image = "nave.png"
	var property vidas = []
	var property position = game.at((game.width()/2),0)
	method iniciar(){ vidas = [corazon1,corazon2,corazon3] }
	method morir(){
		if(self.vidasRestantes() == 1){
			game.clear()
			game.addVisual(fondo)
			game.addVisual(gameOver)
			soundProgram.reproducirSonido("gameOverSound.mp3")
			puntaje.perderPuntosAlMorir()
			puntaje.valorDePrimeraCifra(puntaje.calculoDePrimeraCifra())
			puntaje.valorDeSegundaCifra(puntaje.calculoDeSegundaCifra())
			puntaje.valorDeTerceraCifra(puntaje.calculoDeTerceraCifra())
			puntaje.valorDeCuartaCifra(puntaje.calculoDeCuartaCifra())
			game.schedule(4500,{
				game.removeVisual(gameOver)
				puntaje.finalScore()
				soundProgram.reproducirSonido("finalScorePorDerrotaSound.mp3")
				game.schedule(3000,{game.addVisual(leaveTheGame) keyboard.l().onPressDo{game.stop()}})
			})
		}
		else{
			self.restarVida()
			image = "explosion.png"
			puntaje.perderPuntosAlMorir()
			soundProgram.reproducirSonido("deathSound.mp3")
			game.schedule(750,{image = "nave.png"})
		}
	}
	method revivir(){
		image = "nave.png"
	}
	method restarVida(){
		self.ultimoCorazonLleno().vaciarCorazon()		
	}
	method vidasRestantes() = vidas.filter({corazon => corazon.lleno()}).size()
	//Metodo que buscan corazones
	method ultimoCorazonLleno() = vidas.filter({corazon => corazon.image() == "corazonLleno.png"}).last()
}

class Disparo{
	var positionEjey = 1
	const positionEjex = nave.position().x()
	method position() = game.at(positionEjex,positionEjey)
	method image() = "disparos.png"
	method ejecutarUnDisparo(){
		game.addVisual(self)
		game.onTick(velocidad, "disparo", {self.desplazarsePorElMapa()})
		soundProgram.reproducirSonido("shootingSound.mp3")
	}
	method desplazarsePorElMapa(){ positionEjey += 1 }
}

class Corazon {
	var property image = "corazonLleno.png"
	var property position
	method lleno() = image == "corazonLleno.png"
	method vaciarCorazon(){
		image = "corazonVacio.png"
	}
}