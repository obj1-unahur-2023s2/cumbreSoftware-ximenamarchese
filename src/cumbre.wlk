object cumbre {
	const paisesAuspiciantes = #{}
	const participantes = #{}
	var property cantidadDeCommitsParaIngresar = 300
	const actividadesRealizadas = #{}
	
	method esConflictivo(unPais) = paisesAuspiciantes.intersection(unPais.paisesConConflicto())
	method registrarIngresoDePersona(unaPersona) = participantes.add(unaPersona)
	method paisesDeLosParticipantes() = participantes.map({p => p.pais()}).asSet()
	method participantesDePais(unPais) = participantes.count({p => p.pais() == unPais})
	method paisConMasParticipantes() = participantes.ocurrenceOf({p => p.pais()}).max()
	method participantesExtranjeros() = self.paisesDeLosParticipantes().difference(paisesAuspiciantes)
	method esRelevante() = participantes.all({p => p.esCape()})
	method tieneRestringidoElAcceso(unParticipante) = self.esConflictivo(unParticipante.pais()) or 
													(if (not paisesAuspiciantes.contains(unParticipante.pais())){
														 return (participantes.filter({p => p.pais() == unParticipante.pais()}).size() >= 2)
														 }
														 else{
														 	return false
														 }
														 
													)
	method puedeIngresar(unParticipante) = unParticipante.cumpleConLosRequisitos() and not self.tieneRestringidoElAcceso(unParticipante)
	method darIngreso(unParticipante) {
		if (not self.puedeIngresar(unParticipante)){
			self.error("El participante no puede ingresar")
		}
		self.registrarIngresoDePersona(unParticipante)
	}
	method esSegura() = participantes.all({p => self.puedeIngresar(p)})
	method registrarActividad(unaActividad) {
		participantes.forEach({p => p.realizarActividad(unaActividad)})
		actividadesRealizadas.add(unaActividad)
	}
	method totalDeHorasDeActividades() = actividadesRealizadas.map({a => a.horas()}).sum()
	
}
