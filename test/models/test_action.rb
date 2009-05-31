require 'test/test_helper'

class TestAction < ActiveSupport::TestCase

  test 'valid' do
    assert Action.make_unsaved.valid?
  end

  test 'available? enter' do
    a = Action.make
    a.base_action.update_attribute(:slug, 'enter')
    Terrain.any_instance.stubs(:enterable?).returns(false)
    assert !a.available?
    Terrain.any_instance.stubs(:enterable?).returns(true)
    assert a.available?
  end
end
