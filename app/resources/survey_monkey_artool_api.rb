module SurveyMonkeyArtoolApi
  class Base < JsonApiClient::Resource
    self.site = "https://sm-api.artool.cl/api/"
  end

  class SmSurvey < Base
    def self.table_name
      "sm-survey"
    end
    #has_many :graded_answers
  end

  class GradedAnswer < Base
    def self.table_name
      "graded-answers"
    end
    #belongs_to :sm_survey
  end

  class OpenAnswer < Base
    def self.table_name
      "open-answers"
    end
    #belongs_to :sm_survey
  end

end

SurveyMonkeyArtoolApi::Base.connection do |conn|
  conn.use Faraday::Request::Authorization, 'JWT', "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.kQ7CHVFirjJJD4oCW0XcjCoXKHMChW6kiWx8vPVSbsk"
  #conn.use Faraday::Response::Logger
end
