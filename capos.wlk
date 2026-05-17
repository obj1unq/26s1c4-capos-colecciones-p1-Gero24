import moradas.*
import enemigos.*

object rolando {
  const artefactosEnMochila = []
  var capacidadMaximaMochila = 2
  const artefactosEncontrados = []
  var property hogar =  castilloDePiedra
  var property poderBase = 5
  const enemigosDeErethia = #{caterina, archibaldo, astra}

  method enemigos() = enemigosDeErethia

  method historialDeEncuentros() = artefactosEncontrados

  method artefactosEnMochila() = artefactosEnMochila
  
  method establecerCapacidadMochila(capacidad) {
    capacidadMaximaMochila = capacidad
  }
  
  method encontrarseCon(artefacto) {
    artefactosEncontrados.add(artefacto)
    self.recolectar(artefacto)
  }

  method recolectar(artefacto) {
    if (self.hayEspacioEnMochila()) {
      artefactosEnMochila.add(artefacto)
    }
  }

  method hayEspacioEnMochila() = artefactosEnMochila.size() < capacidadMaximaMochila

  method llegarAlHogar() {
    hogar.guardarArtefactos(artefactosEnMochila)
    artefactosEnMochila.clear()
  }

  method posesiones() = hogar.artefactosGuardados() + artefactosEnMochila

  method poseeArtefacto(artefacto) = self.posesiones().contains(artefacto)

  method poderDePelea() = poderBase + artefactosEnMochila.sum({artefacto => artefacto.poderPara(self)})

  method batallar() {
    artefactosEnMochila.forEach({artefacto => artefacto.usarEnBatalla()})
    self.incrementarPoderBase()
  }

  method incrementarPoderBase() {
    poderBase = poderBase + 1
  }

  method poderDelArtefactoMasPoderosoEnElHogar() = hogar.poderDelArtefactoMasPoderoso(self)

  method puedeVencerA(unEnemigo) = unEnemigo.poderDePelea() < self.poderDePelea()

  method enemigosQuePuedoVencer() = enemigosDeErethia.filter({unEnemigo => self.puedeVencerA(unEnemigo)})

  method esPoderoso() = enemigosDeErethia.all({unEnemigo => self.puedeVencerA(unEnemigo)})

  method moradasConquistables() = self.enemigosQuePuedoVencer().map({enemigo => enemigo.morada()}).asSet()

  method esFatalPara(artefacto, unEnemigo) = artefacto.poderPara(self) > unEnemigo.poderDePelea()

  method tieneUnArtefactoFatalPara(unEnemigo) = artefactosEnMochila.any({artefacto => self.esFatalPara(artefacto, unEnemigo)})

  method artefactoFatalPara(unEnemigo) = artefactosEnMochila.find({artefacto => artefacto.poderPara(self) > unEnemigo.poderDePelea()})
  
}

object espadaDelDestino {
  var property batallas = 0
  
  method poderPara(unHeroe) {
    if (batallas == 0) {
      return unHeroe.poderBase()
    } else {
      return unHeroe.poderBase() / 2 
    }
  }

  method usarEnBatalla() {
    batallas = batallas + 1
  }
}

object collarDivino {
  var property batallas = 0

  method poderPara(unHeroe) {
    if (unHeroe.poderBase() > 6) {
      return 3 + (batallas * 1)
    } else {
      return 3 
    }
  }

  method usarEnBatalla() {
    batallas = batallas + 1
  }
}

object armaduraDeAceroValyrio {

  method poderPara(unHeroe) = 6

  method usarEnBatalla() {
    // No hace nada
  }
}

object libroDeHechizos {
  var property hechizos = [bendicion,invisibilidad,invocacion]

  method poderPara(unHeroe) {
    if (hechizos.isEmpty()) {
      return 0
    } else {
      return hechizos.first().aporteMagicoPara(unHeroe)
    }
  }

  method usarPrimerHechizo() {
    hechizos = hechizos.drop(1)
  }


  method usarEnBatalla() {
    self.usarPrimerHechizo()
  }

}

object bendicion {

  method aporteMagicoPara(unHeroe) = 4
  
}

object invisibilidad {
  method aporteMagicoPara(unHeroe) = unHeroe.poderBase()
  
}

object invocacion {
  method aporteMagicoPara(unHeroe) = unHeroe.poderDelArtefactoMasPoderosoEnElHogar()
}
