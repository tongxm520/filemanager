#rails runner script/load_docs.rb
#/home/simon/Desktop/filemanager/public/uploads/根目录/经典视频/HelloWorld
#uploads/根目录/经典视频/HelloWorld

VIEW_ROOT_PATH="uploads"
SAVE_ROOT_PATH="#{Rails.root.to_s}/public/#{VIEW_ROOT_PATH}"
DOC_SRC="#{Rails.root.to_s}/docs"

name="根目录"
FileUtils.mkdir_p("#{SAVE_ROOT_PATH}/#{name}")
root=Document.create(:name=>name,:parent_id=>0,:file_path=>"#{VIEW_ROOT_PATH}/#{name}")

name1="工作文档"
FileUtils.mkdir_p("#{SAVE_ROOT_PATH}/#{name}/#{name1}")
doc1=Document.create(:name=>name1,:parent_id=>root.id,:file_path=>"#{VIEW_ROOT_PATH}/#{name}/#{name1}")

name11="Presentations"
FileUtils.mkdir_p("#{SAVE_ROOT_PATH}/#{name}/#{name1}/#{name11}")
doc11=Document.create(:name=>name11,:parent_id=>doc1.id,:file_path=>"#{VIEW_ROOT_PATH}/#{name}/#{name1}/#{name11}")

name111="October2014"
format=File.extname("#{DOC_SRC}/C语言教学课件.ppt").split(".")[1]
size=File.size?("#{DOC_SRC}/C语言教学课件.ppt")/1000.0
FileUtils.cp("#{DOC_SRC}/C语言教学课件.#{format}", "#{SAVE_ROOT_PATH}/#{name}/#{name1}/#{name11}/#{name111}.#{format}")
Document.create(:name=>name111,:parent_id=>doc11.id,:file_path=>"#{VIEW_ROOT_PATH}/#{name}/#{name1}/#{name11}/#{name111}.#{format}",:file_type=>format,:file_size=>size)

name112="June2014"
format=File.extname("#{DOC_SRC}/C语言教学课件.ppt").split(".")[1]
size=File.size?("#{DOC_SRC}/C语言教学课件.ppt")/1000.0
FileUtils.cp("#{DOC_SRC}/C语言教学课件.#{format}", "#{SAVE_ROOT_PATH}/#{name}/#{name1}/#{name11}/#{name112}.#{format}")
Document.create(:name=>name112,:parent_id=>doc11.id,:file_path=>"#{VIEW_ROOT_PATH}/#{name}/#{name1}/#{name11}/#{name112}.#{format}",:file_type=>format,:file_size=>size)


name113="2016五月"
format=File.extname("#{DOC_SRC}/C语言教学课件.ppt").split(".")[1]
size=File.size?("#{DOC_SRC}/C语言教学课件.ppt")/1000.0
FileUtils.cp("#{DOC_SRC}/C语言教学课件.#{format}", "#{SAVE_ROOT_PATH}/#{name}/#{name1}/#{name11}/#{name113}.#{format}")
Document.create(:name=>name113,:parent_id=>doc11.id,:file_path=>"#{VIEW_ROOT_PATH}/#{name}/#{name1}/#{name11}/#{name113}.#{format}",:file_type=>format,:file_size=>size)


name12="统计报表"
FileUtils.mkdir_p("#{SAVE_ROOT_PATH}/#{name}/#{name1}/#{name12}")
doc12=Document.create(:name=>name12,:parent_id=>doc1.id,:file_path=>"#{VIEW_ROOT_PATH}/#{name}/#{name1}/#{name12}")

name121="美国地区"
FileUtils.mkdir_p("#{SAVE_ROOT_PATH}/#{name}/#{name1}/#{name12}/#{name121}")
doc121=Document.create(:name=>name121,:parent_id=>doc12.id,:file_path=>"#{VIEW_ROOT_PATH}/#{name}/#{name1}/#{name12}/#{name121}")

name1211="Sales美国"
format=File.extname("#{DOC_SRC}/C语言教学课件.ppt").split(".")[1]
size=File.size?("#{DOC_SRC}/C语言教学课件.ppt")/1000.0
FileUtils.cp("#{DOC_SRC}/C语言教学课件.#{format}", "#{SAVE_ROOT_PATH}/#{name}/#{name1}/#{name12}/#{name121}/#{name1211}.#{format}")
Document.create(:name=>name1211,:parent_id=>doc121.id,:file_path=>"#{VIEW_ROOT_PATH}/#{name}/#{name1}/#{name12}/#{name121}/#{name1211}.#{format}",:file_type=>format,:file_size=>size)

