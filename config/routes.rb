Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.

  get 'anagrams/:word' => 'anagrams#show'
  post 'words'         => 'words#create'
  delete 'words/:word' => 'words#destroy'
  delete 'words'       => 'anagrams#destroy'
end
