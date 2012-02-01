require 'spec_helper'

describe RegistrationsController do
  let(:new_registration) { mock_model(Registration, user: mock_model(User).as_new_record).as_new_record }
  let(:saved_registration) { mock_model(Registration, user: mock_model(User)) }

  describe "GET new" do
    before do
      Registration.stub(:new).and_return(new_registration)
      get :new
    end

    it { should assign_to(:registration).with(new_registration) }
    it { should render_template("new") }
  end

  describe "POST create with invalid arguments" do
    before do
      Registration.stub(:new).with('arguments').and_return(new_registration)
      new_registration.stub(:save).and_return(false)
      post :create, 'registration' => 'arguments'
    end

    it { should assign_to(:registration).with(new_registration) }
    it { should render_template("new") }
  end

  describe "POST create with valid arguments" do
    before do
      Registration.stub(:new).with('arguments').and_return(new_registration)
      new_registration.stub(:save).and_return(true)
      post :create, 'registration' => 'arguments'
    end

    it { should redirect_to(new_registration.user) }
  end
end
