require_dependency "buttafly/application_controller"

module Buttafly
  class SpreadsheetsController < ApplicationController
    before_action :set_spreadsheet, only: [:show, :edit, :update, :destroy]
    before_action :set_originable_klass

    def index
      @spreadsheets = @originable_klass.all
    end

    def show
    end

    def new
      @spreadsheet = @originable_klass.new
    end

    def edit
    end

    def create
      @spreadsheet = @originable_klass.new(spreadsheet_params)
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

      def set_originable_klass
        @originable_klass = Buttafly.originable_model.classify.constantize
      end

      def set_spreadsheet
        set_originable_klass
        @spreadsheet = @originable_klass.find(params[:id])
      end

      def spreadsheet_params
        params.fetch(:spreadsheet, {}).permit(:name, :flat_file, :aasm_state, :uploader_id, :imported_at, :processed_at, :mtime)
      end
  end
end
