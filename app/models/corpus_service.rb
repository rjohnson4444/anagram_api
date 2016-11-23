class CorpusService
  CORPUS = {}

  def self.create_dictionary
    @dictionary ||= unzip_dictionary
  end

  def self.add(words)
    words.each { |word| find_anagrams(word) }
  end

  def self.delete_all_words
    CORPUS.clear
  end

  def self.delete_word(params)
    word = params[:word]
    unless word.nil?
      delete_word_and_anagrams(word)
      CORPUS.each { |_, anagrams| delete_word_from_other_anagrams(word, anagrams) }
    end
  end

  def self.anagrams(params)
    if params[:limit]
      selected_anagrams = limited_anagrams(params)
    else
      selected_anagrams = CORPUS[params[:word]]
    end

    {
      anagrams: selected_anagrams || []
    }
  end

  private

    def self.unzip_dictionary
      zip_dictionary = File.open("#{Rails.root}/dictionary.txt.gz")
      Zlib::GzipReader.new(zip_dictionary).read.split("\n")
    end

    def self.find_anagrams(word)
      return if CORPUS.has_key?(word)

      CORPUS[word] = []
      @dictionary.each { |dictionary_word| CORPUS[word] << compare_words(word, dictionary_word) }
      CORPUS[word].keep_if { |w| w.downcase != word.downcase unless w.nil? }
      CORPUS[word].uniq!
      CORPUS[word].compact!
    end

    def self.compare_words(word1, word2)
      sorted_word1 = word1.downcase.chars.sort.join
      sorted_word2 = word2.downcase.chars.sort.join
      word2 if sorted_word1 == sorted_word2
    end

    def self.limited_anagrams(params)
      word  = params[:word]
      limit = params[:limit].to_i - 1
      CORPUS[word][0..limit] if CORPUS.has_key?(word)
    end

    def self.delete_word_from_other_anagrams(word, anagrams)
      anagrams.delete_if { |anagram| anagram.downcase == word.downcase }
    end

    def self.delete_word_and_anagrams(word)
      CORPUS.delete_if { |key_word, _| key_word.downcase == word.downcase }
    end

end
