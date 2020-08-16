class CommentsController < ApplicationController
  include SessionsHelper
  
  before_action :logged_in_user

  # GET comments/new
  def new
    @comment = Comment.new
  end

  def create
    if !comment_params[:gossip_id].nil?
      Comment.create(user: current_user, 
        commentable: Gossip.find(comment_params[:gossip_id]),  
        content: comment_params[:content])
    elsif !comment_params[:comment_id].nil?
      Comment.create(user: current_user, 
        commentable: Comment.find(comment_params[:comment_id]), 
        content: comment_params[:content])
    end
    redirect_back(fallback_location: gossips_path)
  end


  private

  def comment_params
    params.require(:comment).permit(:content, :gossip_id,  :comment_id)
  end

end
