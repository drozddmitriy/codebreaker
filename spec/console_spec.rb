require_relative 'spec_helper'

RSpec.describe Console do
  let(:console) { Console.new }
  let(:game) { Game.new }

  describe '#chek run' do
    before do
      allow(console).to receive(:loop).and_yield
    end

    it 'call rules' do
      allow(console).to receive(:gets).and_return('rules')
      console.run
    end

    it 'call exit' do
      allow(console).to receive(:gets).and_return('exit')
      console.run
    end

    it 'call stats' do
      allow(console).to receive(:gets).and_return('stats')
      console.run
    end

    it 'call start' do
      allow(console).to receive(:gets).and_return('start', 'exit')
      expect(console).to receive(:registration)
      expect(console).to receive(:check_difficulty)
      expect(console).to receive(:game_process)
      console.run
    end

    it 'if puts invalid value' do
      allow(console).to receive(:gets).and_return('test')
      expect { console.run }.to output(/Error please choose one from listed commands/).to_stdout
    end
  end

  describe '#chek registration' do
    it 'if exit' do
      console.instance_variable_set(:@game, game)
      allow(console).to receive(:gets).and_return('exit')
      expect(console.registration).to eq false
    end

    it 'if valid name' do
      console.instance_variable_set(:@game, game)
      allow(console).to receive(:gets).and_return('test')
      console.registration
      expect(game.instance_variable_get(:@name)).to eq 'test'
    end

    it 'if invalid name' do
      console.instance_variable_set(:@game, game)
      allow(console).to receive(:gets).and_return('te', 'test')
      expect { console.registration }.to output("Entery you name!\nError please enter valid name\nPress entert to continue!\nEntery you name!\n").to_stdout
    end
  end

  describe '#chek input' do
    before do
      # attempts = 10
      game.instance_variable_set(:@hints_total, 5)
      console.instance_variable_set(:@game, game)
    end

    it 'if exit' do
      attempts = 10
      allow(console).to receive(:gets).and_return('exit')
      expect(console).to receive(:menu_process)
      expect(console.input(attempts)).to eq false
    end

    it 'if guess valid' do
      attempts = 10
      allow(console).to receive(:gets).and_return('1234')
      expect(console).to receive(:menu_process)
      console.input(attempts)
      expect(game.instance_variable_get(:@input_code)).to eq '1234'
    end

    it 'if guess hint' do
      attempts = 10
      allow(console).to receive(:gets).and_return('hint', '1234')
      expect(console).to receive(:menu_process)
      expect(console).to receive(:menu_process)
      expect(game).to receive(:hint).and_return('*1**')
      expect { console.input(attempts) }.to output("*1**\nPress entert to continue!\n").to_stdout
    end

    it 'if invalid guess' do
      attempts = 10
      console.instance_variable_set(:@game, game)
      allow(console).to receive(:gets).and_return('te', '1234')
      expect(console).to receive(:menu_process)
      expect(console).to receive(:menu_process)
      expect { console.input(attempts) }.to output("Error please enter valid guess\nPress entert to continue!\n").to_stdout
    end
  end

  describe '#chek check_difficulty' do
    before do
      allow(console).to receive(:loop).and_yield
    end
    it 'if difficul easy' do
      console.instance_variable_set(:@game, game)
      allow(console).to receive(:gets).and_return('easy')
      expect(console).to receive(:menu_choose_difficulty)
      console.check_difficulty
      expect(game.instance_variable_get(:@difficulty)).to eq 'easy'
    end

    it 'if difficul medium' do
      console.instance_variable_set(:@game, game)
      allow(console).to receive(:gets).and_return('medium')
      expect(console).to receive(:menu_choose_difficulty)
      console.check_difficulty
      expect(game.instance_variable_get(:@difficulty)).to eq 'medium'
    end

    it 'if difficul hell' do
      console.instance_variable_set(:@game, game)
      allow(console).to receive(:gets).and_return('hell')
      expect(console).to receive(:menu_choose_difficulty)
      console.check_difficulty
      expect(game.instance_variable_get(:@difficulty)).to eq 'hell'
    end

    it 'if exit' do
      console.instance_variable_set(:@game, game)
      allow(console).to receive(:gets).and_return('exit')
      expect(console).to receive(:menu_choose_difficulty)
      expect(console.check_difficulty).to eq false
    end

    it 'if invalid difficul' do
      console.instance_variable_set(:@game, game)
      allow(console).to receive(:gets).and_return('test')
      expect(console).to receive(:menu_choose_difficulty)
      expect { console.check_difficulty }.to output(/Error please choose difficul/).to_stdout
    end
  end

  describe '#chek game_process' do
    before do
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
      expect { console.menu_win('1234') }.to output("Secret code: 1234\nYou win)))!!!\nDo you want to save the result? [y/n]\n").to_stdout
    end

    it 'if lose' do
      game.instance_variable_set(:@try, 5)
      expect(game).to receive(:check)
      console.game_process
      expect { console.menu_lose('1234') }.to output("Secret code: 1234\nYou lose(((\nPress entert to continue!\n").to_stdout
    end

    it 'show result' do
      game.instance_variable_set(:@try, 2)
      expect(game).to receive(:check).and_return('+--')
      console.game_process
      expect { console.show_result('+--') }.to output("Result:+--\nPress entert to continue!\n").to_stdout
    end
  end
end
