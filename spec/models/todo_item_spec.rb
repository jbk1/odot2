require 'rails_helper'

describe TodoItem do
       it { should belong_to(:todo_list) }
end

# RSpec.describe TodoItem, type: :model do
#     it { should belong_to(:todo_list) }
# # pending "add some examples to (or delete) #{__FILE__}"
# end