# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'CRUD' do
    it 'can be delete and a video associated with is deleted' do
      tutorial_1 = Tutorial.create(id: 1)
      video = Video.create(id: 1, tutorial_id: 1)

      tutorial_1.destroy

      expect(tutorial_1.destroyed?).to eq(true)
      expect(Video.where(tutorial_id: tutorial_1.id)).to eq([])
    end
  end
end
