require 'test_helper'

module Buttafly

  describe Legend do

    Then { assert_kind_of Module, Buttafly }
  end

  describe Mapping do

    Then { assert_kind_of Class, Mapping }
  end

  describe Spreadsheet do

    Then { assert_kind_of Class, Spreadsheet }
  end
end

describe Buttafly do

  Then { assert_kind_of Class, Buttafly::Legend }
  And { assert_kind_of Class, Buttafly::Mapping }
  And { assert_kind_of Class, Buttafly::Spreadsheet }
end
