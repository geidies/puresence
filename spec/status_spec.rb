ENV['RACK_ENV'] = 'test'

require 'app'
require 'rack/test'

describe "the status model" do

  status = Status.instance

  it "should set true when status is false" do
    status.set false
    expect( status.get ).to be false
    status.set true
    expect( status.get ).to be true
  end

  it "should set false when status is true" do
    status.set true
    expect( status.get ).to be true
    status.set false
    expect( status.get ).to be false
  end

  it "should NOT set plan when status is true" do
    status.set true
    expect( status.get ).to be true
    status.plan 1
    expect( status.get ).to be true
  end

  it "should set set plan status is false" do
    status.set false
    expect( status.get ).to be false
    status.plan 10
    # expect( status.get ).to be_is_a String
    expect( status.get ).to eq "plan"
  end

  it "should set eta when setting plan" do
    status.set false
    expect( status.get ).to be false
    status.plan 10
    expect( status.eta ).to be_within(2).of(10)
  end

  it "should return false when eta has expired" do
    status.set false
    expect( status.get ).to be false
    status.plan 1
    sleep 2
    expect( status.get ).to be false
  end
end
