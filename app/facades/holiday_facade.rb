class HolidayFacade
  # def self.contributor_or_error_msg
  #   json = GithubService.get_contributor_usernames
  #   json[:message].nil? ? create_repo : json
  # end

  def self.create_holidays
    json = HolidayService.get_holidays
    json.map do |holiday|
      Holiday.new({name: holiday[:localName], date: holiday[:date]})
    end
  end
end
