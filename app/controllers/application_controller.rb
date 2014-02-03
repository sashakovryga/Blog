class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #before_filter :authorize
  protect_from_forgery with: :exception
   def has_role?(current_user, role)
    return !!current_user.roles.find_by_name(role.to_s)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to store_url, :alert => exception.message
  end

  protected

  def authorize
  		redirect_to new_user_session_path, notice: "Войдите на сайт чтобы просмотреть эту страницу" if !user_signed_in?
	end



end
