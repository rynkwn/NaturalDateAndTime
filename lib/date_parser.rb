require 'date'

require_relative 'date_parser/natural_date_parsing'

# DateParser is the main interface between the user and the parser
#
# == Methods
#
# *parse(txt, options)*: Parse a block of text and return an array of the parsed
# dates as Date objects.
#

module DateParser
  
  # Parses a text object and returns an array of parsed dates.
  #
  # ==== Attributes
  #
  # * +txt+ - The text to parse.
  # * +creation_date+ - A Date object of when the text was created or released. 
  # Defaults to nil, but if provided can make returned dates more accurate.
  #
  # ==== Options
  #
  # * +:unique+ - Return only unique Date objects. Defaults to false
  # * +:nil_date+ - A date to return if no dates are parsed. Defaults to nil.
  #
  # ==== Examples
  #
  #    text = "Henry and Hanke created a calendar that causes each day to fall " +
  #           "on the same day of the week every year. They recommend its " +
  #           "implementation on January 1, 2018, a Monday."
  #    creation_date = Date.parse("July 6, 2016")
  #
  #    DateParser::parse(text, creation_date)
  #        #=> [#<Date: 2018-01-01 ((2458120j,0s,0n),+0s,2299161j)>, 
  #             #<Date: 2016-07-11 ((2457581j,0s,0n),+0s,2299161j)>]
  #
  #
  #    text = "Sunday, Sunday, Sunday!"
  #    DateParser::parse(text, nil, unique: false)
  #        #=> [#<Date: 2016-07-24 ((2457594j,0s,0n),+0s,2299161j)>, 
  #             #<Date: 2016-07-24 ((2457594j,0s,0n),+0s,2299161j)>, 
  #             #<Date: 2016-07-24 ((2457594j,0s,0n),+0s,2299161j)>]
  #
  #    DateParse::parse(text, nil unique: true)
  #        #=> [#<Date: 2016-07-24 ((2457594j,0s,0n),+0s,2299161j)>]
  #
  def DateParser.parse(txt, creation_date = nil, opts = {})
    unique = opts[:unique] || false
    nil_date = opts[:default_date] || nil
    
    interpreted_dates = NaturalDateParsing::interpret_date(txt, Date.today)
    
    if unique
      interpreted_dates.uniq!
    end
    
    if interpreted_dates.nil?
      interpreted_dates = default_date
    end
    
    return interpreted_dates
  end
end