var dialog, form,input_name=$("#name"),tips = $(".validateTips");
$body = $("body");
var result_status,_folder_action;

var updateTips=function(t) {
  tips
    .text(t)
    .addClass("ui-state-highlight");
  setTimeout(function() {
    tips.removeClass("ui-state-highlight", 1500);
  }, 500 );
}

var setting = {
  view: {
	  showLine: false,
    dblClickExpand: false
	},
	data: {
		simpleData: {
			enable: true
		}
	},
  callback: {
    onRightClick: OnRightClick
  }
};

var current_doc;
var previous_doc;
function OnRightClick(event, treeId, treeNode) {
  //alert(treeNode.id);alert(treeNode.tId);alert(treeNode.pId);
  //$('.curSelectedNode').removeClass("curSelectedNode");
  
	if (!treeNode && event.target.tagName.toLowerCase() != "button" && $(event.target).parents("a").length == 0) {
    current_doc=1;
    if(current_doc!=previous_doc){
      show_doc(1);
    }      
		zTree.cancelSelectedNode();
    //$("#treeDemo_1_a").addClass("curSelectedNode");
    zTree.selectNode(zTree.getNodeByTId("treeDemo_1"));
		showRMenu("root", event.clientX, event.clientY);
	} else if (treeNode && !treeNode.noR) {
		zTree.selectNode(treeNode);
    if(treeNode.tId=="treeDemo_1"){
      current_doc=1;
      if(current_doc!=previous_doc){
        show_doc(1);
      }
      showRMenu("root", event.clientX, event.clientY);
    }else {
      current_doc=treeNode.id;
      if(current_doc!=previous_doc){
        show_doc(treeNode.id);
      }
      showRMenu("node", event.clientX, event.clientY);
    }
	} 
}

function showRMenu(type, x, y) {
	$("#rMenu ul").show();
	if (type=="root") {
		$("#m_del").hide();
    $("#m_copy").hide();
    $("#m_cut").hide();
    $("#m_rename").hide();
	} else {
		$("#m_del").show();
    $("#m_copy").show();
    $("#m_cut").show();
    $("#m_rename").show();
	}
	rMenu.css({"top":y+"px", "left":x+"px", "visibility":"visible"});

	$("body").bind("mousedown", onBodyMouseDown);
}

function hideRMenu() {
	if(rMenu) rMenu.css({"visibility": "hidden"});
	$("body").unbind("mousedown", onBodyMouseDown);
}

function onBodyMouseDown(event){
	if(!(event.target.id == "rMenu" || $(event.target).parents("#rMenu").length>0)) {
		rMenu.css({"visibility" : "hidden"});
	}
}

function addTreeNode() {
	hideRMenu();
  dialog.dialog("open");
  $("#validate-tips").html("");
  $("#dialog-form").dialog("option","title","Create folder");
  _folder_action="addNewFolder";
}

var current_node_id;
function renameFile(){
  hideRMenu();
  dialog.dialog("open");
  $("#validate-tips").html("");
  $("#dialog-form").dialog("option","title","Rename folder");
  var nodes = zTree.getSelectedNodes();
  input_name.val(nodes[0].name);
  current_node_id=nodes[0].id;
  _folder_action="renameFolder";
}

function removeTreeNode() {
	hideRMenu();
	var nodes = zTree.getSelectedNodes();
	if (nodes && nodes.length>0) {
		if (nodes[0].children && nodes[0].children.length > 0) {
			var msg = "要删除的节点是父节点，如果删除将连同子节点一起删掉。\n\n请确认！";
			if(confirm(msg)==true){
				removeFolder(nodes[0]);
			}
		} else {
			removeFolder(nodes[0]);
		}
	}
}

var removeFolder=function(node){
  var data = {"authenticity_token": authenticity_token,"id":node.id};

	$.ajax({
		type: 'post',
		url: '/remove_folder',
		data: JSON.stringify(data),
	  contentType: "application/json;charset=utf-8",
		dataType: 'script',
		success: function(result,status){
	  },
	  error: function(error) {
	  },
	  beforeSend: function() {
      $body.addClass("loading"); 
	  }
	}).complete(function() {
    $body.removeClass("loading");
    $().toastmessage('showSuccessToast', 'remove folder successfully'); 
	});
}

