# encoding: utf-8
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  #protect_from_forgery with: :null_session
  skip_before_action :check_permissions

  def google_oauth2
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Cuenta de Artool'
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.google_data'] = request.env['omniauth.auth'].except(:extra) # Removing extra as it can overflow some session stores
      redirect_to new_user_session_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  def failure
    redirect_to new_user_session_path, notice: "Error autenticando usuario"
  end
end
