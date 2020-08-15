class StaticPagesController < ApplicationController
  include SessionsHelper
  include GossipsHelper

  def team
  end

  def contact
  end

  def home
    @first_name = params[:first_name] 
    @lastest_gossips = Gossip.all.limit(16)
    @gossips = Gossip.limit(15).order('updated_at DESC')
  end

end
