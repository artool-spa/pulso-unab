#Person.create(contact_id: '91fbfb09-c93f-e611-83bc-0050549944e8', 
#    full_name: 'CRISTIAN MANUEL FERNANDEZ VASQUEZ', rut: '18117016',
#    phone: '+56227236340', cellphone: '+56974539270', email: 'cristianfervas1992@gmail.com',
#    career: 'INGENIERIA INFORMATICA', campus: 'Estacion central', faculty: 'Facultad de Ingenieria'),

Person.create(id: 10000001, contact_id: '91fbfb09-c93f-e611-83bc-0050549944e8', 
    full_name: 'JEAN PIERE', rut: '11111111',
    phone: '+56227236340', cellphone: '+56974539270', email: 'jp@artool.cl',
    career: 'INGENIERIA INFORMATICA', campus: 'Estacion central', faculty: 'Facultad de Ingenieria')

Person.create(id: 10000002, contact_id: '91fbfb09-c93f-e611-83bc-0050549944e0', 
    full_name: 'OSNER REBETE', rut: '22222222',
    phone: '+56227236340', cellphone: '+56974539270', email: 'orebete@artool.cl',
    career: 'INGENIERIA INFORMATICA', campus: 'Estacion central', faculty: 'Facultad de Ingenieria')

Person.create(id: 10000003, contact_id: '91fbfb09-c93f-e611-83bc-0050549944e2', 
    full_name: 'CRISTIAN FERNANDEZ', rut: '18117016',
    phone: '+56227236340', cellphone: '+56974539270', email: 'cfernandez@artool.cl',
    career: 'PUBLICIDAD', campus: 'Estacion central', faculty: 'Facultad de Ingenieria')

Person.create(id: 10000004, contact_id: '91fbfb09-c93f-e611-83bc-0050549944e2', 
    full_name: 'DANIELA PASTEN', rut: '33333333',
    phone: '+56227236340', cellphone: '+56974539270', email: 'dpasten@artool.cl',
    career: 'PUBLICIDAD', campus: 'Estacion central', faculty: 'Facultad de Ingenieria')
            
Person.create(id: 10000005, contact_id: '91fbfb09-c93f-e611-83bc-0050549944e6', 
    full_name: 'NICOLAS DUJOVNE', rut: '44444444',
    phone: '+56227236340', cellphone: '+56974539270', email: 'ndujovne@artool.cl',
    career: 'INGENIERIA INFORMATICA', campus: 'Estacion central', faculty: 'Facultad de Ingenieria')
            
Person.create(id: 10000006, contact_id: '91fbfb09-c93f-e611-83bc-0050549944e7', 
    full_name: 'JUAN VALENZUELA', rut: '55555555',
    phone: '+56227236340', cellphone: '+56974539270', email: 'jvalenzuela@artool.cl',
    career: 'INGENIERIA INFORMATICA', campus: 'Estacion central', faculty: 'Facultad de Ingenieria')
                
Person.create(id: 10000007, contact_id: '91fbfb09-c93f-e611-83bc-0050549944f8', 
    full_name: 'RICARDO NUÑEZ', rut: '66666666',
    phone: '+56227236340', cellphone: '+56974539270', email: 'rnunez@artool.cl',
    career: 'INGENIERIA INFORMATICA', campus: 'Estacion central', faculty: 'Facultad de Ingenieria')

Person.create(id: 10000008, contact_id: '91fbfb09-c93f-e611-83bc-0050549944f8', 
    full_name: 'NICOLAS ROJAS', rut: '77777777',
    phone: '+56227236340', cellphone: '+56974539270', email: 'nrojas@artool.cl',
    career: 'INGENIERIA INFORMATICA', campus: 'Estacion central', faculty: 'Facultad de Ingenieria')

Person.create(id: 10000009, contact_id: '91fbfb09-c93f-e611-83bc-0050549944f8', 
    full_name: 'JAVIERA ORREGO', rut: '88888888',
    phone: '+56227236340', cellphone: '+56974539270', email: 'jorrego@artool.cl',
    career: 'INGENIERIA INFORMATICA', campus: 'Estacion central', faculty: 'Facultad de Ingenieria')

Person.create(id: 10000010, contact_id: '91fbfb09-c93f-e611-83bc-0050549944f8', 
    full_name: 'DAISY JARA', rut: '99999999',
    phone: '+56227236340', cellphone: '+56974539270', email: 'djara@artool.cl',
    career: 'INGENIERIA INFORMATICA', campus: 'Estacion central', faculty: 'Facultad de Ingenieria')
                                    
#Ticket.create(id: 10000000, crm_ticket_id: 'CAS-100000-D9C2Y5', person_id: 1),

Ticket.create(id: 10000001, crm_ticket_id: 'CAS-21393-S6M6N1', person_id: 10000001, created_time: "2019-04-08 10:30:00")
Ticket.create(id: 10000002, crm_ticket_id: 'CAS-21393-D9F2Y2', person_id: 10000002, created_time: "2019-04-08 11:30:00")
Ticket.create(id: 10000003, crm_ticket_id: 'CAS-21393-F1F2Y3', person_id: 10000003, created_time: "2019-04-08 12:30:00")
Ticket.create(id: 10000004, crm_ticket_id: 'CAS-21393-J2F2Y4', person_id: 10000004, created_time: "2019-04-08 13:30:00")
Ticket.create(id: 10000005, crm_ticket_id: 'CAS-21393-O3F2Y5', person_id: 10000005, created_time: "2019-04-08 15:30:00")
Ticket.create(id: 10000006, crm_ticket_id: 'CAS-21393-L4F2Y6', person_id: 10000006, created_time: "2019-04-08 09:30:00")
Ticket.create(id: 10000007, crm_ticket_id: 'CAS-21393-Q5F2Y7', person_id: 10000007, created_time: "2019-04-08 08:30:00")
Ticket.create(id: 10000008, crm_ticket_id: 'CAS-21393-A6F2Y8', person_id: 10000008, created_time: "2019-04-08 07:30:00")
Ticket.create(id: 10000009, crm_ticket_id: 'CAS-21393-Z7F2Y9', person_id: 10000009, created_time: "2019-04-08 10:35:00")
Ticket.create(id: 10000010, crm_ticket_id: 'CAS-21393-V8F2Y1', person_id: 10000010, created_time: "2019-04-08 11:33:00")

#id	crm_ticket_id	business_owner_unit	business_author_unit	created_by	owner_by	incident_id	income_channel	modify_by	case_phase	category	state	status	priority	case_type	created_time	updated_time	closed_time	mail_send_counts	mail_send_date	person_id	created_at	updated_at
#1	CAS-138314-D9C2Y5	Call Center	Working Adult	ADMINISTRADOR MS DYNAMICS CRM	Equipo Call Center	4346be0c-ef3e-e911-80ed-005056999107	Web	ADMINISTRADOR MS DYNAMICS CRM	NULL	2.1.06 Certificados	Activo	En curso	Normal	Consulta	2019-03-04 23:33:00	2019-03-04 23:33:00	NULL	0	NULL	2	2019-03-05 12:48:22.304887	2019-03-05 12:48:22.304887