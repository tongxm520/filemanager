class Document < ActiveRecord::Base
  attr_accessible :file_path, :file_size, :file_type, :name, :parent_id

  belongs_to :parent, :class_name=>"Document"
  has_many :children,:foreign_key=>:parent_id,:class_name=>"Document"

  NAME_FORMAT= 'must consist of a-z,0-9,underscores,chinese character and between 3 and 16.'
  validates :name ,format: {with: /^[\-a-z0-9_\u4e00-\u9fa5]{3,16}$/i,message: NAME_FORMAT}
  NAME_UNIQUE="Folder name has been taken, please change another one"

  IMAGE_TYPE=["gif","jpg","jpeg","png","bmp","GIF","JPG","JPEG","PNG","BMP"]
  COMMON_FILE=["ppt","docx","doc","xls","pdf","txt"]

  #root=Document.find_by_parent_id(0)
  def self.get_docs(doc,arr=[],flag=true)
    name=doc.name
    name=doc.name+"."+doc.file_type unless doc.file_type.nil?
    hash={"id"=>doc.id,"pId"=>doc.parent_id,"name"=>name,"url"=>"#{doc.name}", "target"=>"_self"}
    hash["open"]=true if doc.file_type.nil?
    if flag
      hash["iconClose"]="/assets/zTreeStyle/img/diy/Close.png" 
      hash["iconOpen"]="/assets/zTreeStyle/img/diy/Open.png"
      hash["icon"]="/assets/zTreeStyle/img/diy/Close.png"
    end
    arr << hash

    if doc.children.count>0
      doc.children.each do |c|
        flag= c.children.count>0 || c.file_type.nil?
        get_docs(c,arr,flag) if flag
      end
    end
    arr
  end

  def children_docs
    children_docs=self.children
    children_arr=[]
    children_docs.each do |doc|
      hash=doc.format_doc
      children_arr << hash
    end
    children_arr
  end

  def format_doc
    children_hash=Hash.new
    doc=self
    children_hash["name"]=doc.name
    unless doc.file_type.nil?
      children_hash["name"] += "."
      children_hash["name"] += doc.file_type
    end
    children_hash["date"]=doc.updated_at.strftime("%Y-%m-%d %H:%M:%S")

    children_hash["file_tag"]="NOT_IMAGE"
    children_hash["type"]=doc.file_type
    if doc.file_type.nil?
      children_hash["type"]="文件夹"
      children_hash["file_tag"]="FOLDER"
    end

    if doc.file_type and IMAGE_TYPE.include?(doc.file_type)
      children_hash["file_tag"]="IMAGE"
    end

    if doc.file_type and COMMON_FILE.include?(doc.file_type)
      children_hash["file_tag"]="COMMON_FILE"
    end

    if doc.file_size.nil?
      children_hash["size"]=""
    else
      children_hash["size"]=doc.file_size.truncate(3).to_s('F')
    end
    children_hash["path"]=doc.file_path
    children_hash
  end

  def self.destroy_doc(doc)
    if doc.children.count>0
      doc.children.each do |c|
        destroy_doc(c)
      end      
    end
    doc.destroy
  end

  def self.modify_path(doc,old_name,new_name)
    path=replace_name(doc.file_path,old_name,new_name)
    doc.file_path=path
    doc.save
    if doc.children.count>0
      doc.children.each do |d|
        modify_path(d,old_name,new_name)
      end      
    end
  end

  def self.replace_name(path,old_name,new_name)
    path_arr=path.split("/")
    path_arr.each_with_index do |p,i|
      if p==old_name
        path_arr[i]=new_name
      end
    end
    path_arr.join("/")
  end
end

=begin
怎样用ruby程序递归得到一个文件夹下所有文件列表

ArrayList<String> filelist=refreshFileList("路径",new ArrayList<String>());

public ArrayList<String> refreshFileList(String strPath,ArrayList<String> filelist) {
  //遍历指定目录
  File dir = new File(strPath); 
  File[] files = dir.listFiles(); 
  if(files != null) {
    for(int i = 0; i < files.length; i++) { 
      if(files[i].isDirectory()) { 
        filelist=refreshFileList(files[i].getAbsolutePath(),filelist); 
      }else {
        filelist.add(files[i].getAbsolutePath());
      } 
    }
  }
  return filelist; 
}

Without rounding, and without converting to a Float, use BigDecimal#truncate:

v = BigDecimal("7.1762")
v.truncate(2).to_s('F')
# => "7.17"

If you need to show trailing zeroes, it gets more complicated:

v = BigDecimal("4.1")
v.truncate.to_s + '.' + sprintf('%02d', (v.frac * 100).truncate)
# => "4.10"

which uses truncate to convert to an Integer, always exact (and without rounding).
=end