name1212="Prices美国"
format=File.extname("#{DOC_SRC}/C语言教学课件.ppt").split(".")[1]
size=File.size?("#{DOC_SRC}/C语言教学课件.ppt")/1000.0
FileUtils.cp("#{DOC_SRC}/C语言教学课件.#{format}", "#{SAVE_ROOT_PATH}/#{name}/#{name1}/#{name12}/#{name121}/#{name1212}.#{format}")
Document.create(:name=>name1212,:parent_id=>doc121.id,:file_path=>"#{VIEW_ROOT_PATH}/#{name}/#{name1}/#{name12}/#{name121}/#{name1212}.#{format}",:file_type=>format,:file_size=>size)

name1213="美国Products"
format=File.extname("#{DOC_SRC}/C语言教学课件.ppt").split(".")[1]
size=File.size?("#{DOC_SRC}/C语言教学课件.ppt")/1000.0
FileUtils.cp("#{DOC_SRC}/C语言教学课件.#{format}", "#{SAVE_ROOT_PATH}/#{name}/#{name1}/#{name12}/#{name121}/#{name1213}.#{format}")
Document.create(:name=>name1213,:parent_id=>doc121.id,:file_path=>"#{VIEW_ROOT_PATH}/#{name}/#{name1}/#{name12}/#{name121}/#{name1213}.#{format}",:file_type=>format,:file_size=>size)

name1214="美国Overview"
format=File.extname("#{DOC_SRC}/2015湖南高考语文试题.docx").split(".")[1]
size=File.size?("#{DOC_SRC}/2015湖南高考语文试题.docx")/1000.0
FileUtils.cp("#{DOC_SRC}/2015湖南高考语文试题.#{format}", "#{SAVE_ROOT_PATH}/#{name}/#{name1}/#{name12}/#{name121}/#{name1214}.#{format}")
Document.create(:name=>name1214,:parent_id=>doc121.id,:file_path=>"#{VIEW_ROOT_PATH}/#{name}/#{name1}/#{name12}/#{name121}/#{name1214}.#{format}",:file_type=>format,:file_size=>size)

name122="Europe"
FileUtils.mkdir_p("#{SAVE_ROOT_PATH}/#{name}/#{name1}/#{name12}/#{name122}")
doc122=Document.create(:name=>name122,:parent_id=>doc12.id,:file_path=>"#{VIEW_ROOT_PATH}/#{name}/#{name1}/#{name12}/#{name122}")

name1221="欧洲Products"
format=File.extname("#{DOC_SRC}/C语言教学课件.ppt").split(".")[1]
size=File.size?("#{DOC_SRC}/C语言教学课件.ppt")/1000.0
FileUtils.cp("#{DOC_SRC}/C语言教学课件.#{format}", "#{SAVE_ROOT_PATH}/#{name}/#{name1}/#{name12}/#{name122}/#{name1221}.#{format}")
Document.create(:name=>name1221,:parent_id=>doc122.id,:file_path=>"#{VIEW_ROOT_PATH}/#{name}/#{name1}/#{name12}/#{name122}/#{name1221}.#{format}",:file_type=>format,:file_size=>size)

name1222="欧洲Overview"
format=File.extname("#{DOC_SRC}/2015湖南高考语文试题.docx").split(".")[1]
size=File.size?("#{DOC_SRC}/2015湖南高考语文试题.docx")/1000.0
FileUtils.cp("#{DOC_SRC}/2015湖南高考语文试题.#{format}", "#{SAVE_ROOT_PATH}/#{name}/#{name1}/#{name12}/#{name122}/#{name1222}.#{format}")
Document.create(:name=>name1222,:parent_id=>doc122.id,:file_path=>"#{VIEW_ROOT_PATH}/#{name}/#{name1}/#{name12}/#{name122}/#{name1222}.#{format}",:file_type=>format,:file_size=>size)

