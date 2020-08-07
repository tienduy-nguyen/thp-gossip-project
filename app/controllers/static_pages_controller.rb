class StaticPagesController < ApplicationController
  include SessionsHelper
  include GossipsHelper

  def team
  end

  def contact
  end

  def home
    @first_name = params[:first_name] 
    @gossips = all_gossips.take(30)
    @lastest_gossips = @gossips.take(16)
  end

end
