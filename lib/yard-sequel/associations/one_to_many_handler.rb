module YARD::Handlers::Ruby::Sequel::Associations
  class OneToManyHandler < YARD::Handlers::Ruby::MethodHandler
    include YARD::Handlers::Ruby::Sequel::Associations::DatasetMethod
    include YARD::Handlers::Ruby::Sequel::Associations::ToManyMethod

    handles method_call(:one_to_many)
    namespace_only

    process do
      create_to_many_method

      create_dataset_method
    end
  end
end
