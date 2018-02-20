require 'marky_markov'

class Lita::MarkovBrain
  BrainEmptyError = Class.new(StandardError)
  NoBrainInputsFound = Class.new(StandardError)

  def initialize(inputs_path:)
    @inputs_path = File.absolute_path(inputs_path)
    @dictionary = ::MarkyMarkov::TemporaryDictionary.new
  end

  attr_reader :dictionary, :inputs_path

  def load_brain!
    return brain_already_full unless empty?
    text_files_path = inputs_path + '/*.txt'

    files = Dir[text_files_path]
    raise NoBrainInputsFound, "No markov input files found at [#{text_files_path}]" if files.none?

    Dir[text_files_path].each do |file|
      load_dictionary(file)
    end

    raise BrainEmptyError if empty?
  end

  def empty?
    dictionary.dictionary.empty?
  end

  def load_dictionary(path)
    logger.debug "Loading Markov input text at: [#{path}]"
    dictionary.parse_file path
  end

  def generate_n_words(n)
    load_brain! if empty?
    dictionary.generate_n_words(n)
  end

  def brain_already_full
    logger.debug 'brain is not empty, aborting load'
  end

  def logger
    Lita.logger
  end
end
