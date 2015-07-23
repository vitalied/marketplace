module ProductsHelper

  def category_name(product)
    Settings.products.categories
            .try(product.category.to_s).try(:name)
  end

  def hash_options_for_product_category
    res = Settings.products.categories
    res = res.map{ |el| [el.first, el.last.name] } if res.present?
    res.to_h
  end

  def product_class_name(product)
    Settings.products.categories
            .try(product.category.to_s)
            .try(:product_classes).try(product.product_class.to_s).try(:name)
  end

  def hash_options_for_product_class(product)
    res = Settings.products.categories
                  .try(product.category.to_s)
                  .try(:product_classes)
    res = res.map{ |el| [el.first, el.last.name] } if res.present?
    res.to_h
  end

  def product_type_name(product)
    Settings.products.categories
            .try(product.category.to_s)
            .try(:product_classes).try(product.product_class.to_s)
            .try(:product_types).try(product.product_type.to_s)
  end

  def hash_options_for_product_type(product)
    Settings.products.categories
            .try(product.category.to_s)
            .try(:product_classes).try(product.product_class.to_s)
            .try(:product_types).to_h
  end

  def custom_attributes_for_product(product)
    res = Settings.products.categories
                  .try(product.category.to_s)
                  .try(:product_classes).try(product.product_class.to_s)
                  .try(:custom_attrs)
    res = res.map{ |el| [el.first, el.last.name] } if res.present?
    res.to_h
  end

  def custom_attribute_for_product_values(product, custom_attr)
    Settings.products.categories
            .try(product.category.to_s)
            .try(:product_classes).try(product.product_class.to_s)
            .try(:custom_attrs).try(custom_attr.to_s).try(:values).to_h
  end

end
