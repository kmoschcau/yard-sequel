module YARD::Handlers::Ruby::Sequel::Associations
  module ToOneMethod
    def create_to_one_method
      name   = @statement.parameters.first.jump(:ident).source
      method = YARD::CodeObjects::MethodObject.new(namespace, name)
      register(method)
      method.dynamic  = true
      method[:sequel] = :association
      method.docstring.delete_tags(:return)
      method.docstring.add_tag(YARD::Tags::Tag.new(:return, 'the association\'s record.', name.classify))
      method
    end
  end
end
