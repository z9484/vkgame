require 'test/test_helper'

class TestCharacter < ActiveSupport::TestCase

  test 'valid' do
    assert Character.make_unsaved.valid?
  end

  test 'available_actions not empty for new character' do
    assert !Character.make.available_actions.empty?
  end

  test 'stats is a string' do
    assert Character.make.stats.is_a? String
  end

end
