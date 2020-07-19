require "test_helper"
require "application_system_test_case"

class CompaniesControllerTest < ApplicationSystemTestCase

  def setup
    @company = companies(:hometown_painting)
  end

  test "Index" do
    visit companies_path

    assert_text "Companies"
    assert_text "Hometown Painting"
    assert_text "Wolf Painting"
  end

  test "Show" do
    visit company_path(@company)

    assert_text @company.name
    assert_text @company.phone
    assert_text @company.email
    assert_text "City, State"
  end

  test "Update" do
    visit edit_company_path(@company)

    #updating with invalid email
    within("form#edit_company_#{@company.id}") do
      fill_in("company_name", with: "Updated Test Company")
      fill_in("company_zip_code", with: "93009")
      fill_in("company_email", with: "test@xyz.com")
      click_button "Update Company"
    end

    assert_text "Email address should have '@getmainstreet.com' as domain. eg: abc@getmainstreet.com"

    #correcting the email address and re-submitting the form.
    within("form#edit_company_#{@company.id}") do
      fill_in("company_email", with: "test@getmainstreet.com")
      click_button "Update Company"
    end
    assert_text "Changes saved successfully."

    @company.reload
    assert_equal "Updated Test Company", @company.name
    assert_equal "93009", @company.zip_code
  end

  test "Create" do
    visit new_company_path

    #creating with invalid email address
    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "28173")
      fill_in("company_phone", with: "5553335555")
      fill_in("company_email", with: "new_test_company@test.com")
      click_button "Create Company"
    end

    assert_text "Email address should have '@getmainstreet.com' as domain. eg: abc@getmainstreet.com"

    #correcting the email address and re-submitting the form.
    within("form#new_company") do
      fill_in("company_email", with: "new_test_company@getmainstreet.com")
      click_button "Create Company"
    end

    last_company = Company.last
    assert_equal "New Test Company", last_company.name
    assert_equal "28173", last_company.zip_code
  end

  test "Destroy" do
    visit company_path(@company)
    #dismissing the delete confirmation alert
    click_link 'Delete'
    alert = page.driver.browser.switch_to.alert
    assert_equal alert.text, I18n.t('deletion_confirmation')
    alert.dismiss
    assert_text @company.name

    #acceptig the delete confirmation alert
    click_link 'Delete'
    alert = page.driver.browser.switch_to.alert
    assert_equal alert.text, I18n.t('deletion_confirmation')
    alert.accept
    assert_text "Company has been deleted successfully."
  end 

end
