module ActiveAdmin
  module Views
    
    class Header < Component
      
      def get_authorized_menu_items
        if current_admin_user.admin?
          return [
            { :title=>"Dashboard", :url=>admin_root_path },
            { :title=>"Users", :url=>admin_admin_users_path },
            { :title=>"Consultations", :url=>admin_consultations_path },
            { :title=>"Coupons", :url=>admin_coupons_path },
            { :title=>"Patients", :url=>admin_patients_path },
            { :title=>"Payments", :url=>admin_payments_path },
            { :title=>"Comments", :url=>admin_comments_path }
          ]
        elsif current_admin_user.regular?
          return [
            { :title=>"Dashboard", :url=>admin_root_path },
            { :title=>"Consultations", :url=>admin_consultations_path },
            { :title=>"Patients", :url=>admin_patients_path },
            { :title=>"Comments", :url=>admin_comments_path }
          ]
        end
      end
      
      def build(namespace, menu)
      
        super :id => "header"
        super :style => "text-align: left;"    
  
          @namespace = namespace
          # @menu = Menu.new do |m|
          #   for item in get_authorized_menu_items
          #     m.add label: item[:title], url: item[:url]
          #   end
          # end
          @menu = menu
          @utility_menu = @namespace.fetch_menu(:utility_navigation)
        
        div do 
          build_site_title
          build_global_navigation
          build_utility_navigation
        end
      end
      
      def build_site_title
        insert_tag view_factory.site_title, @namespace
      end

      def build_global_navigation
        insert_tag view_factory.global_navigation, @menu, class: 'header-item tabs'
      end

      def build_utility_navigation
        insert_tag view_factory.utility_navigation, @utility_menu, id: "utility_nav", class: 'header-item tabs'
      end
      
    end
    
  end
end
  