import wollok.game.*

object soundProgram{
	var property sonido
	method reproducirMusicaDeInicio(){
		sonido = game.sound("gameStartSound.mp3")
		game.schedule(500, {sonido.play()})
	}
	method reproducirSonido(audio){
		sonido = game.sound(audio)
		sonido.play()
	}
}