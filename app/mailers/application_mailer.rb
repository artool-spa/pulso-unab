class ApplicationMailer < ActionMailer::Base
  default(from: "UNAB <no-reply@artool.cl>")
  layout 'mailer'
end
