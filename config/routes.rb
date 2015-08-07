Rails.application.routes.draw do

  devise_for :users
  root "products#index"

  #get '/work', to: "products#work"

   get 'ui(/:action)', controller: 'ui'

  resources :products do
    collection do
      get 'add_to_cart'
    end
  end

  namespace :admin do
    resources :orders, only: [:index] do
      get :make_payment
      get :make_delivery
      collection do
        get 'kds'
      end

    end
  end

  resources :carts, only: [:index] do
    collection do
      post 'update_cart_content'
    end
  end

  resources :cart_items, only: [:update, :destroy]
  resources :orders, only: [:index, :new, :create]
  get 'certificate_phone', to: 'orders#certificate_phone'


  namespace :kds do
    resources :api do
      collection do
        get     'queue_status'
      end
    end
  end



  namespace :pos do
    resources :api do
      collection do
        get     'get_order'
        get     'get_orders'
        post    'create_order'
        post    'update_order'
        delete  'cancel_order'
        post    'confirm_order'
      end
    end
  end


  #resources :sessions, only: :create

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
