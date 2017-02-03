class Document < ActiveRecord::Base
  attr_accessible :absolute_path, :file_path, :file_size, :file_type, :name, :parent_id

  belongs_to :parent, :class_name=>"Document"
  has_many :children,:foreign_key=>:parent_id,:class_name=>"Document"

  #root=Document.find_by_parent_id(0)
  def self.get_docs(doc,arr=[],flag=true)
    name=doc.name
    name=doc.name+"."+doc.file_type unless doc.file_type.nil?
    hash={"id"=>doc.id,"pId"=>doc.parent_id,"name"=>name}
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
=end



