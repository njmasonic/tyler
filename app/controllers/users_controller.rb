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

  #def create
  #  @user = User.new params[:user]
  #  invite_code = params[:invite_code]
  #  @invite = Invite.find_redeemable(invite_code)

  #  if invite_code && @invite
  #    if @user.save
  #      @invite.redeemed!
  #      ClearanceMailer.deliver_confirmation @user
  #      flash[:notice] = "You will receive an email within the next few minutes. " <<
  #      "It contains instructions for confirming your account."
  #      redirect_to url_after_create
  #    else
  #      render :action => "new"
  #    end
  #  else
  #    flash.now[:notice] = "Sorry, that code is not redeemable"
  #    render :action => "new"
  #  end
  #end
end
