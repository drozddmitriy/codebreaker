require_relative 'spec_helper'

RSpec.describe Console do
  subject(:game) { Game.new }

  let(:console) { described_class.new }

  describe '.run' do
    before do
      allow(console).to receive(:loop).and_yield
    end

    it 'and returns rules' do
      allow(console).to receive(:gets).and_return(I18n.t(:rule))
      console.run
    end

    it 'and exit' do
      allow(console).to receive(:gets).and_return(I18n.t(:exit))
      console.run
    end

    it 'and returns stats' do
      allow(console).to receive(:gets).and_return(I18n.t(:stats))
      console.run
    end

    it 'and start game' do
      allow(console).to receive(:gets).and_return(I18n.t(:start), I18n.t(:exit))
      expect(console).to receive(:registration)
      expect(console).to receive(:check_difficulty)
      expect(console).to receive(:game_process)
      console.run
    end

    it 'puts invalid value' do
      allow(console).to receive(:gets).and_return('test')
      expect(console).to receive(:main_menu)
      expect(console).to receive(:show_message_continue)
      expect { console.run }.to output(I18n.t(:please_choose_command)).to_stdout
    end
  end

  describe '.registration' do
    let(:name) { 'test' }
    let(:name_test) { 'te' }
    let(:name_i18t) { I18n.t(:name) }

    before { console.instance_variable_set(:@game, game) }

    it 'when exit return false' do
      allow(console).to receive(:gets).and_return(I18n.t(:exit))
      expect(console.registration).to eq false
    end

    it 'when valid name return name' do
      allow(console).to receive(:gets).and_return(name)
      console.registration
      expect(game.instance_variable_get(:@player)).to eq name
    end

    it 'when invalid name return error' do
      allow(console).to receive(:loop).and_yield
      allow(console).to receive(:gets).and_return(name_test)
      expect(console).to receive(:show_message_continue)
      expect { console.registration }.to output(I18n.t(:entery_name) + I18n.t(:error, name: name_i18t)).to_stdout
    end
  end

  describe '.input' do
    before do
      @attempts_test = 10
      game.instance_variable_set(:@hints_total, 5)
      console.instance_variable_set(:@game, game)
      expect(console).to receive(:menu_process)
    end

    it 'when exit return false' do
      allow(console).to receive(:gets).and_return(I18n.t(:exit))
      expect(console.input(@attempts_test)).to eq false
    end

    it 'return valid guess' do
      allow(console).to receive(:gets).and_return('1234')
      console.input(@attempts_test)
      expect(game.instance_variable_get(:@input_code)).to eq '1234'
    end

    it 'when invalid guess return error' do
      guess = I18n.t(:guess)
      allow(console).to receive(:loop).and_yield
      allow(console).to receive(:gets).and_return('te')
      expect(console).to receive(:show_message_continue)
      expect { console.input(@attempts_test) }.to output(I18n.t(:error, name: guess)).to_stdout
    end

    context 'if guess hint' do
      before do
        game.set_code
        allow(console).to receive(:loop).and_yield
      end

      it 'and return hint' do
        allow(console).to receive(:gets).and_return(I18n.t(:hint))
        console.input(@attempts_test)
        expect(game.instance_variable_get(:@hints_used)).to eq 1
      end

      it 'and return no hint' do
        game.hints_used = 5
        allow(console).to receive(:gets).and_return(I18n.t(:hint))
        expect(console).to receive(:show_message_continue)
        expect { console.input(@attempts_test) }.to output(I18n.t(:no_hints)).to_stdout
      end
    end
  end

  describe '.check_difficulty' do
    before do
      allow(console).to receive(:loop).and_yield
      console.instance_variable_set(:@game, game)
      expect(console).to receive(:menu_choose_difficulty)
    end

    it 'and set easy' do
      allow(console).to receive(:gets).and_return(I18n.t(:easy, scope: [:difficulty]))
      console.check_difficulty
      expect(game.instance_variable_get(:@difficulty)).to eq I18n.t(:easy, scope: [:difficulty])
    end

    it 'and set medium' do
      allow(console).to receive(:gets).and_return(I18n.t(:medium, scope: [:difficulty]))
      console.check_difficulty
      expect(game.instance_variable_get(:@difficulty)).to eq I18n.t(:medium, scope: [:difficulty])
    end

    it 'and set hell' do
      allow(console).to receive(:gets).and_return(I18n.t(:hell, scope: [:difficulty]))
      console.check_difficulty
      expect(game.instance_variable_get(:@difficulty)).to eq I18n.t(:hell, scope: [:difficulty])
    end

    it 'and exit' do
      allow(console).to receive(:gets).and_return(I18n.t(:exit))
      expect(console.check_difficulty).to eq false
    end

    it 'when invalid difficul' do
      allow(console).to receive(:gets).and_return('test')
      expect(console).to receive(:show_message_continue)
      expect { console.check_difficulty }.to output(I18n.t(:please_choose_difficul)).to_stdout
    end
  end

  describe '.game_process' do
    before do
      @code_test = '1234'
      allow(console).to receive(:loop).and_yield
      game.instance_variable_set(:@attempts, 5)
      console.instance_variable_set(:@game, game)
      allow(console).to receive(:gets).and_return('')
      expect(console).to receive(:input).and_return(5)
    end

    it 'when win' do
      game.instance_variable_set(:@try, 2)
      expect(game).to receive(:win?).and_return(true)
      console.game_process
      expect { console.menu_win(@code_test) }.to output(I18n.t(:menu_win, code: @code_test)).to_stdout
    end

    it 'when lose' do
      game.instance_variable_set(:@try, 5)
      expect(game).to receive(:check)
      console.game_process
      expect(console).to receive(:show_message_continue)
      expect { console.menu_lose(@code_test) }.to output(I18n.t(:menu_lose, code: @code_test)).to_stdout
    end
  end
end
