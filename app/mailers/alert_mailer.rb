class AlertMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.alert_mailer.exception_msg.subject
  #
  def exception_msg(person, m_type = nil)
    @person = person
    @m_type = m_type
    mail(subject: "Encuesta UNAB: #{@m_type}")
  end

  def testing_mail(m_type = nil)
    @m_type = m_type
    mail(subject: "Encuesta UNAB: #{@m_type}")
  end
end
