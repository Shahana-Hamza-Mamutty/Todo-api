module Exceptions

  # # Raised when the user profile service generates an unexpected response
  class ValidationFailed < StandardError
    def http_status
      400
    end

    def message
      "Enter Valid title"
    end

  end

  class RecordNotFound < StandardError
    def http_status
      404
    end

    def message
      "No record found for this id"
    end
  end

  class UnexpectedError < StandardError
    def http_status
      502
    end

    def message
      "Something went wrong. Please try again later"
    end

  end

  class UnAuthorized < StandardError
    def http_status
      403
    end

    def message
      "Unauthorized service"
    end
  end

  class NoRouteFound < StandardError
    def http_status
      404
    end

    def message
      "Invalid routes"
    end
  end
end