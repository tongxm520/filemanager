class FilemgrController < ApplicationController
  def show
    root=Document.find_by_parent_id(0)
    @docs=Document.get_docs(root)
    
    if params[:docname].nil?
      @root_arr=root.children_docs
      @current_id=root.id
    else
      doc=Document.find_by_name(params[:docname])
      @root_arr=doc.children_docs
      @current_id=doc.id
    end
  end
end


