module YARD::Handlers::Ruby::Sequel::Associations
  module DatasetMethod
    def create_dataset_method
      name           = @statement.parameters.first.jump(:ident).source
      method = YARD::CodeObjects::MethodObject.new(namespace, "#{name}_dataset")
      register(method)
      method.dynamic  = true
      method[:sequel] = :association_dataset
      method.docstring.delete_tags(:return)
      method.docstring.add_tag(YARD::Tags::Tag.new(:return, 'the association\'s dataset.', 'Sequel::Dataset'))
      method
    end
  end
end
