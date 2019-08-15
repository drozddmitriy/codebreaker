require_relative 'spec_helper'

RSpec.describe Game do
  subject(:game) { described_class.new }

  describe '.difficulty_player' do
    let(:difficulty) { 'hell' }
    let(:attempts) { 5 }

    before do
      game.difficulty_player(difficulty, attempts)
    end

    it do
      expect(game.instance_variable_get(:@difficulty)).to eq 'hell'
      expect(game.instance_variable_get(:@attempts)).to eq 5
    end
  end

  describe '.name_player' do
    it 'when valid name' do
      game.name_player('test')
      expect(game.instance_variable_get(:@player)).to eq 'test'
    end

    it 'when empty name' do
      game.name_player('')
      expect(game.instance_variable_get(:@player)).to eq nil
    end

    it 'when name between (3, 20)' do
      game.name_player('te')
      expect(game.instance_variable_get(:@player)).to eq nil
    end

    it 'when name not String' do
      game.name_player(125)
      expect(game.instance_variable_get(:@player)).to eq nil
    end
  end

  describe '.guess_player' do
    it 'when valid guess' do
      game.guess_player('1234')
      expect(game.instance_variable_get(:@input_code)).to eq '1234'
    end

    it 'when invalid guess' do
      game.guess_player('12345')
      expect(game.instance_variable_get(:@input_code)).to eq false
    end
  end

  describe '.diff_hints' do
    before do
      game.hints_total = 5
      game.hints_used = 2
    end

    it { expect(game.diff_hints).to eq 3 }
  end

  describe '.diff_try' do
    before do
      game.attempts = 5
      game.try = 2
    end

    it { expect(game.diff_try).to eq 3 }
  end

  describe '.add_try' do
    before do
      game.try = 0
    end
    it { expect(game.add_try).to eq 1 }
  end

  describe '.reset_input_code' do
    before do
      game.input_code = '1234'
    end

    it { expect(game.reset_input_code).to eq false }
  end

  describe '.to_hash' do
    let(:hash) { { name: 'test', attempts: 5, hints_total: 1, hints_used: 0, difficulty: 'hell', try: 1 } }
    before do
      game.player = 'test'
      game.attempts = 5
      game.hints_total = 1
      game.hints_used = 0
      game.difficulty = 'hell'
      game.try = 1
    end

    it { expect(game.to_hash).to eq hash }
  end

  describe '.check' do
    before do
      game.input_code = '1234'
      game.code = '1234'
      game.attempts = 5
    end

    it { expect(game.check).to eq '++++' }
  end

  describe '.set_code' do
    it do
      allow(game).to receive(:rand_code).and_return('1234')
      expect(game.set_code).to eq '1234'
    end
  end

  describe '.hint' do
    before do
      game.hints_total = 1
      game.hints_used = 0
    end

    it do
      allow(game).to receive(:check_hint).and_return('*2**')
      expect(game.hint).to eq '*2**'
    end
  end
end
