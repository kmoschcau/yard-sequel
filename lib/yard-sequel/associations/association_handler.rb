module YARD
  module Handlers
    module Ruby
      module Sequel
        module Associations
          # The basic method handler class for Sequel associations.
          # @author Kai Moschcau
          class AssociationHandler < YARD::Handlers::Ruby::MethodHandler
            protected

            def association_name
              @statement.parameters.first.jump(:ident).source
            end

            def add_param_tag(method, name, class_name, description)
              method.parameters << [name, nil]
              method.docstring.add_tag(
                YARD::Tags::Tag.new(
                  :param,
                  description,
                  class_name,
                  name
                )
              )
            end

            def create_method_object(name)
              method = YARD::CodeObjects::MethodObject.new(
                namespace,
                name
              )
              register_and_tag(method)
              method
            end

            def register_and_tag(method)
              unless method.is_a? YARD::CodeObjects::MethodObject
                raise(
                  ArgumentError,
                  'The given method has to be a '\
                  "#{YARD::CodeObjects::MethodObject}"
                )
              end
              register(method)
              method.dynamic  = true
              method[:sequel] = :association
            end

            def return_tag(method, class_name, description)
              method.docstring.delete_tags(:return)
              method.docstring.add_tag(
                YARD::Tags::Tag.new(
                  :return,
                  description,
                  class_name
                )
              )
            end

            def void_return_tag(method)
              method.docstring.delete_tags(:return)
              method.docstring.add_tag(
                YARD::Tags::Tag.new(
                  :return,
                  nil,
                  'void'
                )
              )
            end
          end
        end
      end
    end
  end
end
