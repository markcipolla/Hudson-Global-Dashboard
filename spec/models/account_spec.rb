require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "Account Model" do
  it 'can be created' do
    @account = Account.new
    @account.should_not be_nil
  end
end
