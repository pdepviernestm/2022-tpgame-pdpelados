import wollok.game.*
import juego.*
import visuales.*
import enemigos.*
import hud.*
import sonidos.*
import enemigosNivel1.*
import enemigosNivel2.*
import enemigosNivel3.*
import enemigosNivel4.*

object invisible{}

class Nivel{
	method presentacion()
}

object nivel1 inherits Nivel{
	const primeraOleada = [enemigo1,enemigo2,enemigo3,enemigo4,enemigo5,enemigo6,enemigo7,enemigo8,enemigo9]
	const segundaOleada = [enemigo10,enemigo11,enemigo12,enemigo13,enemigo14,enemigo15,enemigo16,enemigo17,enemigo18]
	
	override method presentacion(){
		game.addVisual(nivel)
		game.addVisual(numero1)
		soundProgram.reproducirSonido("nextLevelSound.mp3")
		game.schedule(2000, {game.removeVisual(nivel) game.removeVisual(numero1) juego.jugar()})
	}
	method comenzar(){
		if(primeraOleada.size() != 0){
			primeraOleada.forEach{x => game.addVisual(x) x.iniciar()}
			soundProgram.reproducirSonido("enemyFlyingSound.mp3")
		}
		else{
			segundaOleada.forEach{x => game.addVisual(x) x.iniciar()}
			soundProgram.reproducirSonido("enemyFlyingSound.mp3")
		}
	}
	method seMurio(unEnemigo){
		primeraOleada.remove(unEnemigo)
		segundaOleada.remove(unEnemigo)
		if(self.noQuedanEnemigos(primeraOleada)){
			self.comenzar()
			primeraOleada.add(invisible)
		}
		if(self.noQuedanEnemigos(segundaOleada)){
			self.pasarAlSiguienteNivel()
		}
	}
	method noQuedanEnemigos(lista) = lista.isEmpty()
	method pasarAlSiguienteNivel(){
		juego.cambiarNivel(nivel2)
		puntaje.pasarDeNivel()
		nivel2.presentacion()
	}
}

object nivel2 inherits Nivel{
	const primeraOleada = [enemigo19,enemigo20,enemigo21,enemigo22,enemigo23,enemigo24,enemigo25,enemigo26,enemigo27]
	const segundaOleada = [enemigo28,enemigo29,enemigo30,enemigo31,enemigo32,enemigo33,enemigo34,enemigo35]
	const terceraOleada = [enemigo36,enemigo37,enemigo38,enemigo39,enemigo40]

	override method presentacion(){
		game.schedule(3000,{
			game.addVisual(nivel)
			game.addVisual(numero2)
			game.removeVisual(puntaje)
			nave.vidas().forEach{x => game.removeVisual(x)}
			soundProgram.reproducirSonido("nextLevelSound.mp3")
		})
		game.schedule(5000, {
			game.removeVisual(nivel)
			game.removeVisual(numero2)
			juego.nivelActual().comenzar()
			game.addVisual(puntaje)
			nave.vidas().forEach{x => game.addVisual(x)}
		})
	}
	method comenzar(){
		self.empezarAJugar(primeraOleada)
	}
	method empezarAJugar(oleada){
		if(oleada == primeraOleada){
			enemigo19.aparicionPorAgujeroNegro()
			enemigo20.aparicionPorAgujeroNegro()
			enemigo21.aparicionPorAgujeroNegro()
			enemigo22.aparicionPorAgujeroNegro()
			game.schedule(2000,{
				primeraOleada.forEach{x => game.addVisual(x) x.iniciar()}
			})
			game.schedule(2000,{soundProgram.reproducirSonido("enemyFlyingSound.mp3")})
		}
		else if(oleada == segundaOleada){
			enemigo30.aparicionPorAgujeroNegro()
			enemigo31.aparicionPorAgujeroNegro()
			enemigo32.aparicionPorAgujeroNegro()
			enemigo33.aparicionPorAgujeroNegro()
			enemigo35.aparicionPorAgujeroNegro()
			game.schedule(2000,{
				segundaOleada.forEach{x => game.addVisual(x) x.iniciar()}
			})
			game.schedule(2000,{soundProgram.reproducirSonido("enemyFlyingSound.mp3")})
		}
		else if(oleada == terceraOleada){
			enemigo36.aparicionPorAgujeroNegro()
			enemigo37.aparicionPorAgujeroNegro()
			enemigo38.aparicionPorAgujeroNegro()
			enemigo39.aparicionPorAgujeroNegro()
			enemigo40.aparicionPorAgujeroNegro()
			game.schedule(2000,{
				terceraOleada.forEach{x => game.addVisual(x) x.iniciar()}
			})
			game.schedule(2000,{soundProgram.reproducirSonido("enemyFlyingSound.mp3")})
		}
	}
	method seMurio(unEnemigo){
		primeraOleada.remove(unEnemigo)
		segundaOleada.remove(unEnemigo)
		terceraOleada.remove(unEnemigo)
		if(self.noQuedanEnemigos(primeraOleada)){
			self.empezarAJugar(segundaOleada)
			primeraOleada.add(invisible)
		}
		if(self.noQuedanEnemigos(segundaOleada)){
			self.empezarAJugar(terceraOleada)
			segundaOleada.add(invisible)
		}
		if(self.noQuedanEnemigos(terceraOleada)){
			self.pasarAlSiguienteNivel()
		}
	}
	method noQuedanEnemigos(lista) = lista.isEmpty()
	method pasarAlSiguienteNivel(){
		juego.cambiarNivel(nivel3)
		puntaje.pasarDeNivel()
		nivel3.presentacion()
	}
}

