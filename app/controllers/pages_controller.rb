class PagesController < ApplicationController
  def home
    redirect_to todo_lists_path and return if user_signed_in?
    render layout: 'home'
  end
end