name123="Asia"
FileUtils.mkdir_p("#{SAVE_ROOT_PATH}/#{name}/#{name1}/#{name12}/#{name123}")
doc123=Document.create(:name=>name123,:parent_id=>doc12.id,:file_path=>"#{VIEW_ROOT_PATH}/#{name}/#{name1}/#{name12}/#{name123}")

name1231="亚洲Products"
format=File.extname("#{DOC_SRC}/C语言教学课件.ppt").split(".")[1]
size=File.size?("#{DOC_SRC}/C语言教学课件.ppt")/1000.0
FileUtils.cp("#{DOC_SRC}/C语言教学课件.#{format}", "#{SAVE_ROOT_PATH}/#{name}/#{name1}/#{name12}/#{name123}/#{name1231}.#{format}")
Document.create(:name=>name1231,:parent_id=>doc123.id,:file_path=>"#{VIEW_ROOT_PATH}/#{name}/#{name1}/#{name12}/#{name123}/#{name1231}.#{format}",:file_type=>format,:file_size=>size)

name1232="亚洲Overview"
format=File.extname("#{DOC_SRC}/2015湖南高考语文试题.docx").split(".")[1]
size=File.size?("#{DOC_SRC}/2015湖南高考语文试题.docx")/1000.0
FileUtils.cp("#{DOC_SRC}/2015湖南高考语文试题.#{format}", "#{SAVE_ROOT_PATH}/#{name}/#{name1}/#{name12}/#{name123}/#{name1232}.#{format}")
Document.create(:name=>name1232,:parent_id=>doc123.id,:file_path=>"#{VIEW_ROOT_PATH}/#{name}/#{name1}/#{name12}/#{name123}/#{name1232}.#{format}",:file_type=>format,:file_size=>size)

name2="收藏图片"
FileUtils.mkdir_p("#{SAVE_ROOT_PATH}/#{name}/#{name2}")
doc2=Document.create(:name=>name2,:parent_id=>root.id,:file_path=>"#{VIEW_ROOT_PATH}/#{name}/#{name2}")

name21="Thumbnails"
FileUtils.mkdir_p("#{SAVE_ROOT_PATH}/#{name}/#{name2}/#{name21}")
doc21=Document.create(:name=>name21,:parent_id=>doc2.id,:file_path=>"#{VIEW_ROOT_PATH}/#{name}/#{name2}/#{name21}")

name211="ruby"
format=File.extname("#{DOC_SRC}/rails.png").split(".")[1]
size=File.size?("#{DOC_SRC}/rails.png")/1000.0
FileUtils.cp("#{DOC_SRC}/rails.#{format}", "#{SAVE_ROOT_PATH}/#{name}/#{name2}/#{name21}/#{name211}.#{format}")
Document.create(:name=>name211,:parent_id=>doc21.id,:file_path=>"#{VIEW_ROOT_PATH}/#{name}/#{name2}/#{name21}/#{name211}.#{format}",:file_type=>format,:file_size=>size)

name212="python"
format=File.extname("#{DOC_SRC}/rails.png").split(".")[1]
size=File.size?("#{DOC_SRC}/rails.png")/1000.0
FileUtils.cp("#{DOC_SRC}/rails.#{format}", "#{SAVE_ROOT_PATH}/#{name}/#{name2}/#{name21}/#{name212}.#{format}")
Document.create(:name=>name212,:parent_id=>doc21.id,:file_path=>"#{VIEW_ROOT_PATH}/#{name}/#{name2}/#{name21}/#{name212}.#{format}",:file_type=>format,:file_size=>size)

name213="java"
format=File.extname("#{DOC_SRC}/rails.png").split(".")[1]
size=File.size?("#{DOC_SRC}/rails.png")/1000.0
FileUtils.cp("#{DOC_SRC}/rails.#{format}", "#{SAVE_ROOT_PATH}/#{name}/#{name2}/#{name21}/#{name213}.#{format}")
Document.create(:name=>name213,:parent_id=>doc21.id,:file_path=>"#{VIEW_ROOT_PATH}/#{name}/#{name2}/#{name21}/#{name213}.#{format}",:file_type=>format,:file_size=>size)

name22="Baseimages"
FileUtils.mkdir_p("#{SAVE_ROOT_PATH}/#{name}/#{name2}/#{name22}")
doc22=Document.create(:name=>name22,:parent_id=>doc2.id,:file_path=>"#{VIEW_ROOT_PATH}/#{name}/#{name2}/#{name22}")

