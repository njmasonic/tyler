class UsersController < Clearance::UsersController
  def show
    #TODO: Ensure that only the logged-in user can see their own user page
    @user = current_user
  end
end
