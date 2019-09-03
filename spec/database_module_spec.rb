require_relative 'spec_helper'

RSpec.describe Codebreaker::DatabaseModule do
  subject(:console) { Codebreaker::Console.new }

  let(:path) { 'data_test.yml' }
  let(:test_data) { { name: 'test3', attempts: 5, hints_total: 1, hints_used: 1, difficulty: 'hell', try: 3 } }

  it '#file_exist?' do
    expect { console.file_exist(path) }.to raise_error(StandardError, I18n.t(:file_not_found))
  end

  describe 'check save and load' do
    before { File.new(path, 'w+') }

    after { File.delete(path) }

    context 'when save data' do
      it do
        old_size = File.new(path).size
        console.save(test_data, path)
        new_size = File.new(path).size
        expect(new_size).to be > old_size
      end
    end

    context 'when load data' do
      it do
        console.save(test_data, path)
        expect(console.load(path)[0]).to eq test_data
      end
    end
  end
end
