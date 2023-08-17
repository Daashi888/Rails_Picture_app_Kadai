class PicturesController < ApplicationController
  def index
    @pictures = Picture.all
  end

  def new
  if params[:back] 
    @picture = Picture.new(picture_params)
  else
    @picture = Picture.new
  end
end

  def create
    @picture = current_user.pictures.build (picture_params)
    if params[:back]
      render :new
    else
      if @picture.save
        redirect_to pictures_path, notice: "投稿出来ました！"
      else
        render :new
    end
  end
end

  def show
    @picture = Picture.find(params[:id])
  end


  def edit
    @picture = Picture.find(params[:id])
  end

  def update
    @picture = Picture.find(params[:id])
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: "投稿内容を編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    redirect_to pictures_path, notice: "投稿を削除しました！"
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end

  private

  def picture_params
    params.require(:picture).permit(:content, :text, :image, :image_cache)
  end

  def set_picture
    @picture = Picture.find(params[:id])
  end

  def feed_params
    params.require(:picture).permit(:image, :image_cache)
  end
end
