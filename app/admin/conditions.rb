ActiveAdmin.register Condition do

  actions :all, :except => [:destroy]
  batch_action :destroy, false
  permit_params :key, :title, :inline_desc, :desc

  index do
    column :id
    column :key
    column :title
    column "Inline Desc" do |condition|
      condition.inline_desc.html_safe
    end
    column :updated_at
    
    actions
  end
  
  show do
    attributes_table do
      row :id
      row :key
      row :title
      row("Inline Description") { condition.inline_desc.html_safe }
      row("Description") { condition.desc.html_safe }
      row :updated_at
    end
  end
  
  form do |f|
    f.inputs "Edit" do
      f.input :key
      f.input :title
      f.input :inline_desc, :label => "Inline Description"
      f.input :desc, :label => "Description", :as => :text
      f.actions
    end
  end
end
