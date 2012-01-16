Rails32Bootstrap::Application.routes.draw do
  devise_for :authors

  get "blog/index"

  root to: "blog#index"
  resources :posts

end
