require_relative 'spec_helper'

RSpec.describe Console do
  let(:console) { Console.new }
  let(:game) { Game.new }

  describe '#chek run' do
    before do
      allow(console).to receive(:loop).and_yield
    end

    it 'call rules' do
      allow(console).to receive(:gets).and_return(I18n.t(:rule))
      console.run
    end

    it 'call exit' do
      allow(console).to receive(:gets).and_return(I18n.t(:exit))
      console.run
    end

    it 'call stats' do
      allow(console).to receive(:gets).and_return(I18n.t(:stats))
      console.run
    end

    it 'call start' do
      allow(console).to receive(:gets).and_return(I18n.t(:start), I18n.t(:exit))
      expect(console).to receive(:registration)
      expect(console).to receive(:check_difficulty)
      expect(console).to receive(:game_process)
      console.run
    end

    it 'if puts invalid value' do
      allow(console).to receive(:gets).and_return('test')
      expect(console).to receive(:main_menu)
      expect(console).to receive(:message)
      expect { console.run }.to output(I18n.t(:please_choose_command)).to_stdout
    end
  end

  describe '#chek registration' do
    it 'if exit' do
      console.instance_variable_set(:@game, game)
      allow(console).to receive(:gets).and_return(I18n.t(:exit))
      expect(console.registration).to eq false
    end

    it 'if valid name' do
      name = 'test'
      console.instance_variable_set(:@game, game)
      allow(console).to receive(:gets).and_return(name)
      console.registration
      expect(game.instance_variable_get(:@name)).to eq name
    end

    it 'if invalid name' do
      name = I18n.t(:name)
      name_test = 'te'
      allow(console).to receive(:loop).and_yield
      console.instance_variable_set(:@game, game)
      allow(console).to receive(:gets).and_return(name_test)
      expect(console).to receive(:message)
      expect { console.registration }.to output(I18n.t(:entery_name) + I18n.t(:error, name: name)).to_stdout
    end
  end

  describe '#chek input' do
    before do
      @attempts_test = 10
      game.instance_variable_set(:@hints_total, 5)
      console.instance_variable_set(:@game, game)
      expect(console).to receive(:menu_process)
    end

    it 'if exit' do
      allow(console).to receive(:gets).and_return(I18n.t(:exit))
      expect(console.input(@attempts_test)).to eq false
    end

    it 'if guess valid' do
      allow(console).to receive(:gets).and_return('1234')
      console.input(@attempts_test)
      expect(game.instance_variable_get(:@input_code)).to eq '1234'
    end

    it 'if guess hint' do
      game.set_code
      allow(console).to receive(:loop).and_yield
      allow(console).to receive(:gets).and_return(I18n.t(:hint))
      console.input(@attempts_test)
      expect(game.instance_variable_get(:@hints_used)).to eq 1
    end

    it 'if no hint' do
      game.set_code
      game.hints_used = 5
      allow(console).to receive(:loop).and_yield
      allow(console).to receive(:gets).and_return(I18n.t(:hint))
      expect(console).to receive(:message)
      expect { console.input(@attempts_test) }.to output(I18n.t(:no_hints)).to_stdout
    end

    it 'if invalid guess' do
      guess = I18n.t(:guess)
      allow(console).to receive(:loop).and_yield
      allow(console).to receive(:gets).and_return('te')
      expect(console).to receive(:message)
      expect { console.input(@attempts_test) }.to output(I18n.t(:error, name: guess)).to_stdout
    end
  end

  describe '#chek check_difficulty' do
    before do
      allow(console).to receive(:loop).and_yield
      console.instance_variable_set(:@game, game)
      expect(console).to receive(:menu_choose_difficulty)
    end
    it 'if difficul easy' do
      allow(console).to receive(:gets).and_return(I18n.t(:easy))
      console.check_difficulty
      expect(game.instance_variable_get(:@difficulty)).to eq I18n.t(:easy)
    end

    it 'if difficul medium' do
      allow(console).to receive(:gets).and_return(I18n.t(:medium))
      console.check_difficulty
      expect(game.instance_variable_get(:@difficulty)).to eq I18n.t(:medium)
    end

    it 'if difficul hell' do
      allow(console).to receive(:gets).and_return(I18n.t(:hell))
      console.check_difficulty
      expect(game.instance_variable_get(:@difficulty)).to eq I18n.t(:hell)
    end

    it 'if exit' do
      allow(console).to receive(:gets).and_return(I18n.t(:exit))
      expect(console.check_difficulty).to eq false
    end

    it 'if invalid difficul' do
      allow(console).to receive(:gets).and_return('test')
      expect(console).to receive(:message)
      expect { console.check_difficulty }.to output(I18n.t(:please_choose_difficul)).to_stdout
    end
  end

  describe '#chek game_process' do
    before do
      @code_test = '1234'
      allow(console).to receive(:loop).and_yield
      game.instance_variable_set(:@attempts, 5)
      console.instance_variable_set(:@game, game)
      allow(console).to receive(:gets).and_return('')
      expect(console).to receive(:input) { 5 }
    end
    it 'if win' do
      game.instance_variable_set(:@try, 2)
      expect(game).to receive(:check).and_return(true)
      console.game_process
      expect { console.menu_win(@code_test) }.to output(I18n.t(:menu_win, code: @code_test)).to_stdout
    end

    it 'if lose' do
      game.instance_variable_set(:@try, 5)
      expect(game).to receive(:check)
      console.game_process
      expect(console).to receive(:message)
      expect { console.menu_lose(@code_test) }.to output(I18n.t(:menu_lose, code: @code_test)).to_stdout
    end
  end
end
