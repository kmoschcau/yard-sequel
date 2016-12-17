module YARD::Handlers::Ruby::Sequel::Associations
  class ManyToOneHandler < YARD::Handlers::Ruby::MethodHandler
    include YARD::Handlers::Ruby::Sequel::Associations::AssociationHandler
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
