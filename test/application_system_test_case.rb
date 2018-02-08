require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :webkit, using: :chrome, screen_size: [1400, 1400]
end
