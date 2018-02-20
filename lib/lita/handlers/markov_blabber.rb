require 'lita/markov_brain'

module Lita
  module Handlers
    class MarkovBlabber < Handler

      on :loaded, :on_loaded
      on :unhandled_message, :blabber

      def on_loaded(payload)
        brain.load_dictionaries
      end

      def brain
        self.class.brain
      end

      def blabber(payload)
        n = rand(5..20)
        gibberish = brain.generate_n_words n

        payload.fetch(:message).reply gibberish
      end

      # Save a class-wide
      def self.brain
        @brain ||= Lita::MarkovBrain.new
      end

      Lita.register_handler(self)
    end
  end
end
