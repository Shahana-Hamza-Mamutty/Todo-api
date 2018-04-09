require 'rails_helper'

RSpec.describe TodoList, type: :model do
 # Association test
  # ensure Todo model has a 1:m relationship with the Item model
  it { should have_many(:todo_tasks).dependent(:destroy) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:title) }
end
