require_dependency "buttafly/application_controller"

module Buttafly
  class LegendsController < ApplicationController
    before_action :set_legend, only: [:show, :edit, :update, :destroy]

    # GET /legends
    def index
      @legends = Legend.all
    end

    # GET /legends/1
    def show
    end

    # GET /legends/new
    def new
      @legend = Legend.new
    end

    # GET /legends/1/edit
    def edit
    end

    # POST /legends
    def create
      @legend = Legend.new(legend_params)

      if @legend.save
        redirect_to @legend, notice: 'Legend was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /legends/1
    def update
      if @legend.update(legend_params)
        redirect_to @legend, notice: 'Legend was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /legends/1
    def destroy
      @legend.destroy
      redirect_to legends_url, notice: 'Legend was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_legend
        @legend = Legend.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def legend_params
        params.fetch(:legend, {})
      end
  end
end
