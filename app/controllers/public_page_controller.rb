# frozen_string_literal: true

class PublicPageController < ApplicationController
  def show
    @username = params[:username]
    @user = User.find_by(fname: @username)
    if @user.present?
      @services = Service.all
      render 'public_page/user_public_page'
    else
      render 'public_page/user_not_found'
    end
  end
end
