# frozen_string_literal: true

class TutorialsController < ApplicationController
  def index
    @tutorials = Tutorial.all
  end

  def show
    tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(tutorial, params[:video_id])
  end
end
