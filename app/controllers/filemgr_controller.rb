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
    @new_url=doc.name
    respond_to do |format|
      format.js
    end
  end

  def create_folder
    duplicated_doc=Document.find_by_name(params["folder_name"])

    if duplicated_doc
      render :json => { :data => "error",:msg=>Document::NAME_UNIQUE}.to_json
    else
      pdoc=Document.find(params["pid"])
      absolute_path=Rails.root.to_s+"/public/"+pdoc.file_path
			doc_path=absolute_path+"/"+params["folder_name"]
			FileUtils.mkdir(doc_path)
			doc=Document.new
			doc.name=params["folder_name"]
			doc.parent_id=pdoc.id
			doc.file_path=pdoc.file_path+"/"+params["folder_name"]
			doc.save
      
      hash=doc.format_doc
			render :json => { :data => "ok", :id=>doc.id,:doc=>hash }.to_json
    end
  end

  def remove_folder
    doc=Document.find(params["id"])
    unless doc.parent_id==0
      absolute_path=Rails.root.to_s+"/public/"+doc.file_path
      FileUtils.rm_r(absolute_path)
      Document.destroy_doc(doc)
    end

    root=Document.find_by_parent_id(0)
    @doc_arr=root.children_docs
    @path=root.file_path.split("/")[1..-1]
    @new_url=root.name
  end

  def rename_folder
    doc=Document.find(params["id"])
    if doc
      if doc.name!=params["name"]
		    duplicated_doc=Document.find_by_name(params["name"])
				if duplicated_doc
				  render :json => { :data => "error",:msg=>Document::NAME_UNIQUE}.to_json
				else
		      old_name=doc.name
		      old_path=doc.file_path
		      path=Document.replace_name(doc.file_path,old_name,params["name"])
		      doc.file_path=path
		      doc.name=params["name"]
					if doc.save
		        new_absolute_path=Rails.root.to_s+"/public/"+doc.file_path
		        old_absolute_path=Rails.root.to_s+"/public/"+old_path
		        FileUtils.mv(old_absolute_path,new_absolute_path)

		        doc.children.each do |c|
		          Document.modify_path(c,old_name,params["name"])
		        end
		        render :json => { :data => "ok", :newname=>doc.name }.to_json
		      else
		        render :json => { :data => "error",:msg=>doc.errors.to_h[:name]}.to_json
		      end
				end
      else
        render :json => { :data => "error",:msg=>"please rename your folder"}.to_json
		  end
    else
      render :json => { :data => "error",:msg=>"can not find doc with id"}.to_json
    end
  end
end
#d.errors.to_h[:name]

