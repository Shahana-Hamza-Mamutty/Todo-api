module Api
  module V1

    class TodoListsController < ApplicationController

      def index
        todo_list_response(TodoList.all.order('created_at desc'))
      end

      def create
         todo_list = TodoList.new(todo_list_params)
        if todo_list.save
          todo_list_response(todo_list)
        else
          raise ValidationFailed
        end
      end

      def show
        todo_list = TodoList.find_by_id(params[:id])
        if todo_list
          todo_list_response(todo_list)
        else
          raise RecordNotFound
        end
      end

      def update
        todo_list = TodoList.find_by_id(params[:id])
        if todo_list
          if todo_list.update_attributes(todo_list_params)
            todo_list_response(todo_list)
          else
            if todo_list.errors
              raise ValidationFailed
            else
              raise UnexpectedError
            end
          end
        else
          raise RecordNotFound
        end
      end

      def add_task
        todo_list = TodoList.find_by_id(params[:id])
        if todo_list
          todo_task = TodoTask.new(title: params[:title], completed: params[:completed], todo_list_id: todo_list.id)
          if todo_task.save
            todo_list_response(todo_list)
          else
            raise ValidationFailed
          end
        else
          raise RecordNotFound
        end
      end

      def destroy
        todo_list = TodoList.find_by_id(params[:id])
        if todo_list
          if todo_list.destroy
            render json: {msg: "Successfully deleted record", status: "Success"}
          else
            raise UnexpectedError
          end
        else
          raise RecordNotFound
        end
      end

      private

      def todo_list_params
        params.permit(:title, :description)
      end

    end
  end
end
