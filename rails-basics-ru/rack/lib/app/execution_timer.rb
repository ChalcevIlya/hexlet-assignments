# frozen_string_literal: true

class ExecutionTimer
  def initialize(app)
    @app = app
  end

  def call(env)
    start_time = Time.now
    status, headers, body = @app.call(env)
    request_time = (Time.now - start_time) * 1000.0

    headers['X-Execution-Runtime'] = request_time.to_s
    [status, headers, body]
  end
end
