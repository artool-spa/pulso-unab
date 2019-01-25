class Notifier < ActionMailer::Base
  default from: 'noreply@company.com'
  layout "mailer"
  def instructions(user)
    #@name = user.name
    #@confirmation_url = confirmation_url(user)
    mail to: user.email, subject: 'Instructions', body: 'body_mail'
    end
end
  