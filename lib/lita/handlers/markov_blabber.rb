require 'marky_markov'

module Lita
  module Handlers
    class MarkovBlabber < Handler
      # insert handler code here
      #
      on :unhandled_message, :blabber

      def self.load_dictionaries
        markov = ::MarkyMarkov::TemporaryDictionary.new

        dicts_path = File.join __dir__, '..', '..', '..', 'dict', '*'
        files = Dir[dicts_path]

        files.each { |file| markov.parse_file file }

        @@brain = markov
      end

      def blabber(payload)
        n = rand(5..20)
        gibberish = @@brain.generate_n_words n

        payload[:message].reply gibberish
      end

      load_dictionaries

      Lita.register_handler(self)
    end
  end
end
