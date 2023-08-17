class PicturesController < ApplicationController
  def index
    @picture = Picture.all
  end

  def new
    @picture = Picture.new
  end

  def create
    redirect_to pictures_path, notice: "投稿出来ました！"
  end
end
