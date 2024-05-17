const dropArea = document.querySelector('.drop-area');
const dropMessage = document.querySelector('.drop-message');
const originalDropMessage = dropMessage.textContent;
const totalFileSizeElement = document.getElementById('totalFileSize');
let totalFileSize = 0;

// 드롭 영역에서 발생하는 이벤트를 처리하는 함수
function handleFileDrop(event) {
    event.preventDefault(); // 기본 동작 방지

    // 드롭된 파일 가져오기
    const files = event.dataTransfer.files;

    // 파일 업로드 및 UI 업데이트 함수 호출
    if (files.length > 0) {
        uploadFiles(files);
    }
}

// 파일 업로드 함수 정의 (예시)
function uploadFiles(files) {
    dropMessage.style.display = 'none';
    // 파일 업로드 처리 로직 작성
    const fileInfo = document.querySelector('.fileFooter');
    const ulElement = fileInfo.querySelector('ul') || document.createElement('ul'); // 리스트 생성 또는 기존 리스트 사용

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

        totalFileSize += file.size; // 전체 파일 크기 업데이트
    }

    if (!fileInfo.contains(ulElement)) {
        fileInfo.appendChild(ulElement); // 리스트를 파일 정보에 추가
    }

    updateTotalFileSize();
    showNoticeMsg();
}

function showNoticeMsg() {
    const fileCnt = document.querySelectorAll(".fileFooter ul li").length;
    if (fileCnt > 0) {
        dropMessage.style.display = 'none';
    } else {
        dropMessage.style.display = 'block';
        dropMessage.textContent = originalDropMessage;
    }
}

// 파일 크기를 포맷팅하는 함수 (예시)
function formatFileSize(size) {
    if (size === 0) return '0 Bytes';
    const units = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
    const digitGroups = Math.floor(Math.log10(size) / Math.log10(1024));
    return `${(size / Math.pow(1024, digitGroups)).toFixed(2)} ${units[digitGroups]}`;
}

// 전체 파일 크기를 업데이트하는 함수
function updateTotalFileSize() {
    totalFileSizeElement.textContent = `${formatFileSize(totalFileSize)} / 200MB`;
}

// 드롭 영역에서 발생하는 이벤트 핸들러 등록
dropArea.addEventListener('dragover', (event) => {
    event.preventDefault(); // 기본 동작 방지
});
dropArea.addEventListener('drop', handleFileDrop);

// 파일 첨부 input에 change 이벤트 핸들러 등록
const fileInput = document.querySelector('#file-upload');
fileInput.addEventListener('change', handleFileSelect);

// 파일 첨부 input에서 발생하는 change 이벤트를 처리하는 함수
function handleFileSelect(event) {
    const files = event.target.files;
    uploadFiles(files);
}

// deleteIcon 클릭 이벤트 핸들러 등록
document.addEventListener('click', function(event) {
    if (event.target.classList.contains('fileDelete')) {
        const deleteButton = event.target;
        const liElement = deleteButton.parentElement;
        const ulElement = liElement.parentElement;
        const fileSize = liElement.querySelector('.fileSizeValue').textContent; // 삭제할 파일의 크기 가져오기
        const sizeValue = parseFloat(fileSize.split(' ')[0]); // 숫자 부분만 추출
        const unit = fileSize.split(' ')[1]; // 단위 부분 추출
        const sizeInBytes = convertToBytes(sizeValue, unit); // 파일 크기를 바이트 단위로 변환

        deleteFile(liElement, ulElement, sizeInBytes);
    }
});

// 단위를 바이트로 변환하는 함수
function convertToBytes(value, unit) {
    const units = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
    const index = units.indexOf(unit);
    return value * Math.pow(1024, index);
}

// 파일 삭제 함수 정의
function deleteFile(liElement, ulElement, sizeInBytes) {
    ulElement.removeChild(liElement);
    totalFileSize -= sizeInBytes; // 전체 파일 크기 업데이트
    updateTotalFileSize();
    showNoticeMsg();
}