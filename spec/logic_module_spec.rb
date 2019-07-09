require_relative 'spec_helper'

RSpec.describe LogicModule do
    let(:game) { Game.new }

    it 'rand code' do
      allow(game).to receive(:rand).and_return(4)
      expect(game.rand_code).to eq('4444')
    end

    describe '#check_code' do
      it 'marks code according to algorithm' do
        try = 2
        attempts = 15
        input_code = game.input_code
        code = game.code
        game.instance_variable_set :@code, '1234'
        game.instance_variable_set :@input_code, '1235'
        expect(game.check_code(try, attempts, game.input_code, game.code)).to eq('+++')

        game.instance_variable_set :@code, '1234'
        game.instance_variable_set :@input_code, '5551'
        expect(game.check_code(try, attempts, game.input_code, game.code)).to eq('-')

        game.instance_variable_set :@code, '1234'
        game.instance_variable_set :@input_code, '1243'
        expect(game.check_code(try, attempts, game.input_code, game.code)).to eq('++--')
      end
end

end
