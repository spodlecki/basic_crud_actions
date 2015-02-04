class ActsAsCrudGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :model_name, required: true,
           desc: 'the name of the model the controller you are'\
           ' creating is controlling'
  def create_controller_file
    template 'controller.rb.erb', "app/controllers/#{model_name}s_controller.rb"
  end
end
