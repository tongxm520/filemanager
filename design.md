>documents
name
file_type
file_size
parent_id
file_path
absolute_path

rails runner script/load_docs.rb

rails generate rspec:install

rails g model Document name:string file_type:string file_size:decimal parent_id:integer file_path:string absolute_path:string

string=>varchar(255)
限制文件夹的层数和name的长度

9999999.999K

FileUtils.methods.grep /cp/

rails4 json.jbuilder

mysqld_safe --defaults-file=/home/simon/Desktop/Depot/config/my.cnf --user=mysql &


var authenticity_token = '#{form_authenticity_token}';
$('#div_#{dom_id(data_source)} .query-year').change(function(e) {
  $.ajax({
    type: "GET",
    dataType: "script",
    url: "#{company_client_data_items_path(client,:data_source_id=>data_source.id)}" + "&query_year=" + encodeURIComponent($(e.target).val()) + '&authenticity_token=' + encodeURIComponent(authenticity_token),
    });
});


sudo find / -name "*.rb"|xargs grep 'last_comment'


cd /home/simon/exercise
find ./ -name "*.html.erb"|xargs grep "ajax"





