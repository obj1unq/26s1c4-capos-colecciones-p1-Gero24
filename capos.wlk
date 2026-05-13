object rolando {
  const artefactosEnMochila = []
  var capacidadMaximaMochila = 2
  const artefactosEncontrados = []
  var property hogar =  castilloDePiedra
  var property poderBase = 5

  method encontrados() = artefactosEncontrados

  method mochila() = artefactosEnMochila
  
  method capacidadMochila(capacidad) {
    capacidadMaximaMochila = capacidad
  }
  
  method encontrar(artefacto) {
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

  method poder() = poderBase + artefactosEnMochila.sum({artefacto => artefacto.poder()})

  method batallar() {
    artefactosEnMochila.forEach({artefacto => artefacto.incrementarBatalla()})
    self.incrementarPoderBase()
  }

  method incrementarPoderBase() {
    poderBase = poderBase + 1
  }

  method artefactoMasPoderosoEnElHogar() = hogar.poderDeArtefactoMasPoderoso()
}

object espadaDelDestino {
  var property heroe = rolando
  var property batallas = 0
  
  method poder() {
    if (batallas == 0) {
      return heroe.poderBase()
    } else {
      return heroe.poderBase() / 2 
    }
  }

  method incrementarBatalla() {
    batallas = batallas + 1
  }
}

object collarDivino {
  var property heroe = rolando
  var property batallas = 0

  method poder() {
    if (heroe.poderBase() > 6) {
      return 3 + (batallas * 1)
    } else {
      return 3 
    }
  }
  method incrementarBatalla() {
    batallas = batallas + 1
  }
}

object armaduraDeAceroValyrio {

  var property heroe = rolando
  var property batallas = 0

  method poder() = 6

  method incrementarBatalla() {
    batallas = batallas + 1
  }
}

object libroDeHechizos {
  var property heroe = rolando
  var property batallas = 0
  var property hechizos = [bendicion,invisibilidad,invocación]

  method poder() {
    if (hechizos.isEmpty()) {
      return 0
    } else {
      return hechizos.first().aporteMagico()
    }
  }

  method usarPrimerHechizo() {
    hechizos = hechizos.drop(1)
  }


  method incrementarBatalla() {
    batallas = batallas + 1
    self.usarPrimerHechizo()
  }

}

object bendicion {

  method aporteMagico() = 4
  
}

object invisibilidad {
  method aporteMagico() {
    const heroePosedor = libroDeHechizos.heroe()
    return heroePosedor.poderBase()
  }
  
}

object invocación {
  method aporteMagico() {
    const heroePosedor = libroDeHechizos.heroe()
    return heroePosedor.artefactoMasPoderosoEnElHogar()
  }
}
object castilloDePiedra {

  const inventario = []

  method artefactosGuardados() = inventario

  method guardarArtefactos(artefactos) {
    inventario.addAll(artefactos)
  }

  method poderDeArtefactoMasPoderoso() {

    if(inventario.isEmpty()) {
      return 0
    } else {
      const artefactoMasPoderoso = inventario.max({artefacto => artefacto.poder()})
      return artefactoMasPoderoso.poder()
    }
  }
}

