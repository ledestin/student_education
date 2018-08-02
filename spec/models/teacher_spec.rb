require 'rails_helper'

RSpec.describe Teacher, type: :model do
  subject { Teacher.new name: "Joker" }

  it { is_expected.to have_many(:students) }
  it { is_expected.to validate_uniqueness_of(:name) }
end
