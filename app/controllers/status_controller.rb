class StatusController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :check_permissions 
  def index
    h = { "data" => [{ "rut" => "1 - 9", "id_ticket" => "12345", "answer" => true, "answer_details" => { "option1" => "texto", "option2" => "texto", "option3" => "texto"}}, { "rut" => "2 - 8", "id_ticket" => "12345", "answer" => true, "answer_details" => { "option1" => "texto", "option2" =>  "texto", "option3" => "texto"}} ], "status" => "success"}
    render(json: h.to_json)
  end
end