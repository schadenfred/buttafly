# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize! if Rails.env == "install_test"
