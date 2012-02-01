require 'spec_helper'

describe UsersController do
  let(:user) { mock_model(User, id: '12') }

  describe "GET show" do
    before do
      controller.stub(:current_user).and_return(user)
      get :show, 'id' => '12'
    end

    it { should assign_to(:user).with(user) }
    it { should render_template("show") }
  end
end
