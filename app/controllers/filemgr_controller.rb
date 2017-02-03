class FilemgrController < ApplicationController
  def index
    root=Document.find_by_parent_id(0)
    @docs=Document.get_docs(root)
  end
end


