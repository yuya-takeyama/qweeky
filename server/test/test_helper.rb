ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

$LOAD_PATH << File.join(__FILE__, '../', 'supports')

require 'rails/test_help'

require 'api_helper'

class BaseTestCase < Test::Unit::TestCase
  include FactoryGirl::Syntax::Methods

  setup do
    DatabaseRewinder.clean_all
  end

  teardown do
    DatabaseRewinder.clean
  end
end
