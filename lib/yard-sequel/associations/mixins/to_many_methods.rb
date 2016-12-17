module YARD::Handlers::Ruby::Sequel::Associations
  module ToManyMethods
    def create_to_many_adder
      name   = association_name
      method = YARD::CodeObjects::MethodObject.new(namespace, "add_#{name.singularize}")
      register(method)
      method.dynamic  = true
      method[:sequel] = :association
      method.parameters << [name.singularize, nil]
      method.docstring += "Associates the passed #{name.classify} with this record."
      method.docstring.add_tag(YARD::Tags::Tag.new(:param, "The #{name.classify} to associate with this record.", name.classify, name.singularize))
      method
    end

    def create_to_many_clearer
      name   = association_name
      method = YARD::CodeObjects::MethodObject.new(namespace, "remove_all_#{name}")
      register(method)
      method.dynamic  = true
      method[:sequel] = :association
      method.docstring += "Removes the association of all #{name.classify} records with this record."
      method
    end

    def create_to_many_getter
      name   = association_name
      method = YARD::CodeObjects::MethodObject.new(namespace, name)
      register(method)
      method.dynamic  = true
      method[:sequel] = :association
      method.docstring.delete_tags(:return)
      method.docstring.add_tag(YARD::Tags::Tag.new(:return, 'the association\'s records.', "Array<#{name.classify}>"))
      method
    end

    def create_to_many_remover
      name   = association_name
      method = YARD::CodeObjects::MethodObject.new(namespace, "remove_#{name.singularize}")
      register(method)
      method.dynamic  = true
      method[:sequel] = :association
      method.parameters << [name.singularize, nil]
      method.docstring += "Removes the association of the passed #{name.classify} with this record."
      method.docstring.add_tag(YARD::Tags::Tag.new(:param, "The #{name.classify} to remove the association with this record from.", name.classify, name.singularize))
      method
    end
  end
end
