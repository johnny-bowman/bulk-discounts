require 'rails_helper'

RSpec.describe Holiday do
  it "exists and has attributes" do
      data = { name: "St. Patricks Day", date: "2022-01-01" }
      holiday = Holiday.new(data)

      expect(holiday).to be_a(Holiday)

      expect(holiday.name).to eq(data[:name])
      expect(holiday.date).to eq(data[:date])
  end
end
