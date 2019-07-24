require_relative 'spec_helper'

RSpec.describe Game do
  let(:game) { Game.new }

  it '#check set_difficul' do
    difficulty = 'hell'
    attempts = 5
    game.set_difficul(difficulty, attempts)
    expect(game.instance_variable_get(:@difficulty)).to eq 'hell'
    expect(game.instance_variable_get(:@attempts)).to eq 5
  end

  describe '#chek def_name' do
    it 'if true' do
      game.def_name('test')
      expect(game.instance_variable_get(:@name)).to eq 'test'
    end

    it 'if empty' do
      game.def_name('')
      expect(game.instance_variable_get(:@name)).to eq false
    end

    it 'if between (3, 20)' do
      game.def_name('te')
      expect(game.instance_variable_get(:@name)).to eq false
    end

    it 'if String' do
      game.def_name(125)
      expect(game.instance_variable_get(:@name)).to eq false
    end
  end

  describe '#chek def_guess' do
    it 'if true' do
      game.def_guess('1234')
      expect(game.instance_variable_get(:@input_code)).to eq '1234'
    end

    it 'if false' do
      game.def_guess('12345')
      expect(game.instance_variable_get(:@input_code)).to eq false
    end
  end

  it '#check diff_hints' do
    game.hints_total = 5
    game.hints_used = 2
    expect(game.diff_hints).to eq 3
  end

  it '#check diff_try' do
    game.attempts = 5
    game.try = 2
    expect(game.diff_try).to eq 3
  end

  it '#check add_try' do
    game.try = 0
    expect(game.add_try).to eq 1
  end

  it '#check reset_input_code' do
    game.input_code = '1234'
    expect(game.reset_input_code).to eq false
  end

  it '#check to_hash' do
    game.name = 'test'
    game.attempts = 5
    game.hints_total = 1
    game.hints_used = 0
    game.difficulty = 'hell'
    game.try = 1
    hash = { name: 'test', attempts: 5, hints_total: 1, hints_used: 0, difficulty: 'hell', try: 1 }
    expect(game.to_hash).to eq hash
  end

  describe '#check method check' do
    it 'if true' do
      game.input_code = '1234'
      game.code = '1234'
      game.attempts = 5
      expect(game.check).to eq true
    end

    it 'if result' do
      game.input_code = '1234'
      game.code = '1233'
      game.attempts = 5
      expect(game.check).to eq '+++'
    end
  end

  it '#check set_code' do
    allow(game).to receive(:rand_code).and_return('1234')
    expect(game.set_code).to eq '1234'
  end

  describe '#check hint' do
    it 'if return hint' do
      game.hints_total = 1
      game.hints_used = 0
      allow(game).to receive(:check_hint).and_return('*2**')
      expect(game.hint).to eq '*2**'
    end
  end
end
