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

  it "creates new user with no completed lesson parts" do
    expect(subject.completed_lesson).to be_nil
    expect(subject.completed_part).to be_nil
  end

  describe "#complete_next_part" do
    context "new student" do
      it "completes the first ever part as lesson 1 part 1" do
        expect {
          subject.complete_next_part
        }.to change { subject.completed_lesson }.from(nil).to(1)
         .and change { subject.completed_part }.from(nil).to(1)
      end

      it "completes the 2nd part as lesson 1 part 2" do
        subject.completed_lesson, subject.completed_part = 1, 1

        expect {
          subject.complete_next_part
        }.to change { subject.completed_lesson }.by(0)
         .and change { subject.completed_part }.from(1).to(2)
      end

      it "completes the 4th part as lesson 2 part 1" do
        subject.completed_lesson, subject.completed_part = 1, 3

        expect {
          subject.complete_next_part
        }.to change { subject.completed_lesson }.from(1).to(2)
         .and change { subject.completed_part }.from(3).to(1)
      end

      it "doesn't complete further than lesson 100 part 3" do
        subject.completed_lesson, subject.completed_part = 100, 3

        expect {
          subject.complete_next_part
        }.to change { subject.completed_lesson }.by(0)
         .and change { subject.completed_part }.by(0)
      end
    end
  end
end
