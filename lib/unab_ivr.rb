require 'digest'
require 'date'
require 'net/http'

class UnabIvr
  def initialize
    @client = Savon.client(wsdl: 'https://neotel.unab.cl/neoapi/webservice.asmx?WSDL')
    #@contact = Savon.client(wsdl: 'http://200.29.164.74:8059/WS_CRMContactosCasos.asmx?WSDL')
  end

  def get_ivr_data(idTask, param1, param2)
    response = @client.call(:execute_task02, message: { idTask: idTask, param1: param1, param2: param2 })
    response.body[:execute_task02_response][:execute_task02_result]
  end

  # def get_ivr_data(date)
  #   #server_offset = 0
  #   #time = (Time.now - server_offset.hours).strftime("%d%m%Y%H")
  #   time = Time.now.utc.strftime("%d%m%Y%H")
  #   hash = Digest::SHA256.hexdigest(time+"unab.2018")
  #   #2602201914
  #   #timeParam = "28022019"
  #   timeParam = date.to_date.strftime("%d%m%Y")
  #   #puts("> "+time)

  #   url = URI.parse("http://epa.mets.cl/unab/index.php?t=" + timeParam + "&h=" + hash)
  #   req = Net::HTTP::Get.new(url.to_s)
  #   res = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
  # end
end
