module YARD::Handlers::Ruby::Sequel::Associations
  module DatasetMethod
    def create_dataset_method
      method = YARD::CodeObjects::MethodObject.new(namespace, "#{association_name}_dataset")
      register(method)
      method.dynamic  = true
      method[:sequel] = :association
      method.docstring.delete_tags(:return)
      method.docstring.add_tag(YARD::Tags::Tag.new(:return, 'the association\'s dataset.', 'Sequel::Dataset'))
      method
    end
  end
end
