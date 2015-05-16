require 'spec_helper'

feature 'Authors' do
  before(:each) do
    (1..1000).to_a.shuffle.each do |n|
      FactoryGirl.create(:author, id: n, name: 'same name')
    end
  end

  it 'should not show the same record on two different pages', js: true do
    run_mocha_spec 'authors'
  end
end
