require 'digest'
require 'date'
require 'net/http'

class UnabIvr
  def get_ivr_data
    hours = 0
    
    today = Time.new - hours*60*60
    today = today.localtime
    puts("> "+today.to_s)

    month = today.mon.to_s
    day = today.mday.to_s
    year = today.year.to_s
    hour = today.hour.to_s

    time = day+month+year+hour
    hash = Digest::SHA256.hexdigest(time+"unab.2018")

    url = URI.parse("http://epa.mets.cl/unab/index.php?t=" + time + "&h=" + hash)
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) { |http|
      http.request(req)
    }
  end
end
