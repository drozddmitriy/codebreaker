require_relative 'spec_helper'
require_relative '../dependency'

RSpec.describe DatabaseModule do
  # let(:game) { Game.new }

  it "file exist" do
    path = './../data.yml'
    expect(File.exist?(path)).to eq(true)
  end

  it "file not exist" do
    path = ''
    expect(Pathname.new(path)).not_to exist
    # expect(File.exist?(path)).to eq('file not found!')
  end

end
