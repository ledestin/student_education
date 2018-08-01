require 'rails_helper'

RSpec.describe Student, type: :model do
  it { is_expected.to belong_to(:teacher) }
  it { is_expected.to validate_inclusion_of(:completed_lesson).in_range(1..100) }
  it { is_expected.to validate_inclusion_of(:completed_part).in_range(1..3) }

  it "fails validation if completed_lesson is set and completed_part isn't" do
    subject.completed_lesson = 1

    expect(subject).to have(1).errors_on(:completed_lesson)
  end

  it "fails validation if completed_part is set and completed_lesson isn't" do
    subject.completed_part = 1

    expect(subject).to have(1).errors_on(:completed_lesson)
  end
end
