  # require 'rails_helper'
  #
  # RSpec.describe "Users", type: :request do
  #   describe "new user creation" do
  #     let(:user_params) {{email: 'Mr.Ross@gmail.com', first_name: 'Bob', last_name: 'Ross', password: 'HappyTree'}}
  #     it "sends an email" do
  #       expect { post users_path(user_params) }
  #         .to change { ActionMailer::Base.deliveries.count }.by(1)
  #     end
  #     it "creates a new user with an inactive status" do
  #       expect { post users_path(user_params) }
  #         .to change { User.count }.by(1)
  #       expect(User.last.status).to eq("inactive")
  #     end
  #   end
  # end