object nivel3 inherits Nivel{
	const primeraOleada = [enemigo41,enemigo42,enemigo43,enemigo44,enemigo45,enemigo46,enemigo47,enemigo48]
	const segundaOleada = [enemigo49,enemigo50,enemigo51,enemigo52,enemigo53,enemigo54,enemigo55,enemigo56]
	const terceraOleada = [enemigo57,enemigo58,enemigo59,enemigo60,enemigo61,enemigo62,enemigo63]
	
	override method presentacion(){
		game.schedule(3000,{
			game.addVisual(nivel)
			game.addVisual(numero3)
			game.removeVisual(puntaje)
			nave.vidas().forEach{x => game.removeVisual(x)}
			soundProgram.reproducirSonido("nextLevelSound.mp3")
		})
		game.schedule(5000,{
			game.removeVisual(nivel)
			game.removeVisual(numero3)
			juego.nivelActual().comenzar()
			game.addVisual(puntaje)
			nave.vidas().forEach{x => game.addVisual(x)}
		})
	}
	method comenzar(){
		self.empezarAJugar(primeraOleada)
	}
	method empezarAJugar(oleada){
		if(oleada == primeraOleada){
			enemigo43.aparicionPorAgujeroNegro()
			enemigo44.aparicionPorAgujeroNegro()
			enemigo45.aparicionPorAgujeroNegro()
			game.schedule(2000,{
				primeraOleada.forEach{x => game.addVisual(x) x.iniciar()}
			})
			game.schedule(2000,{soundProgram.reproducirSonido("enemyFlyingSound.mp3")})
		}
		else if(oleada == segundaOleada){
			enemigo49.aparicionPorAgujeroNegro()
			enemigo50.aparicionPorAgujeroNegro()
			enemigo51.aparicionPorAgujeroNegro()
			enemigo55.aparicionPorAgujeroNegro()
			game.schedule(2000,{
				segundaOleada.forEach{x => game.addVisual(x) x.iniciar()}
			})
			game.schedule(2000,{soundProgram.reproducirSonido("enemyFlyingSound.mp3")})
		}
		else if(oleada == terceraOleada){
			enemigo57.aparicionPorAgujeroNegro()
			enemigo63.aparicionPorAgujeroNegro()
			game.schedule(2000,{
				terceraOleada.forEach{x => game.addVisual(x) x.iniciar()}
			})
			game.schedule(2000,{soundProgram.reproducirSonido("enemyFlyingSound.mp3")})
		}
	}
	method seMurio(unEnemigo){
		primeraOleada.remove(unEnemigo)
		segundaOleada.remove(unEnemigo)
		terceraOleada.remove(unEnemigo)
		if(self.noQuedanEnemigos(primeraOleada)){
			self.empezarAJugar(segundaOleada)
			primeraOleada.add(invisible)
		}
		if(self.noQuedanEnemigos(segundaOleada)){
			self.empezarAJugar(terceraOleada)
			segundaOleada.add(invisible)
		}
		if(self.noQuedanEnemigos(terceraOleada)){
			self.pasarAlSiguienteNivel()
		}
	}
	method noQuedanEnemigos(lista) = lista.isEmpty()
	method pasarAlSiguienteNivel(){
		juego.cambiarNivel(nivel4)
		puntaje.pasarDeNivel()
		nivel4.presentacion()
	}
}

