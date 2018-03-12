# START:public
require 'marky_markov'

class Lita::MarkovBrain
  NoBrainInputsFound = Class.new(StandardError)

  def initialize(inputs_path:)
    @inputs_path = File.absolute_path(inputs_path)
    @dictionary = ::MarkyMarkov::TemporaryDictionary.new
    load_brain!
  end

  def generate_n_words(n)
    dictionary.generate_n_words(n)
  end
  # END:public

  # START:private
  private

  attr_reader :dictionary, :inputs_path

  def load_brain!
    return unless dictionary.dictionary.empty?
    text_files_path = inputs_path + '/*.txt'

    files = Dir[text_files_path]

    if files.none?
      raise(NoBrainInputsFound,
            "No markov input files found at [#{text_files_path}]")
    end

    Dir[text_files_path].each do |file|
      load_dictionary(file)
    end
  end

  def load_dictionary(path)
    logger.debug "Loading Markov input text at: [#{path}]"
    dictionary.parse_file path
  end

  def logger
    Lita.logger
  end
  # END:private
end
