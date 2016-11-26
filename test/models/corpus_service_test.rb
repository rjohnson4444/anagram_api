class CorpusServiceTest < Minitest::Test
  def setup
    CorpusService.delete_all_words
  end

  def add_words_to_corpus
    added_words = %w(read dare write add)
    CorpusService.create_dictionary
    CorpusService.add(added_words)
  end

  def test_creates_a_dictionary
    dictionary = CorpusService.create_dictionary

    assert_equal 235886, dictionary.count
  end

  def test_add_anagram_words_to_corpus
    add_words_to_corpus
    params             = { word: 'read' }
    read_anagram_words = CorpusService.anagrams(params)
    expected_result    = { anagrams:  %w(ared daer dare dear) }

    assert_equal expected_result, read_anagram_words
  end

  def test_deletes_all_words_from_corpus
    add_words_to_corpus
    params            = { word: 'read' }
    expected_result   = { anagrams: %w(ared daer dare dear) }
    returned_anagrams = CorpusService.anagrams(params)

    assert_equal expected_result, returned_anagrams

    CorpusService.delete_all_words
    deleted_results           = { anagrams: [] }
    deleted_returned_anagrams = CorpusService.anagrams(params)

    assert_equal deleted_results, deleted_returned_anagrams
  end

  def test_deletes_single_word_from_corpus
    add_words_to_corpus
    read_params       = { word: 'read' }
    expected_result   = { anagrams: %w(ared daer dare dear) }

    returned_anagrams = CorpusService.anagrams(read_params)

    assert_equal expected_result, returned_anagrams

    CorpusService.delete_word(read_params)
    deleted_read_anagrams    = CorpusService.anagrams(read_params)
    expected_deleted_results = { anagrams: [] }

    assert_equal expected_deleted_results, deleted_read_anagrams
  end

  def test_deletes_single_word_from_anagram_list_of_other_words
    add_words_to_corpus
    new_params            = { word: 'dare' }
    word_to_be_deleted    = { word: 'read' }
    CorpusService.delete_word(word_to_be_deleted)
    new_returned_anagrams = CorpusService.anagrams(new_params)

    assert new_returned_anagrams.count < 2
    refute new_returned_anagrams.include?('read')
  end

  def test_anagrams_returns_empty_array_if_word_is_not_found_in_corpus
    expected = { anagrams: [] }
    params   = { word: 'read' }
    result   = CorpusService.anagrams(params)

    assert_equal expected, result
  end

end
