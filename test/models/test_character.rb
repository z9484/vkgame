require 'test/test_helper'

class TestCharacter < ActiveSupport::TestCase

  test 'valid' do
    assert Character.make_unsaved.valid?
  end

  test 'stats is a string' do
    assert Character.make.stats.is_a? String
  end

  test 'deposit all' do
    c = Character.make(:gold => 25, :guild_gold => 0)
    c.deposit('all')
    assert_equal 0, c.gold
    assert_equal 25, c.guild_gold
  end

  test 'deposit too much' do
    c = Character.make(:gold => 25, :guild_gold => 0)
    c.deposit(50)
    assert_equal 0, c.gold
    assert_equal 25, c.guild_gold
  end

  test 'deposit negative' do
    c = Character.make(:gold => 25, :guild_gold => 0)
    c.deposit(-50)
    assert_equal 25, c.gold
    assert_equal 0, c.guild_gold
  end

  test 'deposit' do
    c = Character.make(:gold => 25, :guild_gold => 0)
    c.deposit(10)
    assert_equal 15, c.gold
    assert_equal 10, c.guild_gold
  end

  test 'withdraw all' do
    c = Character.make(:gold => 25, :guild_gold => 25)
    c.withdraw('all')
    assert_equal 50, c.gold
    assert_equal 0, c.guild_gold
  end

  test 'withdraw too much' do
    c = Character.make(:gold => 25, :guild_gold => 25)
    c.withdraw(50)
    assert_equal 50, c.gold
    assert_equal 0, c.guild_gold
  end

  test 'withdraw negative' do
    c = Character.make(:gold => 25, :guild_gold => 25)
    c.withdraw(-50)
    assert_equal 25, c.gold
    assert_equal 25, c.guild_gold
  end

  test 'withdraw' do
    c = Character.make(:gold => 25, :guild_gold => 25)
    c.withdraw(10)
    assert_equal 35, c.gold
    assert_equal 15, c.guild_gold
  end

end
