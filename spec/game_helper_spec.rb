require_relative 'spec_helper'

RSpec.describe Codebreaker::GameHelper do
  subject(:game) { Codebreaker::Game.new }

  describe 'rand code' do
    it 'check code for 4 numbers' do
      game.set_code
      expect(game.code.length).to be(4)
    end

    it 'check code with numbers from 1 to 6' do
      game.set_code
      expect(game.code).to match(/^[1-6]+$/)
    end
  end

  describe 'check_code' do
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

      game.instance_variable_set :@code, '1234'
      game.instance_variable_set :@input_code, '1234'
      expect(game.check_code(game.input_code, game.code)).to eq '++++'

      game.instance_variable_set :@code, '1234'
      game.instance_variable_set :@input_code, '4321'
      expect(game.check_code(game.input_code, game.code)).to eq '----'
    end
  end

  describe 'check_hint' do
    let(:code) { '2345' }

    context 'when show first hint' do
      it do
        hint_index = [2]
        expect(game.check_hint(code, hint_index)).to eq '**4*'
      end
    end

    context 'when show next hint' do
      before do
        game.hints_used = 3
        game.hints_total = 5
        game.hint_index = [2, 1, 3]
        game.code = code
        game.hint
      end

      it { expect(game.check_hint(code, game.hint_index)).to eq '2***' }
    end
  end
end
