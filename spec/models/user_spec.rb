require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @oscar = User.create(firstname: "Oscar", lastname: "Bob", email: "test@test.com", password: "test99")
    @oscarred = User.create(firstname: "Oscarred", lastname: "Bob", email: "test@test2.com", password: "test99")
    @yen = User.create(firstname: "Yen", lastname: "Bob", email: "test@test3.com", password: "test99")
    @ian = User.create(firstname: "Ian", lastname: "Bob", email: "test@test4.com", password: "test99")
    @stan = User.create(firstname: "Stan", lastname: "Bob", email: "test@test5.com", password: "test99")
    @phu = User.create(firstname: "Phu", lastname: "Bob", email: "test@test6.com", password: "test99")
    @quy = User.create(firstname: "Quy", lastname: "Bob", email: "test@test7.com", password: "test99")
    @luis = User.create(firstname: "Luis", lastname: "Bob", email: "test@test8.com", password: "test99")    
  end

  describe "autocomplete" do
    it "searching for Os returns Oscar and Oscarred" do
      #results = Array.new
      results = User.autocomplete_by_name("Os")
      expect(results.count).to eq(2)
      expect(results).to include(@oscarred)
    end

    it "searching for Oscarr doesn't return Oscar" do
      #results = Array.new
      results = User.autocomplete_by_name("Oscarr")
      expect(results.count).to eq(1)
      expect(results).not_to include(@oscar)
    end

    it "searching for Lu returns Luis" do
      #results = Array.new
      results = User.autocomplete_by_name("Lu")
      expect(results.count).to eq(1)
      expect(results).to include(@luis)
    end

    it "searching for William returns an empty array" do
      #results = Array.new
      results = User.autocomplete_by_name("William")
      expect(results.count).to eq(0)
    end
  end
end
