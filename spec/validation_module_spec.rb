require_relative 'spec_helper'

RSpec.describe ValidationModule do
  let(:game) { Game.new }

  it 'check guess when true' do
    guess = '1234'
    expect(game.validation_guess(guess)).to eq true
  end

  it 'chek guess when false' do
    guess = '1239'
    expect(game.validation_guess(guess)).to eq false
  end

  it 'check name when not String' do
    name = 1234
    expect(game.validation_name(name)).to eq false
  end

  it 'check name when empty' do
    name = ''
    expect(game.validation_name(name)).to eq false
  end

  context 'check name when length between 3 and 20' do
    it 'check name when length < 3' do
      name = 'as'
      expect(game.validation_name(name)).to eq false
    end

    it 'check name when length > 20' do
      name = 'qwertyuiopasdghjfgkghjd'
      expect(game.validation_name(name)).to eq false
    end
  end
end
