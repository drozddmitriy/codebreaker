require_relative 'spec_helper'

RSpec.describe Codebreaker::Game do
  subject(:game) { described_class.new }

  describe '.difficulty_player' do
    let(:difficulty) { 'hell' }
    let(:attempts) { 5 }

    before { game.difficulty_player(difficulty, attempts) }

    it do
      expect(game.instance_variable_get(:@difficulty)).to eq difficulty
      expect(game.instance_variable_get(:@attempts)).to eq 5
    end
  end

  describe '.name_player' do
    context 'when valid name' do
      let(:name) { 'test' }

      it do
        game.name_player(name)
        expect(game.instance_variable_get(:@player)).to eq name
      end
    end

    context 'when empty name' do
      let(:name) { '' }

      it do
        game.name_player('')
        expect(game.instance_variable_get(:@player)).to be_nil
      end
    end

    context 'when name between (3, 20)' do
      let(:name) { 'te' }

      it do
        game.name_player('te')
        expect(game.instance_variable_get(:@player)).to be_nil
      end
    end

    context 'when name not String' do
      let(:name) { 125 }

      it do
        game.name_player(125)
        expect(game.instance_variable_get(:@player)).to be_nil
      end
    end
  end

  describe '.guess_player' do
    context 'when valid guess' do
      let(:guess) { '1234' }

      it do
        game.guess_player(guess)
        expect(game.instance_variable_get(:@input_code)).to eq guess
      end
    end

    context 'when invalid guess' do
      let(:guess) { '12345' }

      it do
        game.guess_player(guess)
        expect(game.instance_variable_get(:@input_code)).to eq false
      end
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
    let(:code) { '1234' }

    it do
      allow(game).to receive(:rand_code).and_return(code)
      expect(game.set_code).to eq code
    end
  end

  describe '.hint' do
    let(:hint) { '*2**' }

    before do
      game.hints_total = 1
      game.hints_used = 0
    end

    it do
      allow(game).to receive(:check_hint).and_return(hint)
      expect(game.hint).to eq hint
    end
  end
end
