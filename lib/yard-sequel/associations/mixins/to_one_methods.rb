module YARD::Handlers::Ruby::Sequel::Associations
  module ToOneMethods
    def create_to_one_getter
      name   = association_name
      method = YARD::CodeObjects::MethodObject.new(namespace, name)
      register(method)
      method.dynamic  = true
      method[:sequel] = :association
      method.docstring.delete_tags(:return)
      method.docstring.add_tag(YARD::Tags::Tag.new(:return, 'the association\'s record.', name.classify))
      method
    end

    def create_to_one_setter
      name   = association_name
      method = YARD::CodeObjects::MethodObject.new(namespace, "#{name}=")
      register(method)
      method.dynamic  = true
      method[:sequel] = :association
      method.parameters << [name, nil]
      method.docstring += "Associates the passed #{name.classify} with this record."
      method.docstring.add_tag(YARD::Tags::Tag.new(:param, "The #{name.classify} to associate with this record.", name.classify, name))
      method
    end
  end
end
