class LikesController < ApplicationController
  include GossipsHelper
  include SessionsHelper

  def create
    # Like gossip
    if params[:gossip_id]
      gossip = Gossip.find(params[:gossip_id])
      if current_user.already_liked?(gossip)
        Like.where(user_id: current_user.id, gossip_id: gossip.id).destroy_all
      else
        gossip.likes.create(user_id: current_user.id)
      end
    
      # Like comments
    elsif params[:comment_id]
      comment = Comment.find(params[:comment_id])
      if current_user.already_liked?(comment)
        Like.where(user_id: current_user.id, comment_id: comment.id).destroy_all
      else
        comment.likes.create(user_id: current_user.id)
      end
    end
   
    redirect_back(fallback_location: gossips_path)
    # redirect_to(request.env['HTTP_REFERER'])
  end




end
