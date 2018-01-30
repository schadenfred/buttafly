require_dependency "buttafly/application_controller"

module Buttafly
  class LegendsController < ApplicationController
    before_action :set_legend, only: [:show, :edit, :update, :destroy]

    def index
      @legends = Legend.all
    end

    def show
    end

    def new
      @spreadsheet = Buttafly::Spreadsheet.find(params["spreadsheet_id"])
      @legend = @spreadsheet.legends.new
      @targetable_model = params["targetable_model"]
    end

    def edit
    end

    def create

      @legend = Legend.new(legend_params)

      if @legend.save
        redirect_to @legend, notice: 'Legend was successfully created.'
      else
        render :new
      end
    end

    def update
      if @legend.update(legend_params)
        redirect_to @legend, notice: 'Legend was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @legend.destroy
      redirect_to legends_url, notice: 'Legend was successfully destroyed.'
    end

    private
      def set_legend
        @legend = Legend.find(params[:id])
      end

      def legend_params
        params.require(:legend).permit(:data => {})
      end
  end
end
