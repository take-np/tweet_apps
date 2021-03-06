Rails.application.routes.draw do

  get "login" => "users#login_form"
  post "login" => "users#login"
  # /login で上記2つのルーティングはかぶっているように見えるが、getとpostでは異なるルーティングとして扱われるので問題ない
  # link_toではデフォルトで、getのルーティングを探し、form_tagではデフォルトで、postのルーティングを探す
  post "logout" => "users#logout"

  post "users/:id/update" => "users#update"

  post "users/create" => "users#create"
  get 'users/index' => "users#index"
  get "users/:id/edit" => "users#edit"
  get "users/:id" => "users#show"
  get "signup" => "users#new"

  # urlは表示名でしかない。signupも、urlに表示されるだけで、コントローラ- アクション。ビューーページ、の関係性は、users#newで示されている

  get 'posts/index' => "posts#index"
  get "posts/new" => "posts#new"
  get "posts/:id" => "posts#show"
  post "posts/create" => "posts#create"

  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"

  get 'top' => "home#top"
  # ルーティングを書き換えると、トップページのURLを変更できる。
  get "/" => "home#top"
  get "about" => "home#about"


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
