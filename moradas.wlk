object castilloDePiedra {
 
  const inventario = []

  method artefactosGuardados() = inventario

  method guardarArtefactos(artefactos) {
    inventario.addAll(artefactos)
  }

  method poderDelArtefactoMasPoderoso(unHeroe) {

    if(inventario.isEmpty()) {
      return 0
    } else {
      const artefactoMasPoderoso = inventario.max({artefacto => artefacto.poderPara(unHeroe)})
      return artefactoMasPoderoso.poderPara(unHeroe)
    }
  }
}



object fortalezaDeAcero {}

object palacioDeMarmol {}

object torreDeMarfil {}
