class Student < ApplicationRecord
  belongs_to :teacher, required: false
end
