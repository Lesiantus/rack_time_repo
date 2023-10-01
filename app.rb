require_relative 'time_formatter_logic'

class TimeFormatter
  def call(env)
    @request = Rack::Request.new(env)
    handle_request
  end

  private

  def handle_request
    if @request.path_info == '/time' && @request.get?
      handle_time_request
    else
      [404, { 'Content-Type' => 'text/plain' }, ['Not Found']]
    end
  end

  def handle_time_request
    formats = @request.params['format'].split(',')
    unknown_formats = formats - TimeFormatterLogic.valid_formats

    if unknown_formats.empty?
      time_response = TimeFormatterLogic.generate_time_response(formats)
      [200, { 'Content-Type' => 'text/plain' }, [time_response]]
    else
      error_message = "Unknown time format [#{unknown_formats.join(', ')}]"
      [400, { 'Content-Type' => 'text/plain' }, [error_message]]
    end
  end
end
