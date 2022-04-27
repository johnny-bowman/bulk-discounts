require 'rails_helper'

RSpec.describe HolidayService do
  describe 'API Holiday Endpoint' do
    it "gets holkday data from the Nager.Date endpoint" do
      json = HolidayService.get_holidays
      
      expect(json.first).to have_key(:localName)
      expect(json.first).to have_key(:date)
    end
  end
end
