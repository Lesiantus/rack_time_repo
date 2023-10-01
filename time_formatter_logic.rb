class TimeFormatterLogic
  FORMATS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }.freeze

  def self.valid_formats
    FORMATS.keys
  end

  def self.format_to_string(format)
    FORMATS[format]
  end

  def self.generate_time_response(formats)
    current_time = Time.now
    formatted_time = formats.map { |format| current_time.strftime(format_to_string(format)) }
    formatted_time.join('-')
  end
end
