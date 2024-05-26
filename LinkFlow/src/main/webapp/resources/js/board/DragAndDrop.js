			const dropArea = document.querySelector('.drop-area');
      const dropMessage = document.querySelector('.drop-message');
      const originalDropMessage = dropMessage.textContent;
      const totalFileSizeElement = document.getElementById('totalFileSize');
      const fileInput = document.querySelector("#file-upload");
      const dataTransfer = new DataTransfer();
      let totalFileSize = 0;

			// 드롭 영역에서 발생하는 이벤트 핸들러 등록
      dropArea.addEventListener('dragover', (event) => {
          event.preventDefault(); // 기본 동작 방지
          dropArea.classList.add('drag-over'); // 드래그 오버 시 스타일 변경 (옵션)
      });
      dropArea.addEventListener('dragleave', () => {
          dropArea.classList.remove('drag-over'); // 드래그가 영역을 벗어날 때 스타일 복원 (옵션)
      });
      dropArea.addEventListener('drop', handleFileDrop);

      // 파일 첨부 input에 change 이벤트 핸들러 등록
      document.querySelector('#file-upload').addEventListener('change', function(evt){
      		
      	  const files = event.target.files;
      	  handleFiles(files);
          uploadFiles(files);
      });
      
      $("#enrollForm-submit").click(function(){
				const data = editor.getData();

				if(data.trim().length != 0){
					fileInput.files = dataTransfer.files;	
				}else{
					alert("내용은 반드시 작성해야 합니다");
					return false;
				}
      })


			// 드롭 영역에서 발생하는 이벤트를 처리하는 함수
      function handleFileDrop(event) {
          event.preventDefault(); // 기본 동작 방지

          const files = event.dataTransfer.files;

          if (files.length > 0) {
              // 파일을 input 요소에 넣기
              handleFiles(files);
              // 파일 업로드 및 UI 업데이트 함수 호출
              uploadFiles(files);
          }
      }

			// 파일을 input 요소에 넣는 함수
      function handleFiles(files) {
  
	      for (const file of files) {
	          dataTransfer.items.add(file);
	      }
      }

			// 파일 업로드 함수 정의 (예시)
      function uploadFiles(files) {
          dropMessage.style.display = 'none';
          const fileInfo = document.querySelector('.fileFooter');
          const ulElement = document.createElement('ul'); // 리스트 생성

          for (const file of files) {
              const liElement = document.createElement('li'); // 리스트 아이템 생성

              const fileItemName = document.createElement('span'); // 파일 이름 표시용 span 요소 생성
              const fileItemSize = document.createElement('span'); // 파일 크기 표시용 span 요소 생성

              const deleteButton = document.createElement('button');
              deleteButton.classList.add("fileDelete");
              const deleteIcon = document.createElement('i');
              deleteIcon.classList.add("fa-solid", "fa-xmark", "fileDelete");

              fileItemName.textContent = file.name; // 파일 이름 설정
              fileItemSize.textContent = formatFileSize(file.size); // 파일 크기 설정
              fileItemSize.classList.add('fileSizeValue');

              liElement.appendChild(fileItemName); // 파일 이름을 리스트 아이템에 추가
              liElement.appendChild(fileItemSize); // 파일 크기를 리스트 아이템에 추가
              liElement.appendChild(deleteIcon);

              ulElement.appendChild(liElement); // 리스트 아이템을 리스트에 추가

              totalFileSize += file.size;
          }

          fileInfo.appendChild(ulElement); // 리스트를 파일 정보에 추가

          showNoticeMsg();
      }

			// deleteIcon 클릭 이벤트 핸들러 등록
      document.addEventListener('click', function (event) {
          if (event.target.classList.contains('fileDelete')) {
              const deleteButton = event.target;
              const liElement = deleteButton.parentElement;
              const ulElement = liElement.parentElement;
              const fileSizeText = liElement.querySelector('.fileSizeValue').textContent; // 삭제할 파일의 크기 가져오기
              const sizeValue = parseFloat(fileSizeText.split(' ')[0]); // 숫자 부분만 추출
              const unit = fileSizeText.split(' ')[1]; // 단위 부분 추출
              const sizeInBytes = convertToBytes(sizeValue, unit); // 파일 크기를 바이트 단위로 변환

              deleteFile(liElement, ulElement, sizeInBytes);
          }
      });


			// 파일 삭제 함수 정의
      function deleteFile(liElement, ulElement, sizeInBytes) {
          const fileName = liElement.querySelector('span').textContent; 
          
          ulElement.removeChild(liElement);
          totalFileSize -= sizeInBytes;
          if (totalFileSize < 0) totalFileSize = 0;

          showNoticeMsg();
          
          const files = dataTransfer.files;
			    for (let i = 0; i < files.length; i++) {
			        if (files[i].name === fileName) {
			            dataTransfer.items.remove(i);
			            break; // 파일을 찾으면 더 이상 반복할 필요 없음
			        }
			    }
      }

		// 파일 크기를 포맷팅하는 함수 (예시)
      function formatFileSize(size) {
          if (size === 0) return '0 Bytes';
          const units = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
          const digitGroups = Math.floor(Math.log10(size) / Math.log10(1024));
          return `${(size / Math.pow(1024, digitGroups)).toFixed(2)} ${units[digitGroups]}`;
      }

			function updateTotalFileSize() {
          if (totalFileSizeElement) {
              totalFileSizeElement.textContent = `${formatFileSize(totalFileSize)} / 200MB`;
          }
      }

      function showNoticeMsg() {
          const fileCnt = document.querySelectorAll(".fileFooter ul li").length;
          if (fileCnt > 0) {
              dropMessage.style.display = 'none';
          } else {
              dropMessage.style.display = 'block';
              dropMessage.textContent = originalDropMessage;
              totalFileSize = 0;
          }
          updateTotalFileSize();
      }

			function convertToBytes(value, unit) {
          const units = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
          const index = units.indexOf(unit);
          return value * Math.pow(1024, index);
      }
      
      function tempSave() {
                    		
	      const contentData = editor.getData();
	
				fileInput.files = dataTransfer.files;	
				
				const pathname = "/" + window.location.pathname.split("/")[1] + "/";
				const origin = window.location.origin;
				
				const contextPath = origin + pathname;
				
				let formData = new FormData();
        formData.append("boardCategory", $("#select").val());
        formData.append("boardTitle", $("#title").val());
        formData.append("boardContent", contentData);
        formData.append("noticeYN", $("#noticeCheckbox").val());
        for(let i=0; i<fileInput.files.length; i++){
        	formData.append("uploadFiles", fileInput.files[i]);
        } 

				if(contentData.trim().length != 0){
	  			$.ajax({
	  				url: contextPath + "/board/insertTempSave.do",
	  				type:"post",
	  				enctype: 'multipart/form-data',
	  				processData: false,
            contentType: false,
	  				data: formData,
	  				traditinal:true,
	  				success:function(result){
	  					if(result > 0) {
	  						console.log(result);
	  						alert("임시저장 성공했습니다.");
	  						window.location.href = contextPath + "/board/tempSaveDetail.page?&no=" + result;
	  					}else {
	  						alert("임시저장 실패했습니다.");
	  					}
	  				},error:function(){
	  					console.log("댓글 작성용 ajax 통신 실패");
	  				}
	  			})
	  		}else {
	  			alert("내용은 반드시 작성해야 합니다");
					return false;
	  		}
	  	}
	  	
	  	function tempUpdate() {
                    		
	      const contentData = editor.getData();
	
				fileInput.files = dataTransfer.files;	
				
				const pathname = "/" + window.location.pathname.split("/")[1] + "/";
				const origin = window.location.origin;
				
				const contextPath = origin + pathname;
				
				let formData = new FormData();
        formData.append("boardNo", $("#boardNo").val());
        formData.append("boardCategory", $("#select").val());
        formData.append("boardTitle", $("#title").val());
        formData.append("boardContent", contentData);
        formData.append("noticeYN", $("#noticeCheckbox").val());
        $("input[name='delFileNo']").each(function() {
           formData.append("delFileNo", $(this).val());
        });
        for(let i=0; i<fileInput.files.length; i++){
        	formData.append("uploadFiles", fileInput.files[i]);
        } 

				if(contentData.trim().length != 0){
	  			$.ajax({
	  				url: contextPath + "/board/tempSaveUpdate.do",
	  				type:"post",
	  				enctype: 'multipart/form-data',
	  				processData: false,
            contentType: false,
	  				data: formData,
	  				traditinal:true,
	  				success:function(result){
	  					if(result == "SUCCESS") {
    						alert("임시저장 성공했습니다.");
    						location.reload();
    					}else if(result == "FAIL") {
    						alert("임시저장 실패했습니다.");
    					}
	  				},error:function(){
	  					console.log("댓글 작성용 ajax 통신 실패");
	  				}
	  			})
	  		}else {
	  			alert("내용은 반드시 작성해야 합니다");
					return false;
	  		}
	  	}
	  	
	  	function mailTempSave() {
                    		
	      const contentData = editor.getData();
	
				fileInput.files = dataTransfer.files;	
				
				const pathname = "/" + window.location.pathname.split("/")[1] + "/";
				const origin = window.location.origin;
				
				const contextPath = origin + pathname;
				
				let formData = new FormData();
        formData.append("receiveUser", $("#sendUser").val());
        formData.append("mailTitle", $("#title").val());
        formData.append("mailContent", contentData);
        
        for(let i=0; i<fileInput.files.length; i++){
        	formData.append("uploadFiles", fileInput.files[i]);
        } 

				if(contentData.trim().length != 0){
	  			$.ajax({
	  				url: contextPath + "/mail/insertTempSave.do",
	  				type:"post",
	  				enctype: 'multipart/form-data',
	  				processData: false,
            contentType: false,
	  				data: formData,
	  				traditinal:true,
	  				success:function(result){
	  					if(result > 0) {
	  						alert("임시저장 성공했습니다.");
	  						window.location.href = contextPath + "/mail/tempSaveDetail.page?&no=" + result;
	  					}else {
	  						alert("임시저장 실패했습니다.");
	  					}
	  				},error:function(){
	  					console.log("댓글 작성용 ajax 통신 실패");
	  				}
	  			})
	  		}else {
	  			alert("내용은 반드시 작성해야 합니다");
					return false;
	  		}
	  	}
	  	
	  	function mailTempUpdate() {
                    		
	      const contentData = editor.getData();
	
				fileInput.files = dataTransfer.files;	
				
				const pathname = "/" + window.location.pathname.split("/")[1] + "/";
				const origin = window.location.origin;
				
				const contextPath = origin + pathname;
				
				let formData = new FormData();
        formData.append("mailNo", $("#mailNo").val());
        formData.append("mailTitle", $("#title").val());
        formData.append("mailContent", contentData);
        $("input[name='delFileNo']").each(function() {
           formData.append("delFileNo", $(this).val());
        });
        for(let i=0; i<fileInput.files.length; i++){
        	formData.append("uploadFiles", fileInput.files[i]);
        } 

				if(contentData.trim().length != 0){
	  			$.ajax({
	  				url: contextPath + "/mail/tempSaveUpdate.do",
	  				type:"post",
	  				enctype: 'multipart/form-data',
	  				processData: false,
            contentType: false,
	  				data: formData,
	  				traditinal:true,
	  				success:function(result){
	  					if(result == "SUCCESS") {
    						alert("임시저장 성공했습니다.");
    						location.reload();
    					}else if(result == "FAIL") {
    						alert("임시저장 실패했습니다.");
    					}
	  				},error:function(){
	  					console.log("댓글 작성용 ajax 통신 실패");
	  				}
	  			})
	  		}else {
	  			alert("내용은 반드시 작성해야 합니다");
					return false;
	  		}
	  	}