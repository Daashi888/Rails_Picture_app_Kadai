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
        ContactMailer.contact_mail(@picture).deliver
        redirect_to pictures_path, notice: "投稿出来ました！"
      else
        render :new
    end
  end
end

  def show
    @picture = Picture.find(params[:id])
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end


  def edit
    @picture = Picture.find(params[:id])
    if current_user.id != @picture.user_id
      redirect_to pictures_path, notice: "他人の投稿は編集できません！"
    end
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
    params.require(:picture).permit(:content, :text, :image, :image_cache, :name, :email)
  end

  def set_picture
    @picture = Picture.find(params[:id])
  end

  def feed_params
    params.require(:picture).permit(:image, :image_cache)
  end
end