name221="数据结构"
format=File.extname("#{DOC_SRC}/auto.jpg").split(".")[1]
size=File.size?("#{DOC_SRC}/auto.jpg")/1000.0
FileUtils.cp("#{DOC_SRC}/auto.#{format}", "#{SAVE_ROOT_PATH}/#{name}/#{name2}/#{name22}/#{name221}.#{format}")
Document.create(:name=>name221,:parent_id=>doc22.id,:file_path=>"#{VIEW_ROOT_PATH}/#{name}/#{name2}/#{name22}/#{name221}.#{format}",:file_type=>format,:file_size=>size)

name222="操作系统原理"
format=File.extname("#{DOC_SRC}/auto.jpg").split(".")[1]
size=File.size?("#{DOC_SRC}/auto.jpg")/1000.0
FileUtils.cp("#{DOC_SRC}/auto.#{format}", "#{SAVE_ROOT_PATH}/#{name}/#{name2}/#{name22}/#{name222}.#{format}")
Document.create(:name=>name222,:parent_id=>doc22.id,:file_path=>"#{VIEW_ROOT_PATH}/#{name}/#{name2}/#{name22}/#{name222}.#{format}",:file_type=>format,:file_size=>size)

name223="大数据"
format=File.extname("#{DOC_SRC}/auto.jpg").split(".")[1]
size=File.size?("#{DOC_SRC}/auto.jpg")/1000.0
FileUtils.cp("#{DOC_SRC}/auto.#{format}", "#{SAVE_ROOT_PATH}/#{name}/#{name2}/#{name22}/#{name223}.#{format}")
Document.create(:name=>name223,:parent_id=>doc22.id,:file_path=>"#{VIEW_ROOT_PATH}/#{name}/#{name2}/#{name22}/#{name223}.#{format}",:file_type=>format,:file_size=>size)

name3="经典视频"
FileUtils.mkdir_p("#{SAVE_ROOT_PATH}/#{name}/#{name3}")
doc3=Document.create(:name=>name3,:parent_id=>root.id,:file_path=>"#{VIEW_ROOT_PATH}/#{name}/#{name3}")

name31="傲慢与偏见"
format=File.extname("#{DOC_SRC}/POI数据库.xls").split(".")[1]
size=File.size?("#{DOC_SRC}/POI数据库.xls")/1000.0
FileUtils.cp("#{DOC_SRC}/POI数据库.#{format}", "#{SAVE_ROOT_PATH}/#{name}/#{name3}/#{name31}.#{format}")
Document.create(:name=>name31,:parent_id=>doc3.id,:file_path=>"#{VIEW_ROOT_PATH}/#{name}/#{name3}/#{name31}.#{format}",:file_type=>format,:file_size=>size)

name32="肖申克的救赎"
format=File.extname("#{DOC_SRC}/启动服务.txt").split(".")[1]
size=File.size?("#{DOC_SRC}/启动服务.txt")/1000.0
FileUtils.cp("#{DOC_SRC}/启动服务.#{format}", "#{SAVE_ROOT_PATH}/#{name}/#{name3}/#{name32}.#{format}")
Document.create(:name=>name32,:parent_id=>doc3.id,:file_path=>"#{VIEW_ROOT_PATH}/#{name}/#{name3}/#{name32}.#{format}",:file_type=>format,:file_size=>size)

name33="珍珠港"
format=File.extname("#{DOC_SRC}/课程设计.pdf").split(".")[1]
size=File.size?("#{DOC_SRC}/课程设计.pdf")/1000.0
FileUtils.cp("#{DOC_SRC}/课程设计.#{format}", "#{SAVE_ROOT_PATH}/#{name}/#{name3}/#{name33}.#{format}")
Document.create(:name=>name33,:parent_id=>doc3.id,:file_path=>"#{VIEW_ROOT_PATH}/#{name}/#{name3}/#{name33}.#{format}",:file_type=>format,:file_size=>size)


name4="学习资料"
FileUtils.mkdir_p("#{SAVE_ROOT_PATH}/#{name}/#{name4}")
doc4=Document.create(:name=>name4,:parent_id=>root.id,:file_path=>"#{VIEW_ROOT_PATH}/#{name}/#{name4}")