var createNewFolder=function(folder_name,tree_node){
  var pid,_tree_node;
  if(tree_node) {
		pid=tree_node.id;
	} else {
    pid=1;
	}

  var data = {"authenticity_token": authenticity_token,"folder_name":folder_name,"pid":pid};

	$.ajax({
		type: 'post',
		url: '/create_folder',
		data: JSON.stringify(data),
	  contentType: "application/json;charset=utf-8",
		dataType: 'json',
		success: function(result,status){
      if(status==="success"){
        if(result.data==="ok"){
          result_status=result.data;
          if(tree_node) {
						_tree_node=tree_node;
					} else {
					  _tree_node=zTree.getNodeByTId("treeDemo_1");
					}
			    var new_node = {id:result.id,name:folder_name,pId: pid,isParent:true,icon: "/assets/zTreeStyle/img/diy/Close.png",iconOpen: "/assets/zTreeStyle/img/diy/Open.png",iconClose: "/assets/zTreeStyle/img/diy/Close.png",url:folder_name,target:"_self"};
					zTree.addNodes(_tree_node, new_node);
          appendToList(result.doc);
          appendToGrid(result.doc);
          dialog.dialog("close");
        }else if(result.data==="error"){
          result_status=result.data;
          input_name.addClass("ui-state-error");
          updateTips(result.msg);
        }
      }
	  },
	  error: function(error) {
	  },
	  beforeSend: function() {
      $body.addClass("loading");
	  }
	}).complete(function() {
    $body.removeClass("loading");
    if(result_status==="ok"){
      $().toastmessage('showSuccessToast', 'create folder successfully');
    } 
	});
}

function renameDir(_id,_name){
  var data = {"authenticity_token": authenticity_token,"id":_id,"name":_name};

	$.ajax({
		type: 'post',
		url: '/rename_folder',
		data: JSON.stringify(data),
	  contentType: "application/json;charset=utf-8",
		dataType: 'json',
		success: function(result,status){
      if(status==="success"){
        if(result.data==="ok"){
          dialog.dialog("close");
          result_status=result.data;
          var nodes = zTree.getSelectedNodes();
          if(nodes[0]!=undefined){
            //tId:treeDemo_11
            var tId=nodes[0].tId; 
            nodes[0].name=result.newname;           
            $("#"+tId+"_span").html(result.newname);
            $("#"+tId+"_a").prop("href",result.newname);
            $("#"+tId+"_a").prop("title",result.newname);
            $("#path-box ol li:last").html(result.newname);
            history.pushState({}, null,result.newname);
          }
        }else if(result.data==="error"){
          result_status=result.data;
          input_name.addClass("ui-state-error");
          updateTips(result.msg);
        }
      }
	  },
	  error: function(error) {
	  },
	  beforeSend: function() {
      $body.addClass("loading"); 
	  }
	}).complete(function() {
    $body.removeClass("loading");
    if(result_status==="ok"){
      $().toastmessage('showSuccessToast', 'rename folder successfully');
    } 
	});
}

var appendToList=function(doc){
  var size="";
  if(doc.size!=""){
    size=doc.size+"KB";
  }
  $("#file-table tbody").append("<tr>" +
  "<td><div class='webix_hcell'>"+doc.name+ "</div></td>" +
  "<td><div class='webix_hcell'>"+doc.date+ "</div></td>" +
  "<td><div class='webix_hcell'>"+doc.type+ "</div></td>" +
  "<td><div class='webix_hcell'>"+size+ "</div></td>" +
"</tr>" );
}

var appendToGrid=function(doc){
  $("ul#file-grid").append("<li><div><div class='clip'>"+
    "<img width='64' class='grid-icon ico_folder'></div> <p>"+doc.name+
    "</p></div></li>");
}

