namespace :dictionary do
    desc "Process dictionary (; separator)"
    task :all, [:date_from, :date_to] => [:environment] do |t, args|
      args.with_defaults(date_from: nil, date_to: nil)
      first_branch = [
        { internal_id: "1", name: "PRORRECTORIA", childs: [
          { internal_id: "1.1", name: "RRHH", childs: [
            { internal_id: "1.1.01", name: "Certificados", childs: [
              {internal_id: "1.1.01.01", name: "Certificado de Acreditación de Docencia"},
              {internal_id: "1.1.01.02", name: "Certificado P/Beneficio Matrícula"},
            ]},
            { internal_id: "1.1.02", name: "Claves y Accesos Docentes Honorarios", childs: [
              {internal_id: "1.1.02.01", name: "Recuperación de Clave P. Pago Honorarios"},
              {internal_id: "1.1.02.02", name: "Recuperación Presencial de Clave P. Honorarios"},
            ]},
            { internal_id: "1.1.03", name: "Remuneraciones", childs: [
              {internal_id: "1.1.03.01", name: "Fechas de Pago"},
              {internal_id: "1.1.03.02", name: "No Figura Deposito"},
              {internal_id: "1.1.03.03", name: "Plazos de Firma de Contrato"},
            ]},
          ] },
          { internal_id: "1.2", name: "SERNAC", childs: [
            { internal_id: "1.2.01", name: "Cláusulas Abusivas", childs: [
              {internal_id: "1.2.01.01", name: "Becas-Casos Sociales-Seguro-Pase Escolar"},
              {internal_id: "1.2.01.02", name: "Certificados"},
              {internal_id: "1.2.01.03", name: "Servicio Admisión-Horario-Matrícula"},
            ]},
            { internal_id: "1.2.02", name: "Cobro de un Precio Superior al Exhibido, Informado", childs: [
              {internal_id: "1.2.02.01", name: "Cae"},
              {internal_id: "1.2.02.02", name: "Cobranza"},
              {internal_id: "1.2.02.03", name: "Retiro por Motivos Financieros"},
              {internal_id: "1.2.02.04", name: "Retiro por Motivos Personales"},
              {internal_id: "1.2.02.05", name: "Servicio Admisión-Horario-Matrícula"},
            ]},
            { internal_id: "1.2.03", name: "Falta o No Entrega de Contrato", childs: [
              {internal_id: "1.2.03.01", name: "Certificados"},
            ]},
            { internal_id: "1.2.04", name: "Formalidades de Contrato", childs: [
              {internal_id: "1.2.04.01", name: "Admisión Postgrado"},
              {internal_id: "1.2.04.02", name: "Becas"},
              {internal_id: "1.2.04.03", name: "Cae"},
              {internal_id: "1.2.04.04", name: "Certificados"},
              {internal_id: "1.2.04.05", name: "Cobranza"},
              {internal_id: "1.2.04.06", name: "Devolución"},
              {internal_id: "1.2.04.07", name: "DICOM"},
              {internal_id: "1.2.04.08", name: "Gestión Y Políticas De Cobranzas y/o Repactación"},
              {internal_id: "1.2.04.09", name: "Malla, Programa, Ramo, Horario"},
              {internal_id: "1.2.04.10", name: "Notas"},
              {internal_id: "1.2.04.11", name: "Publicidad"},
              {internal_id: "1.2.04.12", name: "Retiro por Motivos Financieros"},
              {internal_id: "1.2.04.13", name: "Retiro por Motivos Personales"},
              {internal_id: "1.2.04.14", name: "Retiro por Problemas De Salud"},
              {internal_id: "1.2.04.15", name: "Retiro Reclamo por Servicio y/o Infraestructura"},
              {internal_id: "1.2.04.16", name: "Retracto o Resciliación"},
              {internal_id: "1.2.04.17", name: "Servicio Admisión-Horario-Matrícula"},
            ]},
            { internal_id: "1.2.05", name: "Incumplimiento en Condiciones Contratadas", childs: [
              {internal_id: "1.2.05.01", name: "Cae"},
              {internal_id: "1.2.05.02", name: "Cobranza"},
              {internal_id: "1.2.05.03", name: "Malla, Programa, Ramos, Horario o Jornada"},
              {internal_id: "1.2.05.04", name: "Notas"},
              {internal_id: "1.2.05.05", name: "Retiro por Motivos De Salud"},
              {internal_id: "1.2.05.06", name: "Retiro-Reclamo por Servicio y/o Infraestructura"},
              {internal_id: "1.2.05.07", name: "Servicio Admisión-Horario-Matrícula"},
              {internal_id: "1.2.05.08", name: "Servicio y/o Infraestructura"},
            ]},
            { internal_id: "1.2.06", name: "Incumplimiento en Respuestas al Consumidor", childs: [
              {internal_id: "1.2.06.01", name: "Insistencia"},
            ]},
            { internal_id: "1.2.07", name: "Incumplimiento en Respuestas al SERNAC", childs: [
              {internal_id: "1.2.07.01", name: "Insistencia"},
            ]},
            { internal_id: "1.2.08", name: "Publicidad Engañosa o Falsa", childs: [
              {internal_id: "1.2.08.01", name: "Publicidad"},
              {internal_id: "1.2.08.02", name: "Retracto o Resciliación"},
              {internal_id: "1.2.08.03", name: "Servicio Admisión-Horario-Matrícula"},
            ]},
            { internal_id: "1.2.09", name: "Servicio Defectuoso", childs: [
              {internal_id: "1.2.09.01", name: "Becas-Casos Sociales-Seguro-Pase Escolar"},
              {internal_id: "1.2.09.02", name: "CAE"},
              {internal_id: "1.2.09.03", name: "Certificados"},
              {internal_id: "1.2.09.04", name: "Cobranza"},
              {internal_id: "1.2.09.05", name: "Descuento No Aplicado"},
              {internal_id: "1.2.09.06", name: "Devolución Documentos y/o Dinero"},
              {internal_id: "1.2.09.07", name: "DICOM"},
              {internal_id: "1.2.09.08", name: "Error Pagos y/o Cobros"},
              {internal_id: "1.2.09.09", name: "Gestión Y Políticas De Cobranzas y/o Repactación"},
              {internal_id: "1.2.09.10", name: "Malla, Programa, Ramos, Horario o Jornada"},
              {internal_id: "1.2.09.11", name: "Notas"},
              {internal_id: "1.2.09.12", name: "Retiro por Motivos De Salud"},
              {internal_id: "1.2.09.13", name: "Retiro por Motivos Financieros"},
              {internal_id: "1.2.09.14", name: "Retiro por Motivos Personales"},
              {internal_id: "1.2.09.15", name: "Retiro-Reclamo por Servicio y/o Infraestructura"},
              {internal_id: "1.2.09.16", name: "Retracto O Resciliación"},
              {internal_id: "1.2.09.17", name: "Seguros y/o Becas"},
              {internal_id: "1.2.09.18", name: "Servicio"},
              {internal_id: "1.2.09.19", name: "Servicio Admisión-Horario-Matrícula"},
              {internal_id: "1.2.09.20", name: "Servicio De Admisión-Horario-Matricula"},
              {internal_id: "1.2.09.21", name: "Titulación"},
            ]},
            { internal_id: "1.2.10", name: "Término de Contrato", childs: [
              {internal_id: "1.2.10.01", name: "CAE"},
              {internal_id: "1.2.10.02", name: "Cobranza"},
              {internal_id: "1.2.10.03", name: "Gestión y Políticas de Cobranzas y/o Repactación"},
              {internal_id: "1.2.10.04", name: "Resciliación"},
              {internal_id: "1.2.10.05", name: "Retiro por Motivos De Salud"},
              {internal_id: "1.2.10.06", name: "Retiro por Motivos Financieros"},
              {internal_id: "1.2.10.07", name: "Retiro por Motivos Personales"},
              {internal_id: "1.2.10.08", name: "Retiro por Problemas de Salud"},
              {internal_id: "1.2.10.09", name: "Retiro por Servicio"},
              {internal_id: "1.2.10.10", name: "Retiro-Reclamo por Servicio y/o Infraestructura"},
              {internal_id: "1.2.10.11", name: "Retracto"},
              {internal_id: "1.2.10.12", name: "Retracto o Resciliación"},
              {internal_id: "1.2.10.13", name: "Servicio Admisión-Horario-Matrícula"},
            ]},
            { internal_id: "1.2.11", name: "Término De Contrato Unilateral", childs: [
              {internal_id: "1.2.11.01", name: "Retiro"},
            ]},
          ]}
        ] },
        { internal_id: "2", name: "VRA", childs:[
          { internal_id: "2.1", name: "Academia", childs: [
            {internal_id: "2.1.01", name: "Actualización de Datos", childs: [
              {internal_id: "2.1.01.01", name: "Teléfono / e-mail"}
            ]},
            {internal_id: "2.1.02", name: "Asignaturas y Evaluaciones", childs: [
              {internal_id: "2.1.02.01", name: "Carga Académica"},
              {internal_id: "2.1.02.02", name: "Controles, Cátedras y Exámenes"},
              {internal_id: "2.1.02.03", name: "Evaluación y Calificaciones"},
            ]},
            {internal_id: "2.1.03", name: "Atención", childs: [
              {internal_id: "2.1.03.01", name: "CIADE"},
              {internal_id: "2.1.03.02", name: "Gestión Académica"},
              {internal_id: "2.1.03.03", name: "Operaciones Campus"}
            ]},
            {internal_id: "2.1.04", name: "Bases de Datos Plataforma Curriculum Docente", childs: [
              {internal_id: "2.1.04.01", name: "Usuario no Existe"},
            ]},
            {internal_id: "2.1.05", name: "Calendarios y Fechas", childs: [
              {internal_id: "2.1.05.01", name: "Calendario Académico"},
              {internal_id: "2.1.05.02", name: "Calendario del Programa o del Curso"},
              {internal_id: "2.1.05.03", name: "Semana de Bienvenida"},
            ]},
            {internal_id: "2.1.06", name: "Certificados", childs: [
              {internal_id: "2.1.06.01", name: "Alumno Regular"},
              {internal_id: "2.1.06.02", name: "Concentración de Notas"},
              {internal_id: "2.1.06.03", name: "Créditos Aprobados"},
              {internal_id: "2.1.06.04", name: "Egreso"},
              {internal_id: "2.1.06.05", name: "Específico o De Excepción"},
              {internal_id: "2.1.06.06", name: "Horas Presenciales"},
              {internal_id: "2.1.06.07", name: "Otros Certificados (Especiales)"},
              {internal_id: "2.1.06.08", name: "Programas de Estudios"},
              {internal_id: "2.1.06.09", name: "Sin Impedimento Académico"},
              {internal_id: "2.1.06.10", name: "Título"},
            ]},
            {internal_id: "2.1.07", name: "Horarios de Atención de Servicios", childs: [
              {internal_id: "2.1.07.01", name: "Cursos de Verano"}
            ]},
            {internal_id: "2.1.08", name: "Justificativo de Inasistencia", childs: [
              {internal_id: "2.1.08.01", name: "Certificado Laboral"},
              {internal_id: "2.1.08.02", name: "Certificado Médico"}
            ]},
            {internal_id: "2.1.09", name: "Reglamentaciones", childs: [
              {internal_id: "2.1.09.01", name: "Reglamento Interno"}
            ]},
            {internal_id: "2.1.10", name: "Solicitudes Académicas", childs: [
              {internal_id: "2.1.10.01", name: "Actas"},
              {internal_id: "2.1.10.02", name: "Apelación a Rechazo de Continuidad de Estudios"},
              {internal_id: "2.1.10.03", name: "Cambio de Antecedentes"},
              {internal_id: "2.1.10.04", name: "Cambio de Carrera"},
              {internal_id: "2.1.10.05", name: "Cambio de Mención"},
              {internal_id: "2.1.10.06", name: "Cambio de Sede"},
              {internal_id: "2.1.10.07", name: "Cambio Interno"},
              {internal_id: "2.1.10.08", name: "Continuidad De Estudio"},
              {internal_id: "2.1.10.09", name: "Convalidación de Asignaturas"},
              {internal_id: "2.1.10.10", name: "Eliminación de Asignaturas"},
              {internal_id: "2.1.10.11", name: "Estatus Académico"},
              {internal_id: "2.1.10.12", name: "Exámenes de Conocimientos Relevantes"},
              {internal_id: "2.1.10.13", name: "Homologación de Asignaturas"},
              {internal_id: "2.1.10.14", name: "Inscripción de Asignaturas Fuera de Plazo, en Otro Programa o Régimen"},
              {internal_id: "2.1.10.15", name: "Mantener Dos Carreras Activas"},
              {internal_id: "2.1.10.16", name: "Prórroga Retiro Temporal"},
              {internal_id: "2.1.10.17", name: "Regulariza Situacion Académica"},
              {internal_id: "2.1.10.18", name: "Reincorporación de un RT"},
              {internal_id: "2.1.10.19", name: "Reincorporación de un RT Próximo Periodo"},
              {internal_id: "2.1.10.20", name: "Renuncia de Asignaturas"},
              {internal_id: "2.1.10.21", name: "Resoluciones"},
              {internal_id: "2.1.10.22", name: "Retiro Definitivo"},
              {internal_id: "2.1.10.23", name: "Retiro Temporal"},
            ]},
            {internal_id: "2.1.11", name: "Titulación", childs: [
              {internal_id: "2.1.11.01", name: "Certificaciones (-180Hrs.)"},
              {internal_id: "2.1.11.02", name: "Documentos para Titulación"},
              {internal_id: "2.1.11.03", name: "Entrega Certificado"},
              {internal_id: "2.1.11.04", name: "Entrega Diploma"},
              {internal_id: "2.1.11.05", name: "Estado de Proceso"},
              {internal_id: "2.1.11.06", name: "Ficha Curricular"},
            ]},
            {internal_id: "2.1.12", name: "Toma de Ramos", childs: [
              {internal_id: "2.1.12.01", name: "Actualización Notas Curso de Verano"},
              {internal_id: "2.1.12.02", name: "Anular Inscripción"},
              {internal_id: "2.1.12.03", name: "Avance de Malla"},
              {internal_id: "2.1.12.04", name: "Bloqueo Académico"},
              {internal_id: "2.1.12.05", name: "Bloqueo por Reincorporación"},
              {internal_id: "2.1.12.06", name: "Código de Ramos (ncr)"},
              {internal_id: "2.1.12.07", name: "Como Calcular ppa"},
              {internal_id: "2.1.12.08", name: "Incidencia por Innovación"},
              {internal_id: "2.1.12.09", name: "Innovación y/o Actualización Curricular"},
              {internal_id: "2.1.12.10", name: "No Tiene Boleto de Inscripción"},
              {internal_id: "2.1.12.11", name: "Periodo Toma de Ramos"},
              {internal_id: "2.1.12.12", name: "Pre Requisito / Liga"},
              {internal_id: "2.1.12.13", name: "Procedimiento Inscripción de Ramos"},
              {internal_id: "2.1.12.14", name: "Ramo sin Cupo / Sección Cerrada"},
              {internal_id: "2.1.12.15", name: "Recalcular PPA"},
              {internal_id: "2.1.12.16", name: "Solicitud de Créditos"},
              {internal_id: "2.1.12.17", name: "Solicitud de Inscripción de Asignaturas Otro Programa"},
              {internal_id: "2.1.12.18", name: "Solicitud de Inscripción de Asignaturas Sin Requisitos"},
              {internal_id: "2.1.12.19", name: "Tope de Horario"},
              {internal_id: "2.1.12.20", name: "Vacantes de Asignaturas"},
            ]},
          ]},
          { internal_id: "2.2", name: "UNAB Online", childs: [
            {internal_id: "2.2.01", name: "Acceso a Plataformas", childs: [
              {internal_id: "2.2.01.01", name: "Acceso al Curso"},
              {internal_id: "2.2.01.02", name: "Programas On-Line"},
              {internal_id: "2.2.01.03", name: "Navegación y usabilidad"},
              {internal_id: "2.2.01.04", name: "No veo el Curso"},
              {internal_id: "2.2.01.05", name: "Nuevo Intento en Plataforma"},
            ]},
            {internal_id: "2.2.02", name: "Asignaturas y Evaluaciones", childs: [
              {internal_id: "2.2.02.01", name: "Atención Docente"},
              {internal_id: "2.2.02.02", name: "Carga Académica"},
              {internal_id: "2.2.02.03", name: "Controles, Cátedras y Exámenes"},
              {internal_id: "2.2.02.04", name: "Evaluación y Calificaciones"},
              {internal_id: "2.2.02.05", name: "Grupos de Trabajo"},
            ]},
            {internal_id: "2.2.03", name: "Calendarios y Fechas", childs: [
              {internal_id: "2.2.03.01", name: "Calendario Académico"},
              {internal_id: "2.2.03.02", name: "Calendario del Programa o del Curso Online"},
              {internal_id: "2.2.03.03", name: "Semana de Bienvenida"},
            ]},
            {internal_id: "2.2.04", name: "Reglamentaciones", childs: [
              {internal_id: "2.2.04.01", name: "Reglamento Interno"},
            ]},
            {internal_id: "2.2.05", name: "Solicitudes Académicas", childs: [
              {internal_id: "2.2.05.01", name: "Actas"},
              {internal_id: "2.2.05.02", name: "Apelación a Rechazo de Continuidad de Estudios"},
              {internal_id: "2.2.05.03", name: "Cambio de Antecedentes"},
              {internal_id: "2.2.05.04", name: "Cambio de Carrera"},
              {internal_id: "2.2.05.05", name: "Cambio de Mención"},
              {internal_id: "2.2.05.06", name: "Cambio de Sede"},
              {internal_id: "2.2.05.07", name: "Cambio Interno"},
              {internal_id: "2.2.05.08", name: "Convalidación de Asignaturas"},
              {internal_id: "2.2.05.09", name: "Eliminación de Asignaturas"},
              {internal_id: "2.2.05.10", name: "Homologación de Asignaturas"},
              {internal_id: "2.2.05.11", name: "Inscripción de Asignatura"},
              {internal_id: "2.2.05.12", name: "Mantener Dos Carreras Activas"},
              {internal_id: "2.2.05.13", name: "Prórroga Retiro Temporal"},
              {internal_id: "2.2.05.14", name: "Reincorporación de un RT"},
              {internal_id: "2.2.05.15", name: "Renuncia de Asignaturas"},
              {internal_id: "2.2.05.16", name: "Resoluciones"},
              {internal_id: "2.2.05.17", name: "Re- correcciones"},
              {internal_id: "2.2.05.18", name: "Extensión plazos entregas"},
              {internal_id: "2.2.05.19", name: "Solicitud certificados"},
              {internal_id: "2.2.05.20", name: "Retiro Temporal"},
              {internal_id: "2.2.05.21", name: "Retiro Definitivo"},
              {internal_id: "2.2.05.22", name: "Calendarios y Fechas"},
              {internal_id: "2.2.05.23", name: "Pasantía"},
            ]},
            {internal_id: "2.2.06", name: "Solicitudes Administrativas", childs: [
              {internal_id: "2.2.06.01", name: "No contesta tutor"},
              {internal_id: "2.2.06.02", name: "No contesta profesor"},
              {internal_id: "2.2.06.03", name: "Disconformidad con la modalidad"},
            ]},
          ]},
          { internal_id: "2.3", name: "CIADE", childs: [
            {internal_id: "2.3.01", name: "Asesorías Psicoeducativas", childs: [
              {internal_id: "2.3.01.01", name: "Atención Psicoeducativa"}
            ]},
            {internal_id: "2.3.02", name: "Crea Caso Comité Retención", childs: [
              {internal_id: "2.3.02.01", name: "Comité Retención (Financiero)"}
            ]},
            {internal_id: "2.3.03", name: "Crea Caso o Retención", childs: [
              {internal_id: "2.3.03.01", name: "Problemas Vocacionales"}
            ]},
            {internal_id: "2.3.04", name: "Talleres de Habilidades y Aprendizaje", childs: [
              {internal_id: "2.3.04.01", name: "Talleres CIADE"}
            ]},
            {internal_id: "2.3.05", name: "Tutorías Académicas", childs: [
              {internal_id: "2.3.05.01", name: "Tutorías CIADE"}
            ]},
          ]},
          { internal_id: "2.4", name: "Excepción VRA", childs: [
            {internal_id: "2.4.01", name: "Examen de Grado 4Ta Oportunidad", childs: [
              {internal_id: "2.4.01.01", name: "Examen de Grado 4Ta Oportunidad"}
            ]}
          ]},
          { internal_id: "2.5", name: "Relaciones Internacionales", childs: [
            {internal_id: "2.5.01", name: "Servicios Complementarios", childs: [
              {internal_id: "2.5.01.01", name: "Intercambio Estudiantil"}
            ]}
          ]},
        ]},
        { internal_id: "3", name: "VRE", childs:[
          { internal_id: "3.1", name: "Excepción VRE", childs: [
            {internal_id: "3.1.01", name: "Financiera", childs: [
              {internal_id: "3.1.01.01", name: "Casos Financieros con Respuesta DMGF" }
            ]}
          ]},
          { internal_id: "3.2", name: "MAS", childs: [
            {internal_id: "3.2.01", name: "Crea Caso Comité Crédito", childs: [
              {internal_id: "3.2.01.01", name: "Comité Crédito (Financiero)"}
            ]},
            {internal_id: "3.2.02", name: "Crea Caso Comité Retención", childs: [
              {internal_id: "3.2.02.01", name: "Comité Retención (Financiero)"}
            ]},
          ]},
          { internal_id: "3.3", name: "Matrícula", childs: [
            { internal_id: "3.3.01", name: "Atención", childs: [
              {internal_id: "3.3.01.01", name: "Disconformidad por Atención"},
              {internal_id: "3.3.01.02", name: "Felicitaciones"},
              {internal_id: "3.3.01.03", name: "Sugerencias"}
            ]},
            { internal_id: "3.3.02", name: "Clave Mol", childs: [
              {internal_id: "3.3.02.01", name: "Entrega de Clave Mol"},
              {internal_id: "3.3.02.02", name: "Guía e Indicaciones"}
            ]},
            { internal_id: "3.3.03", name: "Contrato Matrícula", childs: [
              {internal_id: "3.3.03.01", name: "Solicitud de Contrato"}
            ]},
            { internal_id: "3.3.04", name: "Fechas y Valores Matrículas - Arancel", childs: [
              {internal_id: "3.3.04.01", name: "Fechas de Matrículas"},
              {internal_id: "3.3.04.02", name: "Valores Arancel"},
              {internal_id: "3.3.04.03", name: "Valores Matrícula"},
              {internal_id: "3.3.04.04", name: "Valores Matrícula y Arancel"},
            ]},
            { internal_id: "3.3.05", name: "Firma Electrónica", childs: [
              {internal_id: "3.3.05.01", name: "Guía del Proceso"},
            ]},
            { internal_id: "3.3.06", name: "Gestión y orientación Becas y Cae", childs: [
              {internal_id: "3.3.06.01", name: "Beca Externa no Cargada"},
              {internal_id: "3.3.06.02", name: "Beca Interna no Cargada"},
              {internal_id: "3.3.06.03", name: "Beca Interna y Externa no Cargada"},
              {internal_id: "3.3.06.04", name: "Cae no Cargado"},
              {internal_id: "3.3.06.05", name: "Cae y Beca no Cargados"},
              {internal_id: "3.3.06.06", name: "Información Becas"},
              {internal_id: "3.3.06.07", name: "Información Becas y CAE"},
              {internal_id: "3.3.06.08", name: "Información CAE"},
            ]},
            { internal_id: "3.3.07", name: "Incidencia de Sistema Mol", childs: [
              {internal_id: "3.3.07.01", name: "Dirección Web"},
              {internal_id: "3.3.07.02", name: "Portal de Mol"},
              {internal_id: "3.3.07.03", name: "Portal de Pago (Transbank - Chilexpress)"},
              {internal_id: "3.3.07.04", name: "Portal Sube Tu Certificado"},
              {internal_id: "3.3.07.05", name: "Problema de Firma Electrónica"},
            ]},
            { internal_id: "3.3.08", name: "Matrícula"},
            { internal_id: "3.3.09", name: "Matrícula Presencial", childs: [
              {internal_id: "3.3.09.01", name: "Matrícula Fuera De Plazo"},
              {internal_id: "3.3.09.02", name: "Pago con Cheques"},
              {internal_id: "3.3.09.03", name: "Pago con Pac"},
            ]},
            { internal_id: "3.3.10", name: "Medios de Pago", childs: [
              {internal_id: "3.3.10.01", name: "Información Medios de Pago"},
              {internal_id: "3.3.10.02", name: "Repactaciones (Reprogramaciones)"},
            ]},
            { internal_id: "3.3.11", name: "Plataforma Sube Tu Certificado", childs: [
              {internal_id: "3.3.11.01", name: "Acreditación"},
              {internal_id: "3.3.11.02", name: "Guía del Proceso"},
              {internal_id: "3.3.11.03", name: "No se Cumple Tiempo de Respuesta"},
            ]},
            { internal_id: "3.3.12", name: "Servicios Financieros", childs: [
              {internal_id: "3.3.12.01", name: "Bloqueo Financiero"},
              {internal_id: "3.3.12.02", name: "Bloqueo por Matrícula"},
              {internal_id: "3.3.12.03", name: "Carta Comité"},
              {internal_id: "3.3.12.04", name: "Certificados"},
              {internal_id: "3.3.12.05", name: "Cuotas Ara/Mat Por Pagar"},
              {internal_id: "3.3.12.06", name: "Cuotas Ara/Mat Vencidas"},
              {internal_id: "3.3.12.07", name: "Deuda y Morosidades"},
              {internal_id: "3.3.12.08", name: "Devoluciones"},
              {internal_id: "3.3.12.09", name: "Seguro Estudiantil"},
              {internal_id: "3.3.12.10", name: "Solicita Información Dirección Atención"},
            ]},
          ]},
          { internal_id: "3.4", name: "Matrícula Y Gestión De Financiamiento", childs: [
            { internal_id: "3.4.01", name: "Facturación a Terceros", childs: [
              {internal_id: "3.4.01.01", name: "Recepción OC Y Validación DMGF (No Cumple)"},
              {internal_id: "3.4.01.02", name: "Recepción OC Y ValidaciónDMGF (Cumple)"},
            ]},
            { internal_id: "3.4.02", name: "Gestión de Retiros", childs: [
              {internal_id: "3.4.02.01", name: "Resciliación"},
              {internal_id: "3.4.02.02", name: "Retiro Alumno Advance"},
              {internal_id: "3.4.02.03", name: "Retiro Alumno Postgrado"},
              {internal_id: "3.4.02.04", name: "Retracto"},
              {internal_id: "3.4.02.05", name: "RT o RD Antes de Inicio de Clases"},
              {internal_id: "3.4.02.06", name: "RT o RD Posterior a la Fecha de Calendario"},
            ]},
            { internal_id: "3.4.03", name: "Gestión Rebajas Arancel", childs: [
              {internal_id: "3.4.03.01", name: "Solicita Aplicación de Política"},
              {internal_id: "3.4.03.02", name: "Solicita Excepción Alumno Egresado Derecho"},
              {internal_id: "3.4.03.03", name: "Solicita Fuera de la Política"},
              {internal_id: "3.4.03.04", name: "Solicita rebaja por Egreso"},
            ]},
            { internal_id: "3.4.04", name: "Gestión y orientación Becas y Cae", childs: [
              {internal_id: "3.4.04.01", name: "Beca Externa no Cargada"},
              {internal_id: "3.4.04.02", name: "Beca Interna no Cargada"},
              {internal_id: "3.4.04.03", name: "Beca Interna y Externa no Cargada"},
              {internal_id: "3.4.04.04", name: "Cae no Cargado"},
              {internal_id: "3.4.04.05", name: "Cae Y Beca no Cargados"},
              {internal_id: "3.4.04.06", name: "Información Becas"},
              {internal_id: "3.4.04.07", name: "Información Becas Y CAE"},
              {internal_id: "3.4.04.08", name: "Información CAE"},
              {internal_id: "3.4.04.09", name: "Suspensiones Becas Mineduc"},
              {internal_id: "3.4.04.10", name: "BAES"},
              {internal_id: "3.4.04.11", name: "Devoluciones CAE (DCAE, Pregado y garantias cae)"},
              {internal_id: "3.4.04.12", name: "Acreditación Socioeconómica"},
              {internal_id: "3.4.04.13", name: "Apelación Beca Mineduc"},
              {internal_id: "3.4.04.14", name: "Apelación Becas Internas"},
              {internal_id: "3.4.04.15", name: "Apelación CAE"},
              {internal_id: "3.4.04.16", name: "Beca Apoyo Familiar"},
              {internal_id: "3.4.04.17", name: "Beca de Articulación"},
              {internal_id: "3.4.04.18", name: "Beca Juan Gómez Millas Extranjeros"},
              {internal_id: "3.4.04.19", name: "Joven Seguro"},
            ]},
            { internal_id: "3.4.05", name: "Matrícula Presencial", childs: [
              {internal_id: "3.4.05.01", name: "Matrícula no Finalizada Bloqueo Financiero"},
              {internal_id: "3.4.05.02", name: "Matrícula no Finalizada CI Vencida (o Sin CI)"},
              {internal_id: "3.4.05.03", name: "Matrícula no Finalizada Monto Abono Insuficiente"},
              {internal_id: "3.4.05.04", name: "Matrícula no Finalizada por Bloqueo Académico (Con Continuidad)"},
              {internal_id: "3.4.05.05", name: "Matrícula no Finalizada por Bloqueo Académico (Sin Continuidad)"},
              {internal_id: "3.4.05.06", name: "Matrícula no Finalizada S/Aceptante"},
              {internal_id: "3.4.05.07", name: "Matrícula no Finalizada S/Alumno"},
              {internal_id: "3.4.05.08", name: "Matrícula Traspasada"},
            ]},
            { internal_id: "3.4.06", name: "Pago de Cuotas o Cursos (Ara3)", childs: [
              {internal_id: "3.4.06.01", name: "Pago Cheque Protestado"},
              {internal_id: "3.4.06.02", name: "Pago Exitoso"},
              {internal_id: "3.4.06.03", name: "Pago no Generado"},
              {internal_id: "3.4.06.04", name: "Solicita Dcto. Pago Cheque Protestado"},
            ]},
            { internal_id: "3.4.07", name: "Prepago Total", childs: [
              {internal_id: "3.4.07.01", name: "Pago Exitoso"},
              {internal_id: "3.4.07.02", name: "Pago no Generado Monto Insuficiente"},
            ]},
            { internal_id: "3.4.08", name: "Redocumentación", childs: [
              {internal_id: "3.4.08.01", name: "Redocumenta Beca Externa/Con Beneficio Cargado en Tyaaben"},
              {internal_id: "3.4.08.02", name: "Redocumenta Beca Externa/Sin Beneficio Cargado en Tyaaben"},
              {internal_id: "3.4.08.03", name: "Redocumenta Beca Interna /Con Beneficio Cargado en Tyaaben"},
              {internal_id: "3.4.08.04", name: "Redocumenta Beca Interna /Sin Beneficio Cargado en Tyaaben"},
              {internal_id: "3.4.08.05", name: "Redocumenta CAE/Con Beneficio Cargado en Tyaaben"},
              {internal_id: "3.4.08.06", name: "Redocumenta CAE/Sin Beneficio Cargado en Tyaaben"},
              {internal_id: "3.4.08.07", name: "Redocumenta Copago + Bca Interna + Beca Externa/Con Beneficio Cargado en Tyaaben"},
              {internal_id: "3.4.08.08", name: "Redocumenta Copago + Bca Interna + Beca Externa/Sin Beneficio Cargado en Tyaaben"},
              {internal_id: "3.4.08.09", name: "Redocumenta Copago + Bca Interna/Con Beneficio Cargado en Tyaaben"},
              {internal_id: "3.4.08.10", name: "Redocumenta Copago + Bca Interna/Sin Beneficio Cargado en Tyaaben"},
              {internal_id: "3.4.08.11", name: "Redocumenta Copago + Beca Externa/Con Beneficio Cargado en Tyaaben"},
              {internal_id: "3.4.08.12", name: "Redocumenta Copago + Beca Externa/Sin Beneficio Cargado en Tyaaben"},
              {internal_id: "3.4.08.13", name: "Redocumenta Copago + Cae /Con Beneficio Cargado en Tyaaben"},
              {internal_id: "3.4.08.14", name: "Redocumenta Copago + Cae /Sin Beneficio Cargado en Tyaaben"},
              {internal_id: "3.4.08.15", name: "Redocumenta Copago + Cae + Bca Externa/Con Beneficio Cargado en Tyaaben"},
              {internal_id: "3.4.08.16", name: "Redocumenta Copago + Cae + Bca Externa/Sin Beneficio Cargado en Tyaaben"},
              {internal_id: "3.4.08.17", name: "Redocumenta Copago + Cae + Bca Interna + Beca Externa"},
              {internal_id: "3.4.08.18", name: "Redocumenta Copago + Cae + Bca Interna + Beca Externa/Sin Beneficio Cargado en Tyaaben"},
              {internal_id: "3.4.08.19", name: "Redocumenta Copago + Cae + Bca Interna/Con Beneficio Cargado en Tyaaben"},
              {internal_id: "3.4.08.20", name: "Redocumenta Copago + Cae + Bca Interna/Sin Beneficio Cargado en Tyaaben"},
              {internal_id: "3.4.08.21", name: "Redocumenta Copago/ Con Beneficio Cargado en Tyaaben"},
              {internal_id: "3.4.08.22", name: "Redocumenta Copago/ Sin Beneficio Cargado en Tyaaben"},
            ]},
            { internal_id: "3.4.09", name: "Reprogramación", childs: [
              {internal_id: "3.4.09.01", name: "Reprograma con Excepción a la Política (Mayor Cantidad Cuotas)"},
              {internal_id: "3.4.09.02", name: "Reprograma con Excepción a la Política (Menor Abono)"},
              {internal_id: "3.4.09.03", name: "Reprograma con Excepción a la Política (Monto Menor De Cuotas al Mínimo Establecido)"},
              {internal_id: "3.4.09.04", name: "Reprograma con Excepción a la Política (Rebaja % Capital)"},
              {internal_id: "3.4.09.05", name: "Reprograma con Excepción a la Política (Rebaja Multas y Gastos)"},
              {internal_id: "3.4.09.06", name: "Reprograma con Excepción a la Política (Sin Acreditación de Ingreso)"},
              {internal_id: "3.4.09.07", name: "Reprograma con Excepción a la Política (Sin Aval)"},
              {internal_id: "3.4.09.08", name: "Reprograma Deuda Vencida (Reprograma con Éxito Según Política Ejecución)"},
              {internal_id: "3.4.09.09", name: "Reprograma Deuda Vencida + Deuda Vigente (Reprograma con Éxito Según Política Ejecución)"},
              {internal_id: "3.4.09.10", name: "Reprograma Deuda Vigente (Reprograma con Éxito Según Política Ejecución)"},
              {internal_id: "3.4.09.11", name: "Reprograma Deuda Política Cesantía"},
            ]},
            { internal_id: "3.4.10", name: "Solicitud de Certificados Financieros", childs: [
              {internal_id: "3.4.10.01", name: "Certificados no Web - Aclaración de Documentos"},
              {internal_id: "3.4.10.02", name: "Indicación de Certificados Web"},
            ]},
            { internal_id: "3.4.11", name: "Subetudocumento.unab.cl", childs: [
              {internal_id: "3.4.11.01", name: "Alumno Ingresa Sol Descto Web (Cumple Convenio)"},
              {internal_id: "3.4.11.02", name: "Alumno Ingresa Sol Descto Web (No Cumple Convenio)"},
            ]},
            { internal_id: "3.4.12", name: "Descuentos", childs: [
              {internal_id: "3.4.12.01", name: "Descuento no cargado"},
              {internal_id: "3.4.12.02", name: "Información de descuento"},
            ]},
            { internal_id: "3.4.13", name: "Incidencia en arqueo de cajas", childs: [
              {internal_id: "3.4.13.01", name: "Doc. No recibido/con error  (carpeta matrícula)"},
              {internal_id: "3.4.13.02", name: "Mandato faltante/error (PAC-PAT)"},
              {internal_id: "3.4.13.03", name: "Valor Faltante (efectivo)"},
              {internal_id: "3.4.13.04", name: "Valor Faltante/error (Pagaré)"},
              {internal_id: "3.4.13.05", name: "Valor Faltante/error (Cheques al día/a fecha)"},
            ]},
            { internal_id: "3.4.14", name: "Regularización", childs: [
              {internal_id: "3.4.14.01", name: "Ajuste Cuenta Corriente"},
            ]},
          ]},
        ]},
        { internal_id: "4", name: "VRSUAE", childs: [
          { internal_id: "4.1", name: "Academia", childs: [
            { internal_id: "4.1.01", name: "Reglamentaciones"},
            { internal_id: "4.1.02", name: "Retención", childs: [
              { internal_id: "4.1.02.01", name: "Gestión de Retiros Académicos"},
            ]},
          ]},
          { internal_id: "4.2", name: "Alumni", childs: [
            { internal_id: "4.2.01", name: "Servicios Complementarios", childs: [
              { internal_id: "4.2.01.01", name: "Beneficios y Servicios Egresados"},
              { internal_id: "4.2.01.02", name: "Consejo Egresados / Empleadores"},
              { internal_id: "4.2.01.03", name: "Consultas Varias"},
              { internal_id: "4.2.01.04", name: "Deportes y Actividades Extra Programáticas"},
              { internal_id: "4.2.01.05", name: "Intercambio Estudiantil"},
              { internal_id: "4.2.01.06", name: "Pase Escolar Tne"},
              { internal_id: "4.2.01.07", name: "Portal Empleos Unab"},
            ]},
            { internal_id: "4.2.02", name: "Retención", childs: [
              { internal_id: "4.2.02.01", name: "Bolsa de empleo"},
            ]},
          ]},
          { internal_id: "4.3", name: "Campus On-Line", childs: [
            { internal_id: "4.3.01", name: "Acceso a Plataformas", childs: [
              { internal_id: "4.3.01.01", name: "Acceso al Curso"},
              { internal_id: "4.3.01.02", name: "Programas On-Line"},
            ]},
            { internal_id: "4.3.02", name: "Incidencia de Sistema", childs: [
              { internal_id: "4.3.02.01", name: "Cambio Nombre Usuario (Intranet)"}
            ]},
            { internal_id: "4.3.03", name: "Reglamentaciones", childs: [
              { internal_id: "4.3.03.01", name: "Reglamento Interno"}
            ]},
          ]},
          { internal_id: "4.4", name: "Comunicaciones", childs: [
            { internal_id: "4.4.01", name: "Servicios Complementarios", childs: [
              { internal_id: "4.4.01.01", name: "Acreditación" },
              { internal_id: "4.4.01.02", name: "Contingencia Comunicacional" },
            ]}
          ]},
          { internal_id: "4.5", name: "DGDE", childs: [
            { internal_id: "4.5.01", name: "Activ. Extraprogramáticas / Masivas", childs: [
              { internal_id: "4.5.01.01", name: "Guía e Indicaciones"}
            ]},
            { internal_id: "4.5.02", name: "Atención", childs: [
              { internal_id: "4.5.02.01", name: "Disconformidad por Atención" },
              { internal_id: "4.5.02.02", name: "Felicitaciones"},
              { internal_id: "4.5.02.03", name: "Horarios y Ubicación"},
              { internal_id: "4.5.02.04", name: "Servicios Disponibles"},
              { internal_id: "4.5.02.05", name: "Sugerencias"},
            ]},
            { internal_id: "4.5.03", name: "Crea Caso o Retención", childs: [
              { internal_id: "4.5.03.01", name: "Apoyo Psicoeducativo"},
              { internal_id: "4.5.03.02", name: "Atencion Psicologica"},
              { internal_id: "4.5.03.03", name: "Intergracion Universitaria"},
            ]},
            { internal_id: "4.5.04", name: "Deportes, Selecciones Deportivas y Becas", childs: [
              { internal_id: "4.5.04.01", name: "Cupos Deportivos"},
              { internal_id: "4.5.04.02", name: "Información Deporte Generalizado"},
              { internal_id: "4.5.04.03", name: "Postulación Becas"},
              { internal_id: "4.5.04.04", name: "Postulación Selecciones"},
              { internal_id: "4.5.04.05", name: "Resultados Becas"},
              { internal_id: "4.5.04.06", name: "Resultados Selecciones"},
            ]},
            { internal_id: "4.5.05", name: "Pase Escolar/ TNE", childs: [
              { internal_id: "4.5.05.01", name: "Consultas / Reclamos / Dudas Particulares"},
              { internal_id: "4.5.05.02", name: "Inf. por Fechas y Lugares de Entrega"},
              { internal_id: "4.5.05.03", name: "Información de Obtención"},
              { internal_id: "4.5.05.04", name: "Información de Reposición"},
              { internal_id: "4.5.05.05", name: "Información de Revalidación"},
            ]},
            { internal_id: "4.5.06", name: "Talleres Culturales", childs: [
              { internal_id: "4.5.06.01", name: "Inscripción de Talleres"},
              { internal_id: "4.5.06.02", name: "Programación de Talleres"},
            ]},
            { internal_id: "4.5.07", name: "Talleres Deportivos", childs: [
              { internal_id: "4.5.07.01", name: "Inscripción de Talleres"},
            ]},
          ]},
          { internal_id: "4.6", name: "DGSU", childs: [
            { internal_id:"4.6.01", name: "Atención", childs: [
              { internal_id: "4.6.01.01", name: "CIADE"},
              { internal_id: "4.6.01.02", name: "DGMF"},
              { internal_id: "4.6.01.03", name: "Gestión Académica"},
              { internal_id: "4.6.01.04", name: "Operaciones Campus"},
              { internal_id: "4.6.01.05", name: "Servicio"},
            ]},
            { internal_id:"4.6.02", name: "Campus", childs: [
              { internal_id: "4.6.02.01", name: "Casino"},
              { internal_id: "4.6.02.02", name: "Infraestructura"},
              { internal_id: "4.6.02.03", name: "Tecnología"},
            ]},
            { internal_id:"4.6.03", name: "Sala de Profesores", childs: [
              { internal_id: "4.6.03.01", name: "Atención"},
              { internal_id: "4.6.03.02", name: "Servicios Disponibles"},
              { internal_id: "4.6.03.03", name: "Ubicación y Horario"},
            ]},
          ]},
          { internal_id: "4.7", name: "DTI", childs: [
            { internal_id: "4.7.01", name: "Acceso a Plataformas"},
            { internal_id: "4.7.02", name: "Claves de Acceso"},
            { internal_id: "4.7.03", name: "Claves y Accesos Docentes Honorarios", childs: [
              { internal_id: "4.7.03.01", name: "Recuperación de Clave P. Pago Honorarios"},
              { internal_id: "4.7.03.02", name: "Recuperación Presencial de Clave P. Honorarios"},
            ]},
            { internal_id: "4.7.04", name: "Guía de Navegación y Rec. de Accesos", childs: [
              { internal_id: "4.7.04.01", name: "Intranet"},
              { internal_id: "4.7.04.02", name: "Mobile"},
              { internal_id: "4.7.04.03", name: "Plataforma Curriculum Docente"},
              { internal_id: "4.7.04.04", name: "Recuperación de Accesos Intranet"},
              { internal_id: "4.7.04.05", name: "Unab Virtual"},
            ]},
            { internal_id: "4.7.05", name: "Guía Plataforma de Pagos Honorarios", childs: [
              { internal_id: "4.7.05.01", name: "Plataforma Pago Honorarios"}
            ]},
            { internal_id: "4.7.06", name: "Incidencia de Sistema", childs: [
              { internal_id: "4.7.06.01", name: "Cambio Nombre Usuario (Intranet)"},
              { internal_id: "4.7.06.02", name: "Campus On-Line Ispab"},
              { internal_id: "4.7.06.03", name: "Curriculum Docente"},
              { internal_id: "4.7.06.04", name: "Encuesta Docente"},
              { internal_id: "4.7.06.05", name: "Encuestas Generales"},
              { internal_id: "4.7.06.06", name: "Error de Rut"},
              { internal_id: "4.7.06.07", name: "Intranet"},
              { internal_id: "4.7.06.08", name: "Licencias Office"},
              { internal_id: "4.7.06.09", name: "Mobile"},
              { internal_id: "4.7.06.10", name: "Plataforma Campus On-Line"},
              { internal_id: "4.7.06.11", name: "Plataforma Certificados"},
              { internal_id: "4.7.06.12", name: "Plataforma Curriculum Docente"},
              { internal_id: "4.7.06.13", name: "Plataforma Pago Honorarios"},
              { internal_id: "4.7.06.14", name: "Plataforma Titulación"},
              { internal_id: "4.7.06.15", name: "Unab Virtual"},
            ]},
          ]},
          { internal_id: "4.8", name: "Servicio al estudiante", childs: [
            { internal_id: "4.8.01", name: "Rectoría", childs: [
              { internal_id: "4.8.01.01", name: "Caso SERNAC"},
              { internal_id: "4.8.01.02", name: "Casos especiales"},
            ]}
          ]},
          { internal_id: "4.9", name: "MAS (Monitoreo Apoyo y Seguimiento)", childs: [
            { internal_id: "4.9.01", name: "Gestión de Retención", childs: [
              { internal_id: "4.9.01.01", name: "Asesoramiento Integral al Estudiante"},
              { internal_id: "4.9.01.02", name: "Evaluación para Asignación de Apoyos"},
              { internal_id: "4.9.01.03", name: "Gestión por Retiros Académicos"},
              { internal_id: "4.9.01.04", name: "Gestión por Bloqueos Académicos"},
              { internal_id: "4.9.01.05", name: "Gestión por Alertas de Financiamiento"},
              { internal_id: "4.9.01.06", name: "Gestión de Matriculados sin Inscripción de Asignaturas"},
              { internal_id: "4.9.01.07", name: "Gestión de correos MAS"},
            ]},
            { internal_id: "4.9.02", name: "Gestión de Matricula", childs: [
              { internal_id: "4.9.02.01", name: "Asistencia Remota para MOL"},
              { internal_id: "4.9.02.02", name: "Carga de Becas y Crédito"},
              { internal_id: "4.9.02.03", name: "Carga de Descuentos y Convenios"},
              { internal_id: "4.9.02.04", name: "Gestión de Firmas y/o Pagos pendientes MOL"},
            ]},
          ]},
        ]},
        { internal_id: "5", name: "VRDP", childs:[
          { internal_id: "5.1", name: "Advance", childs: [
            { internal_id: "5.1.01", name: "Atención", childs: [
              { internal_id: "5.1.01.01", name: "Admisión"}
            ]}
          ]},
          { internal_id: "5.2", name: "Educación Continua (diploma-cursos)", childs: [
            { internal_id: "5.2.01", name: "Atención", childs: [
              { internal_id: "5.2.01.01", name: "Admisión"}
            ]}
          ]},
          { internal_id: "5.3", name: "In Company (cursos empresas)", childs: [
            { internal_id: "5.3.01", name: "Atención", childs: [
              { internal_id: "5.3.01.01", name: "Admisión"}
            ]}
          ]},
          { internal_id: "5.4", name: "Postgrado", childs: [
            { internal_id: "5.4.01", name: "Atención", childs: [
              { internal_id: "5.4.01.01", name: "Admisión"}
            ]}
          ]},
        ]},
    ].each do |v|
      parent = Category.create(v.except(:childs))
      v[:childs].each do |a|
        parent_1 = Category.create(a.merge(parent: parent).except(:childs))
        a[:childs].each do |b|
          parent_2 = Category.create(b.merge(parent: parent_1).except(:childs))
          b[:childs].each do |c|
            parent_3 = Category.create(c.merge(parent: parent_2).except(:childs))
            c[:childs].each do |d|
              Category.create(d.merge(parent: parent_3))
            end if c.key?(:childs)
          end if b.key?(:childs)
        end if a.key?(:childs)
      end if v.key?(:childs)
    end
    end  
end
  
