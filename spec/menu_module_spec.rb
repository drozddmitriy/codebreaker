require_relative 'spec_helper'

RSpec.describe MenuModule do
  let(:console) { Console.new }

  it '#call message' do
    allow(console).to receive(:gets)
    expect { console.message }.to output(/Press entert to continue!/).to_stdout
  end

  it '#call error' do
    name = 'test'
    allow(console).to receive(:gets)
    expect { console.error(name) }.to output(/Error please enter valid test/).to_stdout
  end

  it '#call menu_lose' do
    code = '1234'
    allow(console).to receive(:gets)
    expect { console.menu_lose(code) }.to output("Secret code: 1234\nYou lose(((\nPress entert to continue!\n").to_stdout
  end

  it '#call show_result' do
    result = '+--'
    allow(console).to receive(:gets)
    expect { console.show_result(result) }.to output("Result:+--\nPress entert to continue!\n").to_stdout
  end

  it '#call menu_win' do
    code = '1234'
    expect { console.menu_win(code) }.to output("Secret code: 1234\nYou win)))!!!\nDo you want to save the result? [y/n]\n").to_stdout
  end

  it '#call menu_process' do
    attempts = 10
    hints = 2
    expect { console.menu_process(attempts, hints) }.to output("Game process:\n******************************\nattempts - 10\n******************************\nyour choise\n******************************\nhint - 2\nexit\n******************************\nEntery you guess!\n").to_stdout
  end

  it '#call menu_choose_difficulty' do
    expect { console.menu_choose_difficulty }.to output("choise difficulties\n******************************\neasy - 15 attempts. 2 hints\nmedium - 10 attempts. 1 hint\nhell - 5 attempts. 1 hint\nexit\n******************************\nPlease choose difficul\n").to_stdout
  end
end
