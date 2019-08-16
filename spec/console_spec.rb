require_relative 'spec_helper'

RSpec.describe Codebreaker::Console do
  subject(:game) { Codebreaker::Game.new }

  let(:console) { described_class.new }

  describe '.run' do
    before do
      allow(console).to receive(:loop).and_yield
    end

    it 'and returns rules' do
      allow(console).to receive(:gets) { I18n.t(:rule) }
      console.run
    end

    it 'and exit' do
      allow(console).to receive(:gets) { I18n.t(:exit) }
      console.run
    end

    it 'and returns stats' do
      allow(console).to receive(:gets) { I18n.t(:stats) }
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

    context 'when exit return false' do
      it do
        allow(console).to receive(:gets) { I18n.t(:exit) }
        expect(console.registration).to eq false
      end
    end

    context 'when valid name return name' do
      it do
        allow(console).to receive(:gets) { name }
        console.registration
        expect(game.instance_variable_get(:@player)).to eq name
      end
    end

    context 'when invalid name return error' do
      it do
        allow(console).to receive(:loop).and_yield
        allow(console).to receive(:gets) { name_test }
        expect(console).to receive(:show_message_continue)
        expect { console.registration }.to output(I18n.t(:entery_name) + I18n.t(:error, name: name_i18t)).to_stdout
      end
    end
  end

  describe '.input' do
    before do
      game.instance_variable_set(:@attempts, 10)
      game.instance_variable_set(:@hints_total, 2)
      console.instance_variable_set(:@game, game)
      expect(console).to receive(:menu_process)
    end

    context 'when exit return false' do
      it do
        allow(console).to receive(:gets) { I18n.t(:exit) }
        expect(console.input).to eq false
      end
    end

    it 'return valid guess' do
      allow(console).to receive(:gets) { '1234' }
      console.input
      expect(game.instance_variable_get(:@input_code)).to eq '1234'
    end

    context 'when invalid guess return error' do
      let(:guess) { I18n.t(:guess) }
      it do
        allow(console).to receive(:loop).and_yield
        allow(console).to receive(:gets) { 'te' }
        expect(console).to receive(:show_message_continue)
        expect { console.input }.to output(I18n.t(:error, name: guess)).to_stdout
      end
    end

    context 'if guess hint' do
      before do
        game.set_code
        allow(console).to receive(:loop).and_yield
      end

      it 'and return hint' do
        allow(console).to receive(:gets) { I18n.t(:hint) }
        console.input
        expect(game.instance_variable_get(:@hints_used)).to eq 1
      end

      it 'and return no hint' do
        game.hints_used = 2
        allow(console).to receive(:gets).and_return(I18n.t(:hint))
        expect(console).to receive(:show_message_continue)
        expect { console.input }.to output(I18n.t(:no_hints)).to_stdout
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
      allow(console).to receive(:gets) { I18n.t(:easy, scope: [:difficulty]) }
      console.check_difficulty
      expect(game.instance_variable_get(:@difficulty)).to eq I18n.t(:easy, scope: [:difficulty])
    end

    it 'and set medium' do
      allow(console).to receive(:gets) { I18n.t(:medium, scope: [:difficulty]) }
      console.check_difficulty
      expect(game.instance_variable_get(:@difficulty)).to eq I18n.t(:medium, scope: [:difficulty])
    end

    it 'and set hell' do
      allow(console).to receive(:gets) { I18n.t(:hell, scope: [:difficulty]) }
      console.check_difficulty
      expect(game.instance_variable_get(:@difficulty)).to eq I18n.t(:hell, scope: [:difficulty])
    end

    it 'and exit' do
      allow(console).to receive(:gets) { I18n.t(:exit) }
      expect(console.check_difficulty).to eq false
    end

    context 'when invalid difficul' do
      it do
        allow(console).to receive(:gets) { 'test' }
        expect(console).to receive(:show_message_continue)
        expect { console.check_difficulty }.to output(I18n.t(:please_choose_difficul)).to_stdout
      end
    end
  end

  describe '.game_process' do
    before do
      allow(console).to receive(:loop).and_yield
      game.instance_variable_set(:@code, '1234')
      game.instance_variable_set(:@attempts, 5)
      console.instance_variable_set(:@game, game)
      allow(console).to receive(:gets).and_return('')
      expect(console).to receive(:input).and_return(5)
    end

    it 'when win' do
      game.instance_variable_set(:@try, 2)
      expect(game).to receive(:win?).and_return(true)
      console.game_process
      expect { console.menu_win(game.code) }.to output(I18n.t(:menu_win, code: game.code)).to_stdout
    end

    it 'when lose' do
      game.instance_variable_set(:@try, 5)
      expect(game).to receive(:check)
      console.game_process
      expect(console).to receive(:show_message_continue)
      expect { console.menu_lose(game.code) }.to output(I18n.t(:menu_lose, code: game.code)).to_stdout
    end
  end
end
