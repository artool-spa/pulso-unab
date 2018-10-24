class AlertMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.alert_mailer.exception_msg.subject
  #
  def exception_msg(exception, m_type = nil)
    @exception = exception
    @m_type = m_type

    mail(subject: "¡Excepción Detectada!: #{@m_type}")
  end
end
