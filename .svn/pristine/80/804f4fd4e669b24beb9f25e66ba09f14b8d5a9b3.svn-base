(function($){
	$.fn.fileDropDown = function(options){
		//attach_no
		var defaultOptions = {
				attach_no : "",
				areaOpen : false,
				areaText : ""
		};
		var mergedOptions = $.extend({},defaultOptions, options || {});
		var attach_no = mergedOptions.attach_no;
		//영역에 드롭다운 가능 여부
		var areaOpen = mergedOptions.areaOpen;
		//영역 드롭다운 불가 이유 텍스트
		var areaOpenText = mergedOptions.areaOpenText;
		
		
		//--------------------------------------//
		var fileInfo = new Object();

		// 등록 가능한 파일 사이즈 MB
		var uploadSize = 200;
		// 등록 가능한 총 파일 사이즈 MB
		var maxUploadSize = 500;
		
		//20190805_khj file_upload possible size setting
		if(mergedOptions.fileSizeLimits != null || mergedOptions.fileSizeLimits != undefined || typeof mergedOptions.fileSizeLimits != "undefined"){
			uploadSize = mergedOptions.fileSizeLimits;
		}
		if(mergedOptions.totalfileSizeLimits != null || mergedOptions.totalfileSizeLimits != undefined || typeof mergedOptions.totalfileSizeLimits != "undefined"){
			maxUploadSize = mergedOptions.totalfileSizeLimits;
		}
		
		//DOM ID
		var dropZoneId = this.attr("id");
		//$
		var $this = this;
		
		var setDropZone = function(){
			var files = {"totalFileSize" : 0, "fileIndex": 0, "fileList" : new Array(), "fileSizeList" : new Array()};
		    fileInfo[dropZoneId] = files;
			//Drag기능 
			$this.on('dragenter',function(e){
		        e.stopPropagation();
		        e.preventDefault();
		        // 드롭다운 영역 css
		        $this.css('background-color','#E3F2FC !important');
		    });
			$this.on('dragleave',function(e){
		        e.stopPropagation();
		        e.preventDefault();
		        // 드롭다운 영역 css
		        $this.css('background-color','#FFFFFF !important');
		    });
			$this.on('dragover',function(e){
		        e.stopPropagation();
		        e.preventDefault();
		        // 드롭다운 영역 css
		        $this.css('background-color','#E3F2FC !important');
		    });
			$this.on('drop',function(e){
		        e.preventDefault();
		        // 드롭다운 영역 css
		        $this.css('background-color','#FFFFFF !important');
		        if(!areaOpen){
		        	swalWarning(areaOpenText);
		        	return false;
		        }
		        
		        var files = e.originalEvent.dataTransfer.files;
		        if(files != null){
		            if(files.length < 1){
		            	swalWarning("폴더 업로드는 불가 합니다.");
		                return;
		            }
		            //console.log("!!"+files);
		            selectFile(files);
		        }else{
		        	swalWarning("ERROR");
		        }
	        });
		}
		
		var area = function(tf){
			areaOpen = true;
		}
		
		var fileListLoad = function(options){
			
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			
			$.ajax({
				type: 'POST',
				url: options.url,
				data: options.param==null?{} : options.param,
				async : false,
				dataType: 'json',
				success: function(data){
					var files = {"totalFileSize" : 0, "fileIndex": 0, "fileList" : new Array(), "fileSizeList" : new Array()};
				    fileInfo[dropZoneId] = files;
					var fileList = data.files;
					$this.empty();
					//dropZone.append("<tr><td>파일추가시 첨부할 파일을 드래그 하십시오.</td></tr>");
					var html = "";
					for(var i=0; i<fileList.length; i++){
						var fileSize = parseFloat(fileList[i].file_size/(1024*1024)).toFixed(2);
						// 전체 파일 사이즈
		                fileInfo[dropZoneId]["totalFileSize"] += fileSize*1;

		                // 파일 배열에 넣기
		                fileInfo[dropZoneId]["fileList"][fileInfo[dropZoneId]["fileIndex"]] = null;

		                // 파일 사이즈 배열에 넣기
		                fileInfo[dropZoneId]["fileSizeList"][fileInfo[dropZoneId]["fileIndex"]] = fileSize*1;

		                // 파일 번호 증가
		                fileInfo[dropZoneId]["fileIndex"] ++;
						
						
					    html = "";
						html += "<tr id='"+dropZoneId+"_fileTr_" + i + "'>";
					    html += "    <td class='left' >";
					    html +=         fileList[i].src_file_name + "  <span class='blue'>" + fileSize + "MB </span>"  + "<a href='#' data-file-id='fileDelete' data-attach='"+fileList[i].attach_no+"' data-ser='"+fileList[i].ser_no+"' data-dir='"+fileList[i].file_dir+"' data-index='"+i+"' style='margin-left: 10px;' class='red float-right attachDeleteBtn'><i class='fas fa-times'></i></p></a>";
					    html += "<a href='#' data-file-id='fileDown' data-attach='"+fileList[i].attach_no+"' data-ser='"+fileList[i].ser_no+"' class='green float-right'><i class='fas fa-download'></i></p></a>";
					    html += "    </td>";
					    html += "</tr>";
					    $this.append(html);
					}
					//console.log("totalSize with Load: ", fileInfo[dropZoneId]["totalFileSize"]);
					
					//20190924_khj 파일선택란 초기화(브라우저별 처리)
					var agent = navigator.userAgent.toLowerCase();
					if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
					  // ie 일때 input[type=file] init.
					  if($("#attachFileUpload #multifileselect").length > 0){
						  $("#attachFileUpload #multifileselect").replaceWith( $("#attachFileUpload #multifileselect").clone(true) );
					  }	else{
						  $("#multifileselect").replaceWith( $("#multifileselect").clone(true) );
					  }
						
					}
					else {
					  // other browser 일때 input[type=file] init.
					  if($("#attachFileUpload #multifileselect").length > 0){
						  $("#attachFileUpload #multifileselect").val("");
					  }else{
						  $("#multifileselect").val("");
					  }
					  
					}
					
					
				},
				beforeSend : function(xhr) {
					// 2019-10-23 khj - for csrf
					xhr.setRequestHeader(header, token);
				},
		        error : function(jqXHR, textStatus, errorThrown){
		        	
		        	//console.log("ajax error");
		        }
			});
			
			$(document).off("click","[data-file-id='fileDown']").on("click","[data-file-id='fileDown']",function(e){
				e.preventDefault();
				e.stopPropagation();
				var attach_no = $(this).attr("data-attach");
		    	var ser_no = $(this).attr("data-ser");
		    	downloadFile(attach_no, ser_no);
		    });
			
			$(document).off("click","[data-file-id='fileDelete']").on("click","[data-file-id='fileDelete']",function(e){
				e.preventDefault();
				e.stopPropagation();
				//console.log("delete click event");
				var attach_no = $(this).attr("data-attach");
		    	var ser_no = $(this).attr("data-ser");
		    	var dir = $(this).attr("data-dir");
		    	var index = $(this).attr("data-index");
		    	deleteFile(attach_no, ser_no, dir, index);
		    });
		}
		
		var selectFile = function(fileObject){
			var files = null;
		    if(fileObject != null){
				// 파일 Drag 이용하여 등록시
				files = fileObject;
		    }else{
		        // 직접 파일 등록시
		        files = $('#multipaartFileList_' + fileIndex)[0].files;
		    }
		    //console.log(files);
		    // 다중파일 등록
		    if(files != null){
		        for(var i = 0; i < files.length; i++){
		            // 파일 이름
		            var fileName = files[i].name;
		            var fileNameArr = fileName.split("\.");
		            // 확장자
		            var ext = fileNameArr[fileNameArr.length - 1];
		            // 파일 사이즈(단위 :MB)
		            var fileSize = files[i].size / 1024 / 1024;
		            
		            if($.inArray(ext, ['exe', 'bat', 'sh', 'java', 'jsp', 'html', 'js', 'css', 'xml', 'php', 'php3', 'asp', 'cgi', 'inc', 'pl']) >= 0){
		                // 확장자 체크
		                swalWarning("등록 불가 확장자 입니다.");
		                break;
		            }else if(fileName.match(/'/g) != null){
		                // 파일명 특수문자 체크
		            	swalWarning("등록 불가 파일명입니다.(작은따옴표를 제거해주십시오)");
		                break;    
		            }else if(fileSize > uploadSize){
		                // 파일 사이즈 체크
		            	swalWarning("용량 초과\n(건당)업로드 가능 용량 : " + uploadSize + " MB");
		                break;
		            }else{
		                // 전체 파일 사이즈
		                fileInfo[dropZoneId]["totalFileSize"] += fileSize;

		                // 파일 배열에 넣기
		                fileInfo[dropZoneId]["fileList"][fileInfo[dropZoneId]["fileIndex"]] = files[i];

		                // 파일 사이즈 배열에 넣기
		                fileInfo[dropZoneId]["fileSizeList"][fileInfo[dropZoneId]["fileIndex"]] = fileSize;

		                // 업로드 파일 목록 생성
		                addFileList(fileInfo[dropZoneId]["fileIndex"], fileName, fileSize);

		                // 파일 번호 증가
		                fileInfo[dropZoneId]["fileIndex"] ++;

		            }
		        }
		    }else{
		    	swalWarning("ERROR");
		        }
		   //console.log("totalSize with newFile : ", fileInfo[dropZoneId]["totalFileSize"]);
		}
		
		var addFileList = function(fIndex, fileName, fileSize){
			var html = "";
		    html += "<tr id='"+dropZoneId+"_fileTr_" + fIndex + "'>";
		    html += "    <td class='left' >";
		    html +=         fileName + "  <span class='blue'>" + parseFloat(fileSize).toFixed(2) + "MB </span>"  + "<a href='#' data-file-id='fileDelete' data-attach='-1' data-ser='-1' data-dir='-1', data-index='"+fIndex+"' class='red float-right'><i class='fas fa-times red'></i></p></a>";
		    html += "    </td>";
		    html += "</tr>";
		 
		    $this.append(html);
		};
		
		var downloadFile = function(attach_no, ser_no){
			var form = document.createElement("form");
			var attach_no_element = document.createElement("input");
			attach_no_element.name = "attach_no";
			attach_no_element.value = attach_no;
			attach_no_element.type = "hidden";
			var ser_no_element = document.createElement("input");
			ser_no_element.name = "ser_no";
			ser_no_element.value = ser_no;
			ser_no_element.type = "hidden";
			
			form.method = "post";
			form.action = "/biz/ICMFileDownload";
			
			form.appendChild(attach_no_element);
			form.appendChild(ser_no_element);
			document.body.appendChild(form);
			
			form.submit();
			form.remove();
		}
		
		var deleteFile = function(attach_no, ser_no, file_dir, fIndex){
			console.log("deleteFile event");
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			
			if(attach_no != -1){
			  	  swal({
						  icon : "info",
						  text: "파일을 삭제 하시겠습니까?",
						  closeOnClickOutside : false,
						  closeOnEsc : false,
						  buttons: {
								confirm: {
								  text: "확인",
								  value: true,
								  visible: true,
								  className: "",
								  closeModal: true
								},
								cancel: {
								  text: "취소",
								  value: null,
								  visible: true,
								  className: "",
								  closeModal: true
								}
						  }
						})
						.then(function(result){
							  if(result){
								  $.ajax({
										type: 'POST',
										url: '/biz/ICMFileDelete',
										data: {attach_no:attach_no, ser_no : ser_no, file_dir:file_dir},
										dataType: 'json',
										success: function(data){
											if(data.result == -1){
												swalWarning("파일이 삭제 되지 않았습니다.  다시 시도해 주십시오.");
											}else{
												swalSuccess("파일이 삭제되었습니다.");
												fileListLoad({
													url : "/biz/ICMFileList",
													param : {attach_no : attach_no}
												});
											}
										},
										beforeSend : function(xhr) {
											// 2019-10-23 khj - for csrf
											xhr.setRequestHeader(header, token);
										},
								        error : function(jqXHR, textStatus, errorThrown){
								        	
								        	swalDanger("파일 삭제도중 에러가 발생했습니다. 다시 시도해 주십시오.");
								        	
								        }
									});	 	  
							  }
						});
			    }else{
			    	// 전체 파일 사이즈 수정
			        fileInfo[dropZoneId]["totalFileSize"] -= fileInfo[dropZoneId]["fileSizeList"][fIndex];
			        
			        // 파일 배열에서 삭제
			        delete fileInfo[dropZoneId]["fileList"][fIndex];
			        
			        // 파일 사이즈 배열 삭제
			        delete fileInfo[dropZoneId]["fileSizeList"][fIndex];
			        
			        // 업로드 파일 테이블 목록에서 삭제
			        $("#"+dropZoneId+"_fileTr_" + fIndex).remove();
			    }
		}
		
		var uploadFile = function(formId){
			// 등록할 파일 리스트
		    var uploadFileList = Object.keys(fileInfo[dropZoneId]["fileList"]);
		    var form = $("#"+formId)[0];
		    var formData = new FormData(form);
		    /* 다른 input 데이터 확인
		    for (var key of formData.keys()) {
	    	  console.log(key);
	    	}

	    	for (var value of formData.values()) {
	    	  console.log(value);
	    	}
	    	*/
		    // 파일이 있는지 체크
		    if(uploadFileList.length == 0){
		        return formData;
		    }
		    
		    // 용량을 500MB를 넘을 경우 업로드 불가
		    if(fileInfo[dropZoneId]["totalFileSize"] > maxUploadSize){
		    	swalWarning("용량 초과\n(최대)업로드 가능 용량 : " + maxUploadSize + " MB");
		        return false;
		    }
		        
		    // 등록할 파일 리스트를 formData로 데이터 입력
		    for(var i = 0; i < uploadFileList.length; i++){
		        formData.append('Filedata', fileInfo[dropZoneId]["fileList"][uploadFileList[i]]);
		    } 
		    return formData;
		}
		
		return {
			setDropZone : setDropZone,
			area : area,
			fileListLoad : fileListLoad,
			uploadFile : uploadFile,
			selectFile : selectFile
		}
	}
})(jQuery);