function show_doc(id){
  var data = {"authenticity_token": authenticity_token};

	$.ajax({
		type: 'post',
		url: '/show_doc/'+id,
		data: JSON.stringify(data),
	  contentType: "application/json;charset=utf-8",
		dataType: 'script',
		success: function(result,status){
	  },
	  error: function(error) {
	  },
	  beforeSend: function() {
	  }
	}).complete(function() {
	});
  previous_doc=id;
}

var zNodes=JSON.parse(docs_json);
//alert(zNodes);
/*var zNodes =[
	{ id:1, pId:0, name:"hello - 展开", open:true},
	{ id:11, pId:1, name:"父节点11 - 折叠"},
	{ id:111, pId:11, name:"叶子节点111"},
	{ id:112, pId:11, name:"叶子节点112"},
	{ id:113, pId:11, name:"叶子节点113"},
	{ id:114, pId:11, name:"叶子节点114"},
	{ id:12, pId:1, name:"父节点12 - 折叠"},
	{ id:121, pId:12, name:"叶子节点121"},
	{ id:122, pId:12, name:"叶子节点122"},
	{ id:123, pId:12, name:"叶子节点123"},
	{ id:124, pId:12, name:"叶子节点124"},
	{ id:13, pId:1, name:"父节点13 - 没有子节点", isParent:true},
	{ id:2, pId:0, name:"父节点2 - 折叠"},
	{ id:21, pId:2, name:"父节点21 - 展开", open:true},
	{ id:211, pId:21, name:"叶子节点211"},
	{ id:212, pId:21, name:"叶子节点212"},
	{ id:213, pId:21, name:"叶子节点213"},
	{ id:214, pId:21, name:"叶子节点214"},
	{ id:22, pId:2, name:"父节点22 - 折叠"},
	{ id:221, pId:22, name:"叶子节点221"},
	{ id:222, pId:22, name:"叶子节点222"},
	{ id:223, pId:22, name:"叶子节点223"},
	{ id:224, pId:22, name:"叶子节点224"},
	{ id:23, pId:2, name:"父节点23 - 折叠"},
	{ id:231, pId:23, name:"叶子节点231"},
	{ id:232, pId:23, name:"叶子节点232"},
	{ id:233, pId:23, name:"叶子节点233"},
	{ id:234, pId:23, name:"叶子节点234"},
	{ id:3, pId:0, name:"父节点3 - 没有子节点", isParent:false,icon:"/assets/zTreeStyle/img/diy/folder_close.png"}
];*/

var zTree, rMenu;
$(document).ready(function(){
	$.fn.zTree.init($("#treeDemo"), setting, zNodes);
  zTree = $.fn.zTree.getZTreeObj("treeDemo");
  rMenu = $("#rMenu");

  //$('.curSelectedNode').removeClass("curSelectedNode");
  var curr_doc=$('a[data-info='+doc_current_id+']');
  var tId=curr_doc.prop("id").split("_")[1];
  zTree.selectNode(zTree.getNodeByTId("treeDemo_"+tId));

	$("#show-grid").click(function(event){
	  event.preventDefault();
	  if(!$("#grid-view").hasClass("active")){
	    $(this).addClass("view-selected");
	    $("#show-list").removeClass("view-selected");
	    $("#grid-view").addClass("active").addClass("in");
	    $("#list-view").removeClass("active").removeClass("in");
	  }
	});

	$("#show-list").click(function(event){
	  event.preventDefault();
	  if(!$("#list-view").hasClass("active")){
	    $(this).addClass("view-selected");
	    $("#show-grid").removeClass("view-selected");
	    $("#list-view").addClass("active").addClass("in");
	    $("#grid-view").removeClass("active").removeClass("in");
	  }
	});

  var lis=$("#rMenu ul li");
  for(var i=0;i<lis.length;i++){
    $(lis[i]).mouseover(function(){
      $(this).addClass("operate-menu-hover");
    });
    $(lis[i]).mouseout(function(){
      $(this).removeClass("operate-menu-hover");
    });
  }
});
	
