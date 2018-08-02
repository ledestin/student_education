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

  describe "#complete" do
    it "returns true on successful completion" do
      expect(subject.complete(1, 1)).to eq true
    end

    it "returns true it can't complete" do
      expect(subject.complete(1, 2)).to eq false
    end

    context "no parts were completed" do
      it "can complete to lesson 1 part 1" do
        expect {
          subject.complete(1, 1)
        }.to change { subject.completed_lesson }.from(nil).to(1)
         .and change { subject.completed_part }.from(nil).to(1)
      end

      it "can't complete further than 1 chapter ahead" do
        it_cant_complete_to(1, 2)
      end
    end

    context "1 part was completed" do
      it "can complete the 2nd part as lesson 1 part 2" do
        subject.completed_lesson, subject.completed_part = 1, 1

        expect {
          subject.complete(1, 2)
        }.to change { subject.completed_lesson }.by(0)
         .and change { subject.completed_part }.from(1).to(2)
      end

      it "can't complete further than 1 chapter ahead" do
        subject.completed_lesson, subject.completed_part = 1, 1

        it_cant_complete_to(1, 3)
      end
    end

    context "1 lesson was completed (is at part 3)" do
      it "can complete the 4th part as lesson 2 part 1" do
        subject.completed_lesson, subject.completed_part = 1, 3

        expect {
          subject.complete(2, 1)
        }.to change { subject.completed_lesson }.from(1).to(2)
         .and change { subject.completed_part }.from(3).to(1)
      end

      it "can't complete further than 1 chapter ahead" do
        subject.completed_lesson, subject.completed_part = 1, 3

        it_cant_complete_to(2, 2)
      end
    end

    context "all lessons completed" do
      it "can't complete further than the last lesson" do
        subject.completed_lesson, subject.completed_part = 100, 3

        it_cant_complete_to(101, 1)
      end

      it "can't complete backwards" do
        subject.completed_lesson, subject.completed_part = 100, 3

        it_cant_complete_to(99, 3)
      end
    end

    private

    def it_cant_complete_to(lesson, part)
      expect {
        progress = subject.dup
        progress.complete(lesson, part)
      }.not_to change { subject.completed_lesson }
      expect {
        progress = subject.dup
        progress.complete(lesson, part)
      }.not_to change { subject.completed_part }
    end
  end
end
