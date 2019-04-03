class TasksController < ApplicationController
  before_action :set_task,only:[:edit,:update,:show,:destroy]

  def index
    if params[:sort_expired]
      @tasks = Task.order(:expired_at)
    else
      @tasks = Task.order(:created_at)
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path,notice: "タスクを登録しました"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path,notice:"タスクを編集しました"
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @task.destroy
    redirect_to tasks_path,notice: "タスクを消去しました"
  end

  private

  def task_params
    req = params.require(:task).permit(:name,:content,:'expired_at(1i)',:'expired_at(2i)',:'expired_at(3i)',:'expired_at(4i)',:'expired_at(5i)')
    name = req[:name]
    content = req[:content]
    year = req[:'expired_at(1i)'].to_i
    month = req[:'expired_at(2i)'].to_i
    day = req[:'expired_at(3i)'].to_i
    hour = req[:'expired_at(4i)'].to_i
    minutes = req[:'expired_at(5i)'].to_i
    expired = DateTime.new(year,month,day,hour,minutes)
    { name: name, content: content,expired_at: expired }
  end

  def set_task
    begin
      @task = Task.find(params[:id])
    rescue
      redirect_to tasks_path, notice: "無効な入力です。"
    end
  end

end
