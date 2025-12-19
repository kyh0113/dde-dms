function treeListCall(paramObj, url, id, nodeID){ //jstree를 위한 데이터를 ajax로 구해와서 리턴해주는 함수
	$.ajax({
		type: 'POST',
		url: url,
		data: paramObj,
		dataType: 'json',
		async: false,
		success: function(data){
			$(id).jstree({ 
				'core' : {
					"themes" : { "stripes" : false },
				    'data' : data.treeList
				},
				'types' : {
					
					"Y" : {"icon" : true},
					"N" : {"icon" : "fas fa-file"}
				},
				"plugins" : [
					 "search",
					 "types"/*,"wholerow"*/
				]
			});
			
			$(id).on('loaded.jstree', function() {//jstree가 로드될때 특정노드 오픈 and 선택
				expandNode(id,nodeID); 
			});
		},
        beforeSend: function(){
        	//target.addClass("notactive");
        },
        complete: function(){}
	});
}
function treeRecall(paramObj, url, id,nodeID){
	$.ajax({
		type: 'POST',
		url: url,
		data: paramObj,
		dataType: 'json',
		async: false,
		success: function(data){
			$(id).jstree(true).settings.core.data = data.treeList;
			$(id).jstree(true).refresh();
			//2019-08-20 SMH 삭제.
//			setTimeout(function() {expandNode(id,nodeID);},1000);
		},
        beforeSend: function(){
        	//target.addClass("notactive");
        },
        complete: function(){}
	});
}