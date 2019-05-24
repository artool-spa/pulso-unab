require 'digest'
require 'date'
require 'net/http'

class UnabIvr
  def get_ivr_data(date)
    #server_offset = 0
    #time = (Time.now - server_offset.hours).strftime("%d%m%Y%H")
    time = Time.now.utc.strftime("%d%m%Y%H")
    hash = Digest::SHA256.hexdigest(time+"unab.2018")
    #2602201914
    #timeParam = "28022019"
    timeParam = date.to_date.strftime("%d%m%Y")
    puts("> "+time)

    url = URI.parse("http://epa.mets.cl/unab/index.php?t=" + timeParam + "&h=" + hash)
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
  end
end
