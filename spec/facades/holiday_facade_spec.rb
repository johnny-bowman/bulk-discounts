require "rails_helper"

RSpec.describe HolidayFacade do
  it "creates holiday poros" do
    holidays = HolidayFacade.create_holidays
    expect(holidays.first).to be_a(Holiday)
  end
end
