require_relative 'spec_helper'
require_relative '../dependency'

RSpec.describe Game do
  let(:game) { Game.new }

  it 'check set_difficul' do
    difficulty = 'hell'
    attempts = 5
    hints_total = 1
    game.set_difficul(difficulty,attempts,hints_total)
    expect(game.instance_variable_get(:@difficulty)).to eq 'hell'
    expect(game.instance_variable_get(:@attempts)).to eq 5
    expect(game.instance_variable_get(:@hints_total)).to eq 1
  end

  describe '#set_values' do
        it 'check set name' do
          set_val = 'dima'
          name = 'dima'
          game.set_values(game.validation_name(name), name, 'name')
          expect(game.instance_variable_get(:@name)).to eq 'dima'
        end

        it 'check set guess' do
          set_val = '1234'
          guess = '1234'
          game.set_values(game.validation_guess(guess), guess, 'guess')
          expect(game.instance_variable_get(:@input_code)).to eq '1234'
        end

        it 'chek error' do
          expect(game.set_values(false, '1234', 'guess')).to eq true
        end
    end

  it 'check out registration' do
    allow(game).to receive(:registration).and_return(false)
    expect(game.registration).to eq false
  end


end
