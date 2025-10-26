class Nave {
	var property velocidad = 0
	const valorDePropulsion = 20000
	const valorDeDespeque = 15000
	const velocidadMaxima = 300000


	method propulsarNave(){
		if(velocidad + valorDePropulsion > 300000){
			velocidad = 300000
		}else{
			velocidad += valorDePropulsion
		}
	}

	method prepararParaViaje(){
		if(velocidad + valorDeDespeque >  velocidadMaxima){
			velocidad = velocidadMaxima
		}else{
			velocidad += valorDeDespeque
		}
	}



}

/*--------------------------------------------------------------------------------
			 						NAVE DE CARGA
--------------------------------------------------------------------------------*/
class NaveDeCarga inherits Nave {
	var property carga = 0

	method sobrecargada() = carga > 100000

	method excedidaDeVelocidad() = velocidad > 100000 // el enunciado no dice la velocidad maxima ( puede variar adelante)

	method recibirAmenaza() {
		carga = 0
	}

	method encontrarseConEnemigo(){
		self.recibirAmenaza()
		self.propulsarNave()
	}


}
/*--------------------------------------------------------------------------------
			 						NAVE DE PASAJEROS
--------------------------------------------------------------------------------*/

class NaveDePasajeros inherits Nave {

	var property alarma = false
	const cantidadDePasajeros = 0
	
	method tripulacion() = cantidadDePasajeros + 4

	method velocidadMaximaLegal() = 300000 / self.tripulacion() - if (cantidadDePasajeros > 100) 200 else 0

	method estaEnPeligro() = velocidad > self.velocidadMaximaLegal() or alarma

	method recibirAmenaza() {
		alarma = true
	}
	method encontrarseConEnemigo(){
		self.recibirAmenaza()
		self.propulsarNave()
	}

}


/*--------------------------------------------------------------------------------
			 					NAVE DE COMBATE
--------------------------------------------------------------------------------*/
class NaveDeCombate inherits Nave {
	var property modo = reposo
	const property mensajesEmitidos = []

	method emitirMensaje(mensaje) {
		mensajesEmitidos.add(mensaje)
	}
	
	method ultimoMensaje() = mensajesEmitidos.last()

	method estaInvisible() = velocidad < 10000 and modo.invisible() // 

	method recibirAmenaza() {
		modo.recibirAmenaza(self)
	}

	method cambiarModo(){
		modo = modo.cambiarModo()
	}

	override method prepararParaViaje(){
		super()
		modo.prepararParaViaje(self)
	}

	method encontrarseConEnemigo(){
		self.recibirAmenaza()
		self.propulsarNave()
	}

}



/*--------------------------------------------------------------------------------
			 				NAVE DE RESIDUOS RADIOACTIVOS
--------------------------------------------------------------------------------*/
class NaveDeResiduosRadiactivos inherits NaveDeCarga {
	var property sellarAlVacio = false 


	override method recibirAmenaza(){
		velocidad = 0
	}
	override method prepararParaViaje() {
	  super()
	  sellarAlVacio = true
	}
}



object reposo {

	method invisible() = false// deberia ser true

	method recibirAmenaza(nave) {
		nave.emitirMensaje("¡RETIRADA!")
	}

// PREPARAR PARA DESPEGAR
	method prepararParaViaje(nave){
		nave.emitirMensaje("Saliendo en misión")
		nave.cambiarModo()
	}

	method cambiarModo(){
		return ataque
	}

}

object ataque {

	method invisible() = true

	method recibirAmenaza(nave) {
		nave.emitirMensaje("Enemigo encontrado")
	}

//PREPARAR PARA DESPEGAR
	method prepararParaViaje(nave){
		nave.emitirMensaje("Volviendo a la base")
	}

}

