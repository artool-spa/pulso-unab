class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :check_permissions

  protected

    def check_permissions
      redirect_to(root_path) && return unless current_user.is_admin
    end

    def raw_query(query, params)
      ActiveRecord::Base.connection.exec_query(
        ActiveRecord::Base.send(:sanitize_sql_array, [query] + params)
      )
    end
end
