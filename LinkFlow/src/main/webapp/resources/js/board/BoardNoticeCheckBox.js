function updateCheckboxValue() {
    var checkbox = document.getElementById("noticeCheckbox");
    var value = checkbox.checked ? "Y" : "N";
   	checkbox.value = value;
}

window.onload = function() {
    updateCheckboxValue(); // 초기화
};
  
document.getElementById("noticeCheckbox").addEventListener("change", updateCheckboxValue);