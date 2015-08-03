require 'rails_helper'

RSpec.describe "quote_requests/new", type: :view do
  before(:each) do
    assign(:quote, Quote.new(
      number: "Number-1"
    ))
  end

  it "renders new quote form" do
    render
  end
end
