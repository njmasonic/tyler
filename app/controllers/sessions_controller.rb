class SessionsController < Clearance::SessionsController
  def new
    consumer = fetch_consumer(params[:consumer])
    if current_user
      redirect_after_sign_in(current_user, consumer)
    else
      render 'new'
    end
  end

  def create
    consumer = fetch_consumer(params[:session][:consumer])
    user = authenticate(params)
    if user.nil?
      flash_failure_after_create
      render 'new', :status => :unauthorized
    else
      sign_in(user)
      redirect_after_sign_in(user, consumer)
    end
  end

  private

  def redirect_after_sign_in(user, consumer)
    if consumer
      redirect_to_consumer(consumer, user)
    else
      redirect_to(user)
    end
  end

  def fetch_consumer(name)
    if name.nil? || name.empty?
      nil
    else
      consumer = Consumer.find_by_name(name)
      raise "Invalid consumer #{name} was provided." if consumer.nil?
      consumer
    end
  end

  def fetch_token(consumer, user)
    Token.find_or_create_by_consumer_id_and_user_id(consumer, user)
  end

  def redirect_to_consumer(consumer, user)
    token = fetch_token(consumer, user)
    token.ensure_current!
    redirect_to "#{consumer.return_url}?token=#{token.token}"
  end
end
