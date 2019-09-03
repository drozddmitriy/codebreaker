require_relative 'spec_helper'

RSpec.describe Codebreaker::ValidationModule do
  let(:game) { Codebreaker::Game.new }

  context 'when guess true' do
    let(:guess) { '1234' }
    it { expect(game.validation_guess(guess)).to eq true }
  end

  context 'when guess false' do
    let(:guess) { '1239' }
    it { expect(game.validation_guess(guess)).to eq false }
  end

  context 'when name not String' do
    let(:name) { 1234 }
    it { expect(game.validation_name(name)).to eq false }
  end

  context 'when name empty' do
    let(:name) { '' }
    it { expect(game.validation_name(name)).to eq false }
  end

  context 'when length between 3 and 20' do
    it 'name length < 3' do
      name = 'as'
      expect(game.validation_name(name)).to eq false
    end

    it 'name length > 20' do
      name = 'qwertyuiopasdghjfgkghjd'
      expect(game.validation_name(name)).to eq false
    end
  end
end
