Rails.application.routes.draw do
 
  root 'home#index'

  resources :specialties

  resources :moving_tasks

  resources :moving_items

  resources :table_defs

  resources :reports do
    member do
      get :prepare
      get :exec
    end
    collection do
      get :test
      get :icon_selector
    end
  end

  resources :wings

  resources :equipment_items

  resources :space_types

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  resources :equipment_models do
    member do
      get :show_modal
    end
  end

  resources :equipment_groups

  resources :requirements do
    member do
      get :show_modal
      get :show_allocated_floors
    end
  end

  resources :spaces do
    member do
      get :show_modal
    end
  end

  resources :allocations do
    member do
      get :show_modal
    end
    collection do
      get :auto_new
    end
  end

  resources :people do
    member do
      get :show_modal
      get :show_allocated_floors
    end
  end

  resources :orgs do
    member do
      get :show_allocated_floors
      get :show_right
      get :export
    end
    collection do
      get :export_all
    end
  end

  resources :floors do
    member do
      get :drawing
      get :drawing_full
      get :drawing_allocations
      get :drawing_locator
      get :edit_spaces
      get :bulk_space_type_modal
      get :bulk_coor_adjust
      get :export
      post :bulk_space_type
    end
  end

  resources :buildings do
    member do
      get :photo
      get :export
    end
  end

  match 'do_import_data', to: 'home#do_import_data', via: :post

  resources :home, only: [ :index ] do
    collection do
      get :back
      get :counter_cache_reset
      get :import_data
      get :backup
    end
  end

  resources :users do
    member do
      get :change_password_for
      post :do_change_password_for
    end
    collection do
      get :change_password
      get :do_change_language
      patch :do_change_password
    end
  end

  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}

  get 'home/index'

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
