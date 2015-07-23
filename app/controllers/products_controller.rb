class ProductsController < AdminController

  authorize_resource

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      params.fetch(:product, {}).permit(:type, :company_id, :name, :custom_name, :category, :product_class, :product_type, *Product::CUSTOM_ATTRS)
    end
end
