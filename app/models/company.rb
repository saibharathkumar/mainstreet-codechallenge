class Company < ApplicationRecord
  has_rich_text :description

  validates_format_of :email,
    :with => /\A[A-Za-z0-9+_.-]+@getmainstreet\.com\z/i,
    :allow_blank => true,
    :message => "address should have '@getmainstreet.com' as domain. eg: abc@getmainstreet.com"
    # we may need to add uniqueness on email, if it is required.

  validates :zip_code, presence: true, length: { is: 5, message: "must be a valid 5 digit US zip code."}
  
  before_save :save_city_and_state, if: Proc.new { |company| company.zip_code_changed? }

  def save_city_and_state
    city_state_data = ZipCodes.identify(zip_code)
    if city_state_data.present?
      self.city = city_state_data[:city]
      self.state = city_state_data[:state_code]
    else
      errors.add(:zip_code, 'must be a valid 5 digit US zip code.')
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end

end
