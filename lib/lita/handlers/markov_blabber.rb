require 'lita/markov_brain'

module Lita
  module Handlers
    class MarkovBlabber < Handler
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

      def brain
        inputs_path = config.markov_inputs_path
        @brain ||= Lita::MarkovBrain.new(inputs_path: inputs_path)
      end

      Lita.register_handler(self)
    end
  end
end
