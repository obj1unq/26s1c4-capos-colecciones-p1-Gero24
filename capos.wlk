object rolando {
  const artefactosEnMochila = []
  var capacidadMaximaMochila = 2
  const artefactosEncontrados = []
  var property hogar =  castilloDePiedra

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
}

object espadaDelDestino {}

object libroDeHechizos {}

object collarDivino {}

object armaduraDeAceroValyrio {}

object castilloDePiedra {

  const inventario = []

  method artefactosGuardados() = inventario
  method guardarArtefactos(artefactos) {
    inventario.addAll(artefactos)
  }
}

