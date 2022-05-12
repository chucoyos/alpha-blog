Rails.application.routes.draw do
	root to: 'users#new'

	# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
	resources :articles, only: %i[show index new create edit update destroy]
	resources :users, except: %i[new]
	resources :categories, except: %i[destroy]
	get 'signup', to: 'users#new'
	get 'login', to: 'sessions#new'
	post 'login', to: 'sessions#create'
	delete 'logout', to: 'sessions#destroy'
end
