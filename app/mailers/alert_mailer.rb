class AlertMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.alert_mailer.exception_msg.subject
  #
  def send_mail(person, ticket, m_type = nil, custom_msg = nil, tracker_id)
    @person = person
    @ticket = ticket
    @m_type = m_type
    @tracker_id = tracker_id
    @custom_msg = custom_msg
    mail(subject: "Encuesta UNAB: #{@m_type}", to: person.email)
  end

  def send_mail_err(err, m_type = nil)
    @err = err
    @m_type = m_type
    mail(subject: "Error UNAB #{@m_type}", to: "dev@artool.cl", body: err, content_type: "text/html")
  end

  def send_mail_success(result)
    mail(subject: "Proceso correos UNAB", to: "dev@artool.cl", body: result, content_type: "text/html")
  end

  def testing_mail(m_type = nil)
    @m_type = m_type
    mail(subject: "Encuesta UNAB: #{@m_type}", to: person.email)
  end
end
