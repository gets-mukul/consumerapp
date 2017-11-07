ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      
      columns do
        column do
          panel "Latest Patients" do
            
            # table_for Patient('id desc').limit(10) do
            table_for Patient.order("id desc").limit(10) do
  
              column(:name) {|patient| link_to patient.id, admin_patient_path(patient.id) } 
              column(:mobile)
              column(:pay_status)
            end
          end
        end
      end # columns
    end
  end # content
  
end
