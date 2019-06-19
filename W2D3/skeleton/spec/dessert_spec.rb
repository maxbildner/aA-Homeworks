require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef", name: "Max") }                 # define "helper" object called, chef (these do not persist across it blocks?)
  subject(:paoDeQueijo) { Dessert.new('Pastry', 20, chef) }  # creates instance of dessert obj, does persist across it blocks?

  describe "#initialize" do
    it "sets a type" do
      expect(paoDeQueijo.type).to eq('Pastry')
    end

    it "sets a quantity" do
      expect(paoDeQueijo.quantity).to eq(20)
    end

    it "starts ingredients as an empty array" do
      expect(paoDeQueijo.ingredients.empty?).to eq(true)
    end
  
    it "raises an argument error when given a non-integer quantity" do
      expect { paoDeQueijo.quantity("20") }.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      expect(paoDeQueijo.add_ingredient("sugar")). to eq(["sugar"])
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      expect(paoDeQueijo.mix!).to receive(:shuffle!)
      paoDeQueijo.mix!
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      paoDeQueijo.eat(15)
      expect(paoDeQueijo.quantity).to eq(5)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect { paoDeQueijo.eat(100)}.to raise_error("not enough left!")
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      allow(chef).to receive(:titleize).and_return("Chef Max the Great Baker")
      expect(paoDeQueijo.serve).to eq("Chef Max the Great Baker has made 20 Pastries!")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with(paoDeQueijo)
      paoDeQueijo.make_more
    end
  end
end
