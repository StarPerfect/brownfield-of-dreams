# frozen_string_literal: true

class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    binding.pry
    # <ActionController::Parameters {"utf8"=>"✓", "authenticity_token"=>"uOQ6TsJ7SZ478E96BHHCwGNqxMAwpP4XoRPCO8UBmntmtgJxinOWEnI4sSWkBO2rEfxfXH5AyAzbjF/xpqEPKQ==",
    #    "tutorial"=>{"title"=>"Hello",
    #      "description"=>"Something",
    #      "thumbnail"=>"https://www.youtube.com/watch?v=AXpuu8IXdm4&list=PLOU8Lmsz4j5Hw1gDqwUgcE20n8Q0WR4er&index=7&t=4s"
    #      }, "commit"=>"Save",
    #      "controller"=>"admin/tutorials",
    #      "action"=>"create"
    #      } permitted: false>
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end
end
