module YARD
  module Handlers
    module Ruby
      module Sequel
        module Associations
          # The basic method handler class for Sequel associations.
          # @author Kai Moschcau
          class AssociationHandler < YARD::Handlers::Ruby::MethodHandler
            protected

            METH_OBJ = YARD::CodeObjects::MethodObject

            def association_name
              @statement.parameters.first.jump(:ident).source
            end

            def create_dataset_method
              method = METH_OBJ.new(namespace, "#{association_name}_dataset")
              register(method)
              method.dynamic  = true
              method[:sequel] = :association
              method.docstring.delete_tags(:return)
              method.docstring.add_tag(
                YARD::Tags::Tag.new(
                  :return,
                  'the association\'s dataset.',
                  'Sequel::Dataset'
                )
              )
              method
            end

            def create_to_many_adder
              name   = association_name
              method = METH_OBJ.new(namespace, "add_#{name.singularize}")
              register(method)
              method.dynamic  = true
              method[:sequel] = :association
              method.parameters << [name.singularize, nil]
              method.docstring += "Associates the passed #{name.classify}"\
                                  'with this record.'
              method.docstring.add_tag(
                YARD::Tags::Tag.new(
                  :param,
                  "The #{name.classify} to associate with this record.",
                  name.classify,
                  name.singularize
                )
              )
              method
            end

            def create_to_many_clearer
              name   = association_name
              method = METH_OBJ.new(namespace, "remove_all_#{name}")
              register(method)
              method.dynamic   = true
              method[:sequel]  = :association
              method.docstring += 'Removes the association of all'\
                                  "#{name.classify} records with this record."
              method
            end

            def create_to_many_getter
              name   = association_name
              method = METH_OBJ.new(namespace, name)
              register(method)
              method.dynamic  = true
              method[:sequel] = :association
              method.docstring.delete_tags(:return)
              method.docstring.add_tag(
                YARD::Tags::Tag.new(
                  :return,
                  'the association\'s records.',
                  "Array<#{name.classify}>"
                )
              )
              method
            end

            def create_to_many_remover
              name   = association_name
              method = METH_OBJ.new(namespace, "remove_#{name.singularize}")
              register(method)
              method.dynamic  = true
              method[:sequel] = :association
              method.parameters << [name.singularize, nil]
              method.docstring += 'Removes the association of the passed'\
                                  "#{name.classify} with this record."
              method.docstring.add_tag(
                YARD::Tags::Tag.new(
                  :param,
                  "The #{name.classify} to remove the association with this"\
                  'record from.',
                  name.classify,
                  name.singularize
                )
              )
              method
            end

            def create_to_one_getter
              name   = association_name
              method = METH_OBJ.new(namespace, name)
              register(method)
              method.dynamic  = true
              method[:sequel] = :association
              method.docstring.delete_tags(:return)
              method.docstring.add_tag(
                YARD::Tags::Tag.new(
                  :return,
                  'the association\'s record.',
                  name.classify
                )
              )
              method
            end

            def create_to_one_setter
              name   = association_name
              method = METH_OBJ.new(namespace, "#{name}=")
              register(method)
              method.dynamic  = true
              method[:sequel] = :association
              method.parameters << [name, nil]
              method.docstring += "Associates the passed #{name.classify}"\
                                  'with this record.'
              method.docstring.add_tag(
                YARD::Tags::Tag.new(
                  :param,
                  "The #{name.classify} to associate with this record.",
                  name.classify,
                  name
                )
              )
              method
            end
          end
        end
      end
    end
  end
end