/*
var txt = '{ "employees" : [' +  
'{ "firstName":"John" , "lastName":"Doe" },' +  
'{ "firstName":"Anna" , "lastName":"Smith" },' +  
'{ "firstName":"Peter" , "lastName":"Jones" } ]}';  

JSON数据转换为JavaScript对象
obj = JSON.parse(txt); 

JavaScript对象转换为JSON数据
var txt = JSON.stringify(obj); 
*/

jQuery(function($){
  var doc = $(document), dl = $("div.left"), dc = $("div.center");
  var sum = dl.width() + dc.width() + $("div.handler").mousedown(function (e) {
		var me = $(this);
		var deltaX = e.clientX - (parseFloat(me.css("left")) || parseFloat(me.prop("clientLeft")));
		doc.mousemove(function (e){
			var lt = e.clientX - deltaX; 
			lt = lt < 261 ? 261 : lt;
			lt = lt > sum - me.width()-1000 ? sum - me.width()-1000 : lt;
			me.css("left",lt + "px");
			dl.width(lt);
      var left=lt+me.width();
      dc.css("left",left + "px");
			dc.width(sum-lt-me.width()+10);
		});
  }).width();

	doc.mouseup (function(){
		doc.unbind("mousemove");
	});
	doc[0].ondragstart = doc[0].onselectstart = function(){return false;};
});

/*
contentType is the type of data you're sending, so "application/json;charset=utf-8" is a common one, as is "application/x-www-form-urlencoded;charset=UTF-8", which is the default.

dataType is what you're expecting back from the server:json,xml,html,text,script(js) etc. jQuery will use this to figure out how to populate the success function's parameter.

var data = {"name":"John Doe"}
$.ajax({
    dataType : "json",
    contentType: "application/json; charset=utf-8",
    data : JSON.stringify(data),
    success : function(result) {
      alert(result.success); // result is an object which is created from the returned JSON
    },
});
*/


/*create new folder dialog*/
$(function() {
  function folderAction() {
    var valid=varify_name();
    if(valid) {
      if(_folder_action==="addNewFolder"){
        var nodes = zTree.getSelectedNodes(),
				treeNode = nodes[0];
		    var folder_name=input_name.val();
		    createNewFolder(folder_name,treeNode);
      }else if(_folder_action==="renameFolder"){
        renameDir(current_node_id,input_name.val())
      }
    }
    return valid;
  }

  function varify_name(){
    var valid = true;
    input_name.removeClass("ui-state-error");

    valid = valid && checkLength(input_name, "name", 3, 16);
    valid = valid && checkRegexp(input_name, /^[\-a-z0-9_\u4e00-\u9fa5]+$/i, "Name may consist of a-z, 0-9, underscores and chinese character.");
    return valid;
    //******/^[a-z]([0-9a-z_\s])+$/i => a-z, 0-9, underscores, spaces
  }

  function checkLength( o, n, min, max ) {
    if ( o.val().length > max || o.val().length < min ) {
      o.addClass( "ui-state-error" );
      updateTips( "Length of " + n + " must be between " +
        min + " and " + max + "." );
      return false;
    } else {
      return true;
    }
  }

  function checkRegexp( o, regexp, n ) {
    if(!(regexp.test( o.val()))) {
      o.addClass("ui-state-error");
      updateTips(n);
      return false;
    } else {
      return true;
    }
  }

	dialog = $("#dialog-form").dialog({
		autoOpen: false,
		height: 270,
		width: 300,
		modal: true,
		buttons: {
		  "Submit": folderAction,
		  Cancel: function() {
		    dialog.dialog("close");
		  }
		},
		close: function() {
		  form[0].reset();
		  input_name.removeClass("ui-state-error");
		}
	});

  //Allow form submission with keyboard without duplicating the dialog button
	form = dialog.find("form").on("submit", function(event) {
		event.preventDefault();
		folderAction();
	});
});

/*create new folder dialog*/

/*
when jQuery version < 1.6
alert( $('#my_div').attr("title") );

Get Div Title when jQuery version > 1.6
alert( $('#my_div').prop("title") );
*/
