Rails.application.routes.draw do
  
  # we got these two routes from using rails g controller
  # get 'posts/index'
  # get 'users/show'
  
  # we made our pages controller's home action's view as our default home page(root)
  root 'posts#index'
  
  # we did this to change the names of links in the url
  devise_for :users,
   path: '',
   path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration'},
   controllers: {omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'}

  # get '/users/:id', to: 'users#show'
  # /users/3 -> Users controller, show action, params {id: '3'}
   resources :users, only: [:show]

   # resources doesn't needs us to send id in the url as well, so it is same as get '/posts/:id', to: 'posts#show'.
   # Also, we have used nested resoures for photos as it's like a child of post. Everytime we will need a post_id when we need a photo!
  resources :posts, only: [:index, :show, :create, :destroy] do
 	  resources :photos, only: [:create]
    resources :likes, only: [:create, :destroy], shallow: true
  end

end
