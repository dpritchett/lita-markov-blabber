require 'spec_helper'

describe Lita::MarkovBrain do
  let(:test_inputs_path) { File.join(__dir__, '..', '..', 'dict') }

  describe 'given a short file full of words' do
    subject { Lita::MarkovBrain.new(inputs_path: test_inputs_path) } 

    it "can generate n words on demand" do
      n = rand(1..100)
      result = subject.generate_n_words(n)

      expect(result.split.count).to eq(n)
    end

  end

end
