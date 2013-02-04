module Sevenhelpers
  module ViewHelpers
    def copyright_years(start_year = Time.now.year)
      current_year = Time.now.year
      if start_year > current_year # trap if user sets start year ahead of current year
        output = current_year.to_s
      else
        output = start_year.to_s
        output << "-#{current_year.to_s}" if start_year != current_year
      end
      output
    end
  end
end