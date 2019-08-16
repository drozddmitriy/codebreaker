require_relative 'spec_helper'

RSpec.describe Codebreaker::MenuModule do
  DIFFICULTIES = {
    easy: {
      attempts: 15,
      hints: 2
    },
    medium: {
      attempts: 10,
      hints: 1
    },
    hell: {
      attempts: 5,
      hints: 1
    }
  }.freeze
  let(:console) { Codebreaker::Console.new }

  describe '.show_message_continue' do
    it do
      allow(console).to receive(:gets)
      expect { console.show_message_continue }.to output(I18n.t(:continue)).to_stdout
    end
  end

  describe '.error' do
    let(:name) { 'test' }

    it 'show error name' do
      allow(console).to receive(:gets)
      expect(console).to receive(:show_message_continue)
      expect { console.error(name) }.to output(I18n.t(:error, name: name)).to_stdout
    end
  end

  describe '.show_result' do
    let(:result) { '+--' }

    it do
      allow(console).to receive(:gets)
      expect(console).to receive(:show_message_continue)
      expect { console.show_result(result) }.to output(I18n.t(:show_result, result: result)).to_stdout
    end
  end

  describe '.menu_' do
    let(:code) { '1234' }
    let(:attempts) { 10 }
    let(:hints) { 2 }
    let(:menu_choose) do
      I18n.t(:menu_choose_difficult,
             easy_attempts: DIFFICULTIES[:easy][:attempts],
             easy_hints: DIFFICULTIES[:easy][:hints],
             medium_attempts: DIFFICULTIES[:medium][:attempts],
             medium_hints: DIFFICULTIES[:medium][:hints],
             hell_attempts: DIFFICULTIES[:hell][:attempts],
             hell_hints: DIFFICULTIES[:hell][:hints])
    end

    it 'show lose' do
      allow(console).to receive(:gets)
      expect(console).to receive(:show_message_continue)
      expect { console.menu_lose(code) }.to output(I18n.t(:menu_lose, code: code)).to_stdout
    end

    it 'show win' do
      expect { console.menu_win(code) }.to output(I18n.t(:menu_win, code: code)).to_stdout
    end

    it 'show process' do
      expect { console.menu_process(attempts, hints) }.to output(I18n.t(:menu_process,
                                                                        attempts: attempts,
                                                                        hints: hints)).to_stdout
    end

    it 'show choose_difficulty' do
      expect { console.menu_choose_difficulty(DIFFICULTIES) }.to output(menu_choose).to_stdout
    end
  end
end
