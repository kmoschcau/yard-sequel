module YARD
  module Handlers
    module Ruby
      module Sequel
        module Associations
          # The handler class for Sequel many_to_one associations.
          # @author Kai Moschcau
          class ManyToOneHandler < AssociationHandler
            include YARD::Handlers::Ruby::Sequel::Associations::DatasetMethod
            include YARD::Handlers::Ruby::Sequel::Associations::ToOneMethods

            handles method_call(:many_to_one)
            namespace_only

            process do
              create_to_one_getter
              create_to_one_setter

              create_dataset_method
            end
          end
        end
      end
    end
  end
end
