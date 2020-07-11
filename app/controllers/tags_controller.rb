# frozen_string_literal: true

class TagsController < ApplicationController
  def index
    @tags = Tag.page(params[:page])
  end

  def destroy
    tag.destroy!
    redirect_to tags_path, notice: 'Tag destroyed'
  end

  private

  def tag
    @tag ||= Tag.find(params[:id])
  end
end
