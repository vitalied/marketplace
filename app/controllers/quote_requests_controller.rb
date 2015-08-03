class QuoteRequestsController < ApplicationController
  before_action :set_quote, only: [:show, :search, :update]

  def index
  end

  def show
  end

  def search
    redirect_to quote_request_path(@quote.number)
  end

  # GET /quotes/new
  def new
    @quote = Quote.new
    @quote.build_quote_user
    @quote.quote_items.build
  end

  # POST /quotes
  # POST /quotes.json
  def create
    @quote = Quote.new(quote_params)

    respond_to do |format|
      if @quote.save
        format.html { redirect_to quote_request_path(@quote.number), notice: 'Quote was successfully created.' }
        format.json { render :show, status: :created, location: @quote }
      else
        format.html { render :new }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_network
    respond_to do |format|
      format.js {}
      format.all { head 404 }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find_by_number!(params[:id])
    rescue
      redirect_to quote_requests_path(q: params[:id]), notice: "Ooops... quote request not found"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quote_params
      params.fetch(:quote, {}).permit(
        :number,
        company_ids: [],
        quote_user_attributes: [:id, :quote_id, :first_name, :last_name, :company, :email, :phone],
        quote_items_attributes: [:id, :quote_id, :network, :location, :location_z, :line_type, :port_speed, :access_speed, { term: [] }, :router, :router_z, :qos]
      )
    end
end
