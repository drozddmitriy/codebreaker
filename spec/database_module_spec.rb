require_relative 'spec_helper'

RSpec.describe DatabaseModule do
  let(:console) { Console.new }
  let(:path) { 'data_test.yml' }
  let(:test_data) { { name: 'test3', attempts: 5, hints_total: 1, hints_used: 1, difficulty: 'hell', try: 3 } }

  it '#chek file_exist?' do
    expect { console.file_exist?(path) }.to raise_error(StandardError, 'file not found!')
  end

  it '#check sort_player' do
    load_database = [{ name: 'test1', attempts: 5, hints_total: 1, hints_used: 1, difficulty: 'hell', try: 1 },
                     { name: 'test3', attempts: 5, hints_total: 1, hints_used: 1, difficulty: 'hell', try: 3 },
                     { name: 'test2', attempts: 5, hints_total: 1, hints_used: 1, difficulty: 'hell', try: 2 }]
    expect(console.sort_player(load_database)[2]).to eq test_data
  end

  describe '#check save and load' do
    before(:each) do
      File.new(path, 'w+')
    end

    after(:each) do
      File.delete(path)
    end

    it 'if save data' do
      old_size = File.new(path).size
      console.save(test_data, path)
      new_size = File.new(path).size
      expect(new_size).to be > old_size
    end

    it 'if load data' do
      console.save(test_data, path)
      expect(console.load(path)[0]).to eq test_data
    end
  end
end
