require_relative 'spec_helper'

RSpec.describe MenuModule do
  let(:console) { Console.new }

  it '#call message' do
    allow(console).to receive(:gets)
    expect { console.message }.to output(I18n.t(:continue)).to_stdout
  end

  it '#call error' do
    name = 'test'
    allow(console).to receive(:gets)
    expect(console).to receive(:message)
    expect { console.error(name) }.to output(I18n.t(:error, name: name)).to_stdout
  end

  it '#call menu_lose' do
    code = '1234'
    allow(console).to receive(:gets)
    expect(console).to receive(:message)
    expect { console.menu_lose(code) }.to output(I18n.t(:menu_lose, code: code)).to_stdout
  end

  it '#call show_result' do
    result = '+--'
    allow(console).to receive(:gets)
    expect(console).to receive(:message)
    expect { console.show_result(result) }.to output(I18n.t(:show_result, result: result)).to_stdout
  end

  it '#call menu_win' do
    code = '1234'
    expect { console.menu_win(code) }.to output(I18n.t(:menu_win, code: code)).to_stdout
  end

  it '#call menu_process' do
    attempts = 10
    hints = 2
    expect { console.menu_process(attempts, hints) }.to output(I18n.t(:menu_process, attempts: attempts, hints: hints)).to_stdout
  end

  it '#call menu_choose_difficulty' do
    expect { console.menu_choose_difficulty }.to output(I18n.t(:menu_choose_difficult)).to_stdout
  end
end
