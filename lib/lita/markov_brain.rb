require 'marky_markov'

class Lita::MarkovBrain
  def initialize
    @dictionary ||= ::MarkyMarkov::TemporaryDictionary.new
  end

  attr_reader :dictionary

  def inputs_path
    File.join __dir__, '..', '..', 'dict', '*.txt'
  end

  def load_dictionaries
    Dir[inputs_path].each do |file|
      load_dictionary(file)
    end
  end

  def load_dictionary(path)
    logger.debug "Loading Markov input text at: [#{path}]"
    dictionary.parse_file path
  end

  def generate_n_words(n)
    dictionary.generate_n_words(n)
  end

  def logger
    Lita.logger
  end
end
