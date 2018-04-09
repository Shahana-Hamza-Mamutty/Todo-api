class CreateTodoTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :todo_tasks do |t|
      t.string :title
      t.references :todo_list, foreign_key: true
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
