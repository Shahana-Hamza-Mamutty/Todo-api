require 'rails_helper'

RSpec.describe TodoTask, type: :model do
  it { should belong_to(:todo_list) }
end