object nivel4 inherits Nivel{
	const primeraOleada = [enemigo64,enemigo65,enemigo66,enemigo67,enemigo68,enemigo69,enemigo70]
	const segundaOleada = [enemigo71,enemigo72,enemigo73,enemigo74,enemigo75,enemigo76,enemigo77]
	const terceraOleada = [enemigo78,enemigo79,enemigo80]
	
	override method presentacion(){
		game.schedule(3000,{
			game.addVisual(nivel)
			game.addVisual(numero4)
			game.removeVisual(puntaje)
			nave.vidas().forEach{x => game.removeVisual(x)}
			soundProgram.reproducirSonido("nextLevelSound.mp3")
		})
		game.schedule(5000,{
			game.removeVisual(nivel)
			game.removeVisual(numero4)
			juego.nivelActual().comenzar()
			game.addVisual(puntaje)
			nave.vidas().forEach{x => game.addVisual(x)}
		})
	}
	method comenzar(){
		self.empezarAJugar(primeraOleada)
	}
	method empezarAJugar(oleada){
		if(oleada == primeraOleada){
			enemigo64.aparicionPorAgujeroNegro()
			enemigo66.aparicionPorAgujeroNegro()
			enemigo67.aparicionPorAgujeroNegro()
			enemigo69.aparicionPorAgujeroNegro()
			game.schedule(2000,{
				primeraOleada.forEach{x => game.addVisual(x) x.iniciar()}
			})
			game.schedule(2000,{soundProgram.reproducirSonido("enemyFlyingSound.mp3")})
		}
		else if(oleada == segundaOleada){
			enemigo71.aparicionPorAgujeroNegro()
			enemigo72.aparicionPorAgujeroNegro()
			enemigo73.aparicionPorAgujeroNegro()
			game.schedule(2000,{
				game.addVisual(enemigo71) enemigo71.iniciar()
				game.addVisual(enemigo72) enemigo72.iniciar()
				game.addVisual(enemigo73) enemigo73.iniciar()
				game.schedule(2000,{game.addVisual(enemigo74) enemigo74.iniciar()})
				game.schedule(15000,{
					game.addVisual(enemigo75) enemigo75.iniciar()
					game.addVisual(enemigo76) enemigo76.iniciar()
				})
				game.schedule(20000,{game.addVisual(enemigo77) enemigo77.iniciar()})
			})
			game.schedule(2000,{soundProgram.reproducirSonido("enemyFlyingSound.mp3")})
		}
		else if(oleada == terceraOleada){
			game.schedule(2000,{
				game.addVisual(enemigo78) enemigo78.iniciar()
				game.schedule(8000,{game.addVisual(enemigo79) enemigo79.iniciar()})
				game.schedule(16000,{game.addVisual(enemigo80) enemigo80.iniciar()})
			})
		}
	}
	method seMurio(unEnemigo){
		primeraOleada.remove(unEnemigo)
		segundaOleada.remove(unEnemigo)
		terceraOleada.remove(unEnemigo)
		if(self.noQuedanEnemigos(primeraOleada)){
			self.empezarAJugar(segundaOleada)
			primeraOleada.add(invisible)
		}
		if(self.noQuedanEnemigos(segundaOleada)){
			self.empezarAJugar(terceraOleada)
			segundaOleada.add(invisible)
		}
		if(self.noQuedanEnemigos(terceraOleada)){
			self.final()
		}
	}
	method noQuedanEnemigos(lista) = lista.isEmpty()
	method final(){
		puntaje.pasarDeNivel()
		game.schedule(3000,{juego.finDelJuego()})
	}
}