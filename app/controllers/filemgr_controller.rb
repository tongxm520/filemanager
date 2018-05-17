class FilemgrController < ApplicationController
  def show
    root=Document.find_by_parent_id(0)
    @docs=Document.get_docs(root)
    
    if params[:docname].nil?
      @root_arr=root.children_docs
      @current_id=root.id
      @path=root.file_path.split("/")[1..-1]
    else
      doc=Document.find_by_name(params[:docname])
      @root_arr=doc.children_docs
      @current_id=doc.id
      @path=doc.file_path.split("/")[1..-1]
    end
  end

  def show_doc    
    doc=Document.find(params[:id])
    @doc_arr=doc.children_docs
    @doc_path=doc.file_path.split("/")[1..-1] 
    @new_url="http://localhost:3001/"+doc.name
    respond_to do |format|
      format.js
    end
  end

  def create_folder
    duplicated_doc=Document.find_by_name(params["folder_name"])

    if duplicated_doc
      render :json => { :data => "error",:msg=>"Folder name has been taken, please change another one"}.to_json
    else
      pdoc=Document.find(params["pid"])
			doc_path=pdoc.absolute_path+"/"+params["folder_name"]
			FileUtils.mkdir(doc_path)
			doc=Document.new
			doc.name=params["folder_name"]
			doc.parent_id=pdoc.id
			doc.file_path=pdoc.file_path+"/"+params["folder_name"]
			doc.absolute_path=doc_path
			doc.save

			render :json => { :data => "ok", :id=>doc.id }.to_json
    end
  end

  def remove_folder
    doc=Document.find(params["id"])
    unless doc.parent_id==0
      FileUtils.rm_r(doc.absolute_path)
      Document.destroy_doc(doc)
    end

    root=Document.find_by_parent_id(0)
    @doc_arr=root.children_docs
    @path=root.file_path.split("/")[1..-1]
    @new_url="http://localhost:3001/"+root.name
  end
end


