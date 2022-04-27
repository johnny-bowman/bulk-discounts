class HolidayService < BaseService
  def self.get_holidays
    response = conn('https://date.nager.at').get('/api/v2/NextPublicHolidays/US')
    get_json(response)
  end
end
