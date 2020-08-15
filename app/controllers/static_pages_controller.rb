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
    @gossips = Gossip.paginate(page: params[:page], per_page: 18).order('updated_at DESC')
  end

end
