module TodolistResponse
  
  def todo_list_response(obj)
    render json: obj, include: {todo_tasks: {only: [:title, :completed]}}, except: [:created_at, :updated_at]
  end

end