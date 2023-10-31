import conocimientos.*
import cumbre.*

class Participante {
	const property pais
	const conocimientos = #{}
	var commitsDeActividades
	
	method esCape()
	method cumpleConLosRequisitos() = conocimientos.contains(programacionBasica)
	method cantidadDeCommits() = conocimientos.map({c => c.commitsPorHora()}).sum() + commitsDeActividades
	method realizarActividad(unaActividad) {
		conocimientos.add(unaActividad.tema())
		commitsDeActividades += unaActividad.tema().commitsPorHora() * unaActividad.horas()
	}
}

class Programador inherits Participante {
	var horasDeCapacitacion
	
	override method esCape() = self.cantidadDeCommits() > 500
	override method cumpleConLosRequisitos() = super() and self.cantidadDeCommits() > cumbre.cantidadDeCommitsParaIngresar()
	override method realizarActividad(unaActividad) {
		super(unaActividad)
		horasDeCapacitacion += unaActividad.horas()
	}
	
}

class Especialista inherits Participante {
	override method esCape() = conocimientos.size() > 2
	override method cumpleConLosRequisitos() = super() and self.cantidadDeCommits() > cumbre.cantidadDeCommitsParaIngresar() - 100 
											   and conocimientos.contains(objetos)
	
}

class Gerente inherits Participante {
	const empresa
	
	override method esCape() = empresa.esMultinacional()
	override method cumpleConLosRequisitos() = super() and conocimientos.contains(manejoDeGrupos)
}
