class StaticPagesController < ApplicationController
  before_action :request_path
  def top
    @recent_ramen_stores = RamenStore.includes(:user).order(created_at: :desc).limit(3)
    return unless params[:tag_name]

    @recent_ramen_stores = RamenStore.tagged_with(params[:tag_name].to_s).page(params[:page])
  end

  def request_path
    @path = controller_path + '#' + action_name
    def @path.is(*str)
      str.map { |s| include?(s) }.include?(true)
    end
  end
end
