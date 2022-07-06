module TasksHelper
  def choose_new_or_edit
    if action_name == 'new' || action_name == 'create'
      confirm_tasks_path
    elsif action_name == 'edit'
      task_path
    end
  end

  def sort_order(column, view_title)
    direction = (column == sort_column && sort_direction == 'asc') ? 'desc' : 'asc'
    link_to view_title, { sort: column, direction: direction }
  end
end
