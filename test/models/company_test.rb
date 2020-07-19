require 'test_helper'

class CompanyTest < ActiveSupport::TestCase

  def setup
    @company = Company.new(name: "new company", zip_code: "12345")
  end

  test "should not save company with invalid email address" do
    @company.email = "abc@abc.com"
    assert_not @company.save
  end

  test "should save company with valid email address" do
    @company.email = "abc@getmainstreet.com"
    assert @company.save
  end

  test "should allow blank email" do
    @company.email = ""
    assert @company.save
  end

  test "should not save company with invalid zip_code" do
    @company.zip_code = "12345678"
    assert_not @company.save

    @company.zip_code = nil
    assert_not @company.save

    @company.zip_code = "qwerty"
    assert_not @company.save

    @company.zip_code = "0987"
    assert_not @company.save

    @company.zip_code = "12345"
    assert @company.save
  end

  test "should save company with valid email address" do
    @company.zip_code = "12345"
    assert @company.save

    existing_city = @company.city
    existing_state = @company.state

    @company.zip_code = "93003"
    @company.save

    assert_not_equal  existing_city, @company.city
    assert_not_equal  existing_state, @company.city
  end

end