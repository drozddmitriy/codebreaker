require_relative 'spec_helper'

RSpec.describe DatabaseModule do
  subject(:console) { Console.new }
  let(:test_data) { { name: 'test3', attempts: 5, hints_total: 1, hints_used: 1, difficulty: 'hell', try: 3 } }

  describe '.sort_player' do
    let(:load_database) do
      [{ name: 'test1', attempts: 5, hints_total: 1, hints_used: 1, difficulty: 'hell', try: 1 },
       { name: 'test3', attempts: 5, hints_total: 1, hints_used: 1, difficulty: 'hell', try: 3 },
       { name: 'test2', attempts: 5, hints_total: 1, hints_used: 1, difficulty: 'hell', try: 2 }]
    end

    it { expect(console.sort_player(load_database)[2]).to eq test_data }
  end
end
