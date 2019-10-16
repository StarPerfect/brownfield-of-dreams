require 'rails_helper'

RSpec.describe 'As a registered user' do
  describe 'when I visit my dashboard' do
    it 'I can see my bookmaked videos' do
      tutorial_1= create(:tutorial, title: "How to Tie Your Shoes")
      tutorial_2= create(:tutorial, title: "How to Make a Sandwich")
      tutorial_3= create(:tutorial, title: "How to Clean Your Room")
      video_1 = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial_1)
      video_2 = create(:video, title: "Loop and Scoop", tutorial: tutorial_1, position: 1)
      video_3 = create(:video, title: "Two Slices of Bread", tutorial: tutorial_2)
      user = create(:user)
      user_video_1 = user.user_videos.create!(video_id: video_1.id)
      user_video_2 = user.user_videos.create!(video_id: video_2.id)
      user_video_3 = user.user_videos.create!(video_id: video_3.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page).to have_content("Bookmarked Segments")

      within(page.all(".bookmarks")[0]) do
        expect(page).to have_css(".title")
        expect(page).to have_content("The Bunny Ears Technique")
      end

      within(page.all(".bookmarks")[1]) do
        expect(page).to have_css(".title")
        expect(page).to have_content("Loop and Scoop")
      end

      within(page.all(".bookmarks")[2]) do
        expect(page).to have_css(".title")
        expect(page).to have_content("Two Slices of Bread")
      end
    end
  end
end
