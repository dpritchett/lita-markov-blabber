require 'spec_helper'

describe Lita::Handlers::MarkovBlabber, lita_handler: true do
  let(:test_inputs_path) { File.join(__dir__, '..', '..', 'dict') }

  let(:robot) { Lita::Robot.new(registry) }

  before do
    robot.config.handlers.markov_blabber.markov_inputs_path = test_inputs_path
  end

  subject { described_class.new(robot) }

  describe ':gibberish' do
    it 'responds with a caption and an image URL' do
      result = subject.gibberish
      word_count = result.split.count
      expect(word_count > 4).to be_truthy
      expect(word_count < 30).to be_truthy
    end

    it 'answers arbitrary inputs' do
      lyrics = ['welcome to the jungle',
                'take me down to the paradise city',
                "shed a tear cause i'm missing you"]

      lyrics.each do |lyric|
        send_message lyric
        response = replies.last
        word_count = response.split.count

        expect(word_count > 4).to be_truthy
        expect(word_count < 30).to be_truthy
      end
    end
  end
end
