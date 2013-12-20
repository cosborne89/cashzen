Cashzen::Application.routes.draw do
  resources :budgets do
      collection do 
          get 'month'
      end
  end
  get 'budgets/:year/:month', to: 'budgets#summary_by_month', as: :summary_by_month

  get 'transactions/mobile', to: 'transactions#mobile', as: :mobile_transaction_path  

  resources :transactions
  

  resources :categories do
    collection do
      get 'accrued'
    end
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  get "/auth/:provider/callback" => "sessions#create"
  
  resources :users
  
  devise_scope :user do
    get "/login" => "devise/sessions#new", as: :login_path
    get "/signup" => "devise/registrations#new", as: :signup_path
    delete "/logout" => "devise/sessions#destroy", as: :logout_path
  end
  
  authenticated :user do
    root :to => "budgets#index", :as => :authenticated_root
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
devise_scope :user do
  root to: "devise/sessions#new"
end

  get "/welcome" => "pages#welcome"
  get "/about" => "pages#about"
  get "/contact" => "pages#contact"
  get "/legal" => "pages#legal"
  get "/terms" => "pages#terms"
  get "/mission" => "pages#mission"

  get "/budget_101" => "learn#budget_101"
  get "/budget_102" => "learn#budget_102"
  get "/personal_finance_151" => "learn#personal_finance_151"
  get "/personal_finance_152" => "learn#personal_finance_152"
  get "/setup_201" => "learn#setup_201"
  get "/setup_202" => "learn#setup_202"
  get "/tips" => "learn#tips"


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
