class ApplicationMailer < ActionMailer::Base
  default(from: "Artool <no-reply@artool.cl>", to: 'jp@artool.cl')
  layout 'mailer'
end
