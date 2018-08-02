class Teacher < ApplicationRecord
  has_many :students

  validates_uniqueness_of :name
end
