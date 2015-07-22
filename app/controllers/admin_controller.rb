class AdminController < ApplicationController

  layout "admin"

  before_action :authenticate_user!
  before_action :cleanup_params, only: [:index, :paginate, :show]
  before_action :show_search
  before_action :search_items, only: [:index, :paginate, :show]
  before_action :set_item, only: [:show, :update]

  helper_method :get_item

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordNotUnique, with: :access_denied
  rescue_from CanCan::AccessDenied, with: :access_denied

  def index
    respond_to do |format|
      format.html { render "admin/shared/index" }
      format.js { render "admin/shared/index" }
    end
  end

  def paginate
    respond_to do |format|
      format.js { render "admin/shared/paginate" }
    end
  end

  def show
    respond_to do |format|
      format.html { render "admin/shared/index" }
      format.js { render "admin/shared/show" }
      format.json
    end
  end

  def create
    respond_to do |format|
      format.js do
        @item = if current_user.company? && %w(product location user).include?(model_name)
          new_model_name = model_name == "user" ? "company_user" : model_name
          current_user.userable.send(new_model_name.pluralize).new
        else
          model.new
        end
        @item.save(validate: false)
        instance_variable_set(:"@#{model_name}", @item)

        render "admin/shared/create"
      end
    end
  end

  def update
    respond_to do |format|
      format.json do
        begin
          get_item.update!(resource_params)
        rescue
        end

        respond_with_bip(get_item)
      end
    end
  end

  private

    def cleanup_params
      params.delete(:_)
      params.delete(:utf8)
    end

    def q_params
      @q = params[:q].presence || params.delete(:q)
    end

    def show_search
      @show_search = true
    end

    def search_items
      if @show_search
        @items = model.search(q_params, current_user)
        @items_count = @items.count
        @items_count_text = "#{I18n.t controller_name, count: @items_count} found"
        @items = @items.order("#{sort_column} #{sort_direction}").page(params[:page]).per(50)
        instance_variable_set(:"@#{model_name}", @items.first)
      end
    end

    def get_item
      instance_variable_get(:"@#{model_name}")
    end

    def set_item
      instance_variable_set(:"@#{model_name}", model.find(params[:id]))
    end

    def not_found(exception)
      respond_to do |format|
        format.js { render nothing: true, status: :not_found }
        format.json { render nothing: true, status: :not_found }
        format.html { redirect_to root_path }
      end
    end

    def access_denied(exception)
      respond_to do |format|
        format.js { render nothing: true, status: :forbidden }
        format.json { render nothing: true, status: :forbidden }
        format.html { redirect_to root_path }
      end
    end

end
