require 'spec_helper'

describe Lita::Handlers::MarkovBlabber, lita_handler: true do
  # START:setup

  # e.g. lita-markov-blabber/spec/dict/moby-dick-sample.txt
  let(:test_inputs_path) { File.join(__dir__, '..', '..', 'dict') }

  let(:robot) { Lita::Robot.new(registry) }

  before do
    robot.config.handlers.markov_blabber.markov_inputs_path = test_inputs_path
  end

  subject { described_class.new(robot) }
  # END:setup

  # START:tests
  describe ':gibberish' do
    it 'generates lots of words' do
      result = subject.gibberish
      word_count = result.split.count
      expect(word_count > 4).to be_truthy
      expect(word_count < 30).to be_truthy
    end
  end

  describe 'blabber' do
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
  # END:tests
end
