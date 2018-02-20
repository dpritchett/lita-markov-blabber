require "spec_helper"

describe Lita::Handlers::MarkovBlabber, lita_handler: true do
  let(:robot) { Lita::Robot.new(registry) }

  subject { described_class.new(robot) }

  describe ':blabber' do
    it 'responds with a caption and an image URL' do
      send_message "this isn't matched"
      response = replies.last
      word_count = response.split.count
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
