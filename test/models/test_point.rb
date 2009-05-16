require 'test/test_helper'

class TestPoint < ActiveSupport::TestCase

  test 'group' do
    assert !Point.make.group
  end

  test 'neighbors empty' do
    assert Point.make(:characters => []).neighbors.empty?
  end

  test 'neighbors empty with character' do
    p = Point.make(:characters => [])
    c = Character.make
    p.characters << c
    assert p.neighbors(c).empty?
  end

  test 'neighbors not empty' do
    p = Point.make(:characters => [])
    no = Character.make
    yes = Character.make
    p.characters = [no, yes]
    assert !p.neighbors(no).include?(no)
    assert p.neighbors(no).include?(yes)
  end

end
