module ShowFor
  module Attribute
    def attribute_with_stonewall(attribute_name, options={}, &block)
      apply_default_options!(attribute_name, options)
      collection_block, block = block, nil if collection_block?(block)
      
      if @object.respond_to?(:send?) && !allowed?(@object, current_user, attribute_name)
        wrap_label_and_content(attribute_name, (I18n.t :"show_for.redacted", :default => "Redacted"), options, &collection_block)
      else
        attribute_without_stonewall(attribute_name, options, &block)
      end
    end 
    alias_method_chain :attribute, :stonewall
  end
end