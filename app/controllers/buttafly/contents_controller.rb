require_dependency "buttafly/application_controller"

module Buttafly
  class ContentsController < ApplicationController
    before_action :set_content, only: [:show, :edit, :update, :destroy]
    before_action :set_originable_model, only: [:index]

    def index
      @contents = Buttafly::Spreadsheet.all
      # @contents = @originable_model.all
    end

    def show
    end

    def new
      @content = Content.new
    end

    def edit
    end

    def create
      @content = Content.new(content_params)

      if @content.save
        redirect_to @content, notice: 'Content was successfully created.'
      else
        render :new
      end
    end

    def update
      if @content.update(content_params)
        redirect_to @content, notice: 'Content was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @content.destroy
      redirect_to contents_url, notice: 'Content was successfully destroyed.'
    end

    private
      def set_content
        @content = Content.find(params[:id])
      end

      def set_originable_model
        # @originable_model = Buttafly.originable_model.classify.constantize
      end

      def content_params
        params.fetch(:content, {})
      end
  end
end
