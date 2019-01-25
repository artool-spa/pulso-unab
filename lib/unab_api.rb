class UnabApi

  def initialize
    @client = Savon.client(wsdl: 'http://200.29.164.74:8059/WS_CRMContactosCasos.asmx?WSDL')
  end

  def get_client_by_rut(rut)
    response = @client.call(:wm_find_by_rut, message: { rutContacto: rut })
  end

  def get_ticket_created(date)
    response = @client.call(:wm_get_ticket_created, message: { date: date })
  end

  def get_ticket_closed(date)
    response = @client.call(:wm_get_ticket_closed, message: { date: date })
  end

  def get_ticket_managed(date)
    response = @client.call(:wm_get_ticket_managed, message: { date: date })
  end
  
end
