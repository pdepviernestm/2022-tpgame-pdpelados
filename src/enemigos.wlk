import wollok.game.*
import hud.*
import sonidos.*
import juego.*
import niveles.*
import visuales.*

class NaveEnemiga{
	var property position
	var property image
	var property estaVivo = true
	method morir(){
		image = "explosion.png"
		estaVivo = false
		puntaje.matarAUnEnemigo()
		soundProgram.reproducirSonido("enemyDeathSound.mp3")
		game.schedule(500,{game.removeVisual(self)})
		juego.seMurio(self)
	}
	method colocarseEnPosicion(){
		position = self.position().down(1)
	}
	method alinearse(){
		game.schedule(625,{self.colocarseEnPosicion()})
		game.schedule(1250,{self.colocarseEnPosicion()})
		game.schedule(1875,{self.colocarseEnPosicion()})
		game.schedule(2500,{self.colocarseEnPosicion()})
	}
}

class NaveAzul inherits NaveEnemiga{
	var tiempoDeDisparo
	method iniciar(){
		self.alinearse()
		game.schedule(3000,{
			game.onCollideDo(self,{disparo => game.removeVisual(disparo) self.morir()})
			game.onTick(tiempoDeDisparo,"disparoEnemigo",{self.disparar()})
		})
	}
	method disparar(){
		if(self.estaVivo())
			new DisparoEnemigo(position = self.position().down(1)).disparoDelEnemigo()
	}
	method aparicionPorAgujeroNegro(){
		const agujeroNegro = new AgujeroNegro(position = self.position())
		game.schedule(1000,{game.addVisual(agujeroNegro)})
		game.schedule(2000,{game.removeVisual(agujeroNegro)})
	}
}

class NaveRoja inherits NaveAzul{
	override method iniciar(){
		self.alinearse()
		game.schedule(3000,{
			game.onCollideDo(self,{disparo => game.removeVisual(disparo) self.morir()})
			game.onTick(tiempoDeDisparo,"disparoEnemigo",{self.disparar()})
			game.onTick(15000,"escudoEnemigo",{self.protegerse()})
		})
	}
	override method disparar(){
		if(self.estaVivo())
			new DisparoEnemigo(image = "disparoRojo.png",position = self.position().down(1)).disparoDelEnemigo()
	}
	method protegerse(){
		if(self.estaVivo()){
			const escudo = new Escudo(position = self.position().down(1))
			escudo.escudarse()
			game.onCollideDo(escudo,{disparo => game.removeVisual(disparo)})
		}
	}
}

class NaveAmarilla inherits NaveAzul{
	override method iniciar(){
		self.alinearse()
		game.onCollideDo(self,{disparo => game.removeVisual(disparo) self.morir()})
		game.onTick(tiempoDeDisparo,"disparoEnemigo",{self.disparar()})
		game.onTick(15000,"teletransportarse",{self.teletransportarse()})
	}
	override method disparar(){
		if(self.estaVivo())
			new DisparoEnemigo(image = "disparoAmarillo.png" ,position = self.position().down(1)).disparoDelEnemigo()
	}
	method teletransportarse(){
		if(self.position().x()>game.width()/2)
			position = self.position().left(4)
		else position = self.position().right(4)
	}
}

class NaveSuprema inherits NaveAzul{
	override method iniciar(){
		self.aparecer()
		game.onCollideDo(self,{disparo => game.removeVisual(disparo) self.morir()})
		game.onTick(tiempoDeDisparo,"disparoEnemigoEnMovimiento",{self.movimiento() game.schedule(350,{self.disparar()})})
		game.onTick(15000,"lluviaDeMeteoritos",{self.iniciarLluviaDeMeteoritos()})
	}
	override method disparar(){
		if(self.estaVivo())
			new DisparoEnemigo(image = "disparoVioleta.png" ,position = self.position().down(1)).disparoDelEnemigo()
	}
	method iniciarLluviaDeMeteoritos(){
		if(self.estaVivo()){
			const rayoGeneradorDeMeteoritos = new Rayo()
			const meteorito1 = new DisparoEnemigo(image = "meteorito.png",position = game.at(3,5))
			const meteorito2 = new DisparoEnemigo(image = "meteorito.png",position = game.at(6,5))
			const meteorito3 = new DisparoEnemigo(image = "meteorito.png",position = game.at(9,5))
			const meteorito4 = new DisparoEnemigo(image = "meteorito.png",position = game.at(12,5))
			game.addVisual(rayoGeneradorDeMeteoritos)
			game.schedule(1000,{
				game.removeVisual(rayoGeneradorDeMeteoritos)
				meteorito1.disparoDelEnemigo()
				meteorito2.disparoDelEnemigo()
				meteorito3.disparoDelEnemigo()
				meteorito4.disparoDelEnemigo()
			})
		}
	}
	method aparecer(){
		game.schedule(150,{position = self.position().right(1)})
	}
	
	method movimiento(){
		if(self.position().y() > 6){
			position = self.position().right(1)
			game.schedule(300,{position = self.position().down(1)})
			if(self.position().x() == 17){
				position = game.at(-2,10)
				self.aparecer()
			}
		}
		else if(self.position().y() == 6){
			position = self.position().up(1)
			game.schedule(200,{position = self.position().up(1)})
			game.schedule(400,{position = self.position().up(1)})
			game.schedule(600,{position = self.position().up(1)})
			if(self.position().x() == 13){
				position = game.at(-2,10)
				self.aparecer()
			}
		}
	}
}

class DisparoEnemigo{	
	var property image = "disparoAzul.png"
	var property position
	method disparoDelEnemigo(){
		game.addVisual(self)
		game.onTick(velocidad, "disparoEnemigo", {self.desplazarsePorElMapa()})
	}
	method desplazarsePorElMapa(){ position = self.position().down(1) }
	method chocar(){
		game.removeVisual(self)
		nave.morir()
	}
	method frenar(){
		game.removeVisual(self)
	}
}

class Escudo{
	var property image = "escudo.png"
	var property position
	method escudarse(){
		game.addVisual(self)
		game.schedule(10000,{game.removeVisual(self)})
	}
}