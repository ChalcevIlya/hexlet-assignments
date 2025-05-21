# frozen_string_literal: true

require 'digest'

class Signature
  def initialize(app)
    @app = app
  end

  def call(env)
    # BEGIN
    previous_response = @app.call(env)
    status, headers, previous_body = previous_response

    return previous_response if status != 200

    [status, headers, previous_body.push(Digest::SHA2.hexdigest(previous_body.join))]
    # END
  end
end
