class EditPublicPageController < ApplicationController
  def index
    if !flash[:error].present? || !flash[:error].present?
    @current_user ||= User.find_by(user_id: session[:user_id])
    if @current_user.nil?
      redirect_to login_url
    else
      @user = @current_user
    end
  end

  end

  def update
    @current_user ||= User.find_by(user_id: session[:user_id])
    if @current_user.nil?
      redirect_to login_url
    else
       if @current_user.update(user_params)
        redirect_to edit_public_page_path, notice: 'Public page was successfully updated.'
      else
        flash.now[:error] = @current_user.errors.full_messages.to_sentence
        redirect_to edit_public_page_path
       end
    end
  end

  private

  def user_params
    params.require(:user).permit(:fname, :lname, :about, :username)
  end
end
