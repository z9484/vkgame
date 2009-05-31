require 'test/test_helper'

class TestTerrain < ActiveSupport::TestCase

  test 'enterable? false' do
    assert !Terrain.make(:kind => 'dirt').enterable?
  end

  test 'enterable? true' do
    assert Terrain.make(:kind => 'shop').enterable?
  end

end
