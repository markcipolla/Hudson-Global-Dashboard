require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "Buildserver Model" do
  it 'can be created' do
    @buildserver = Buildserver.new
    @buildserver.should_not be_nil
  end
end
