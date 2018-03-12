require 'lita/markov_brain'

module Lita
  module Handlers
    # START:public
    class MarkovBlabber < Handler

      # e.g. lita-markov-brain/dict/name-of-input-file.txt
      DEFAULT_INPUTS_PATH = File.join __dir__, '..', '..', '..', 'dict'

      config :markov_inputs_path, default: DEFAULT_INPUTS_PATH

      on :unhandled_message, :blabber

      def blabber(payload)
        payload.fetch(:message).reply gibberish
      end

      def gibberish
        n = rand(5..20)
        gibberish = brain.generate_n_words n
      end
      # END:public

      # START:private
      private

      def brain
        @@brain ||= Lita::MarkovBrain.new(inputs_path: config.markov_inputs_path)
      end
      # END:private

      Lita.register_handler(self)
    end
  end
end
