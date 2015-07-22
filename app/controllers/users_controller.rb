class UsersController < AdminController

  authorize_resource

  def update
    respond_to do |format|
      format.json do
        begin
          item = get_item
          item.assign_attributes(resource_params)
          item.save(validate: false)
        rescue
        end

        respond_with_bip(item)
      end
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      params[:user] ||= params[:admin_user] || params[:company_user]
      res = params.fetch(:user, {}).permit(
        :type, :userable_id,
        :prefix, :first_name, :middle_name, :last_name, :suffix, :title,
        :email, :phone, :google_plus, :linked_in
      )
      res.delete(:type) unless current_user.admin?

      res
    end
end
