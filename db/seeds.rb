#Person.create(contact_id: '91fbfb09-c93f-e611-83bc-0050549944e8', 
#    full_name: 'CRISTIAN MANUEL FERNANDEZ VASQUEZ', rut: '18117016',
#    phone: '+56227236340', cellphone: '+56974539270', email: 'cristianfervas1992@gmail.com',
#    career: 'INGENIERIA INFORMATICA', campus: 'Estacion central', faculty: 'Facultad de Ingenieria'),
Person.create(id: 10000001, contact_id: '91fbfb09-c93f-e611-83bc-0050549944e8', 
    full_name: 'JEAN PIERE', rut: '11111111',
    phone: '+56227236340', cellphone: '+56974539270', email: 'jp@artool.cl',
    career: 'INGENIERIA INFORMATICA', campus: 'Estacion central', faculty: 'Facultad de Ingenieria')
Person.create(id: 10000002, contact_id: '91fbfb09-c93f-e611-83bc-0050549944e8', 
    full_name: 'OSNER REBETE', rut: '18117016',
    phone: '+56227236340', cellphone: '+56974539270', email: 'orebete@artool.cl',
    career: 'INGENIERIA INFORMATICA', campus: 'Estacion central', faculty: 'Facultad de Ingenieria')
#Ticket.create(id: 10000000, crm_ticket_id: 'CAS-100000-D9C2Y5', person_id: 1),
Ticket.create(id: 10000001, crm_ticket_id: 'CAS-21393-S6M6N7', person_id: 10000001)
Ticket.create(id: 10000002, crm_ticket_id: 'CAS-100002-D9F2Y7', person_id: 10000002)

#id	crm_ticket_id	business_owner_unit	business_author_unit	created_by	owner_by	incident_id	income_channel	modify_by	case_phase	category	state	status	priority	case_type	created_time	updated_time	closed_time	mail_send_counts	mail_send_date	person_id	created_at	updated_at
#1	CAS-138314-D9C2Y5	Call Center	Working Adult	ADMINISTRADOR MS DYNAMICS CRM	Equipo Call Center	4346be0c-ef3e-e911-80ed-005056999107	Web	ADMINISTRADOR MS DYNAMICS CRM	NULL	2.1.06 Certificados	Activo	En curso	Normal	Consulta	2019-03-04 23:33:00	2019-03-04 23:33:00	NULL	0	NULL	2	2019-03-05 12:48:22.304887	2019-03-05 12:48:22.304887