class AlertMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.alert_mailer.exception_msg.subject
  #
  def send_mail(person, ticket, m_type = nil)
    @person = person
    @ticket = ticket
    @m_type = m_type
    mail(subject: "Encuesta UNAB: #{@m_type}", to: person.email)
  end

  def testing_mail(m_type = nil)
    @m_type = m_type
    mail(subject: "Encuesta UNAB: #{@m_type}", to: person.email)
  end
end
