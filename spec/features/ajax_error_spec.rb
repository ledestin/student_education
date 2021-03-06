require "rails_helper"

feature "Show an error on AJAX failure", js: true do
  include_context :fail_api_requests

  let(:error_text) { "Server error" }

  scenario "AJAX doesn't fail, no error" do
    visit "/"
    wait_for_ajax

    expect(page).not_to have_text(error_text)
  end

  scenario "AJAX fails, there's error message" do
    setup_teachers_api_to_fail
    visit "/"
    wait_for_ajax

    expect(page).to have_text(error_text)
  end

  scenario "Error shows for home page, then clears on student report page" do
    teacher = create :teacher, name: "Batman"

    setup_teachers_api_to_fail
    visit "/"
    wait_for_ajax

    expect(page).to have_text(error_text)

    visit "/#/teachers/#{teacher.id}/student_report"
    wait_for_ajax

    expect(page).not_to have_text(error_text)
  end

  private

  def setup_teachers_api_to_fail
    TeachersController.always_fail = true
  end
end
