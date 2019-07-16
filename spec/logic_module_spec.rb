require_relative 'spec_helper'

RSpec.describe LogicModule do
  let(:game) { Game.new }

  describe '#rand code' do
    it 'check code for 4 numbers' do
      game.set_code
      expect(game.code.length).to be(4)
    end

    it 'check code with numbers from 1 to 6' do
      game.set_code
      expect(game.code).to match(/^[1-6]+$/)
    end
  end

  describe '#check_code' do
    it 'marks code according to algorithm' do
      game.instance_variable_set :@code, '1234'
      game.instance_variable_set :@input_code, '1235'
      expect(game.check_code(game.input_code, game.code)).to eq '+++'

      game.instance_variable_set :@code, '1134'
      game.instance_variable_set :@input_code, '5511'
      expect(game.check_code(game.input_code, game.code)).to eq '--'

      game.instance_variable_set :@code, '1234'
      game.instance_variable_set :@input_code, '1243'
      expect(game.check_code(game.input_code, game.code)).to eq '++--'
    end
  end

  it 'check_hint' do
    code = '2345'
    expect(game).to receive(:rand).and_return(2)
    expect(game.check_hint(code)).to eq '**4*'
  end
end
