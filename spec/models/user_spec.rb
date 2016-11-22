require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'create' do
    it 'should be created correctly.' do
      expected_name = 'name'
      user = User.new
      user.name = expected_name
      user.save

      saved_user = User.find_by(name: expected_name)
      expect(saved_user.name).to eq(expected_name)
    end
  end
end
