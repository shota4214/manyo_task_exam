class TasksController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @tasks = Task.all.order("#{sort_column} #{sort_direction}")
    if params[:search].present?
      if params[:search][:title].present? && params[:search][:status].present?
        @tasks = Task.where("title LIKE ? AND status::text LIKE ?", "%#{params[:search][:title]}%", "%#{params[:search][:status]}%")
      elsif params[:search][:title].present?
        @tasks = Task.where("title LIKE ?", "%#{params[:search][:title]}%")
      elsif params[:search][:status].present?
        @tasks = Task.where(status: params[:search][:status])
      end
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to tasks_path, notice: "タスクを作成しました！"
      else
        render :new
      end
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました"
  end

  def confirm
    @task = Task.new(task_params)
    render :new if @task.invalid?
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :status, :priority)
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : 'deadline'
  end

end
