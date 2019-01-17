class UsersController < ApplicationController
  def index
		@users = User.all.where("id != ?", current_user.id)
  end
end