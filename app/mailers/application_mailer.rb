class ApplicationMailer < ActionMailer::Base
  default(from: "UNAB <no-reply@artool.cl>", to: 'cfernandez@artool.cl')
  layout 'mailer'
end
