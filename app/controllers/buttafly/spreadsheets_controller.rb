require_dependency "buttafly/application_controller"

module Buttafly
  class SpreadsheetsController < ApplicationController
    before_action :set_spreadsheet, only: [:show, :edit, :update, :destroy]

    def index

      @spreadsheets = Buttafly::Spreadsheet.all
    end

    def show
    end

    def new
      @spreadsheet = Buttafly::Spreadsheet.new
    end

    def edit
    end

    def create
      @spreadsheet = Spreadsheet.new(spreadsheet_params)
byebug
      if @spreadsheet.save
        redirect_to @spreadsheet, notice: 'Spreadsheet was successfully created.'
      else
        render :new
      end
    end

    def update
      if @spreadsheet.update(spreadsheet_params)
        redirect_to @spreadsheet, notice: 'Spreadsheet was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @spreadsheet.destroy
      redirect_to spreadsheets_url, notice: 'Spreadsheet was successfully destroyed.'
    end

    private
      def set_spreadsheet
        @spreadsheet = Spreadsheet.find(params[:id])
      end

      def spreadsheet_params
        params.require(:spreadsheet).permit(:name, :flat_file, :aasm_state, :uploader_id, :imported_at, :processed_at, :mtime)
      end
  end
end
