Rails.application.routes.draw do
	root to: 'articles#index'

	# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
	resources :articles, only: %i[show index new create edit update destroy]
	resources :users, except: %i[new]
	get 'signup', to: 'users#new'
end
