class UsersController < Clearance::UsersController
  def new
    @registration_properties = APP_CONFIG["registration_properties"]
    raise "Unable to locate registration_properties configuration." if @registration_properties.nil?
    super
  end

  def create
    @registration_properties = APP_CONFIG["registration_properties"]
    super
  end

  def show
    @user = current_user
  end
end
