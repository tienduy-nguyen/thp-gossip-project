module GossipsHelper
  def all_gossips
    return Gossip.all.order(updated_at: :desc)
  end
end
