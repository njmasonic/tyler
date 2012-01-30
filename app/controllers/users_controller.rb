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

  private

  def flash_failure_after_create
    message = "Unable to register for an account."
    @user.errors.full_messages.each do |error|
      message += " " + error + "."
    end
    flash.now.notice = message.html_safe
  end
end
