class LabelsController < ApplicationController
  before_action :set_label, only:[:show, :edit, :destroy, :update]
  before_action :logg_in_check

  def new
    @label = Label.new
  end

  def create
    @label = current_user.labels.build(label_params)
    if @label.save
      redirect_to labels_path, notice: "ラベルを保存しました"
    else
      render 'new'
    end
  end

  def show
  end

  def index
    @labels = current_user.labels.all
  end

  def edit
  end

  def update
    if @label.update(label_params)
      redirect_to labels_path, notice: "ラベルを編集しました"
    else
      render 'edit'
    end
  end

  def destroy
    @label.destroy
    redirect_to labels_path, notice: "labelを削除しました"
  end

  private

  def set_label
    @label = Label.find_by(id: params[:id])
  end

  def label_params
    params.require(:label).permit(:name, :content)
  end
  
  def logg_in_check
    unless logged_in?
      redirect_to new_session_path,notice: "ログインまたはサインアップしてください"
    end
  end

end

