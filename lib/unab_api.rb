class UnabApi

  def initialize
    @client = Savon.client(wsdl: 'http://200.29.164.74:8059/WS_CRMContactosCasos.asmx?WSDL')
  end

  def get_client_by_rut(rut)
    rut = rut.strip.remove('.', '_', ' ').upcase!
    response = @client.call(:wm_find_by_rut, message: { rutContacto: rut })
    response.body[:wm_find_by_rut_response][:wm_find_by_rut_result][:output]
  end

  def get_ticket_created(date)
    response = @client.call(:wm_get_ticket_created, message: { date: date })
    response.body[:wm_get_ticket_created_response][:wm_get_ticket_created_result][:output]
  end

  def get_ticket_closed(date)
    response = @client.call(:wm_get_ticket_closed, message: { date: date })
    response.body[:wm_get_ticket_closed_response][:wm_get_ticket_closed_result][:output]
  end

  def get_ticket_managed(date)
    response = @client.call(:wm_get_ticket_managed, message: { date: date })
    response.body[:wm_get_ticket_managed_response][:wm_get_ticket_managed_result][:output]
  end
  
end
