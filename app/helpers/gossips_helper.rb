module GossipsHelper
  include SessionsHelper
  def all_gossips
    return Gossip.all.order(updated_at: :desc)
  end
  
  def find_like(gossip)
    Like.where(user_id: current_user.id, gossip_id: gossip.id).first
  end
  def user_liked_class(object)
    current_user.already_liked?(object) ? "user-liked" : ""
  end
end
