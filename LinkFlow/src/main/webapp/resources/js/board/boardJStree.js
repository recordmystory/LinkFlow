document.querySelector('.approvalIn').addEventListener('click', function() {
      var nameAreas = document.querySelectorAll('.NameArea');
      var existingApprovalCount = document.querySelectorAll('.approvalArea .approvalName').length;
      var maxApprovalCount = 2;

  
      if (existingApprovalCount >= maxApprovalCount) return;

      var currentIndex = existingApprovalCount + 1;

      nameAreas.forEach(function(nameArea) {
          var checkbox = nameArea.querySelector('input[type="checkbox"]:checked');
          if (checkbox && existingApprovalCount < maxApprovalCount) {
              var nameValue = nameArea.textContent.trim();

          
              var existingElement = document.querySelector('.approvalArea .approvalName' + currentIndex);
              if (existingElement) return;

              var className = 'approvalName' + currentIndex;

              var newElement = document.createElement('div');
              newElement.className = className;
              newElement.textContent = `${nameValue}`;

              document.querySelector('.approvalArea').appendChild(newElement);

              nameArea.remove();

              existingApprovalCount++;
              currentIndex++;
          }
      });
  });

document.querySelector('.approvalOut').addEventListener('click', function() {
    var approvalNames1 = document.querySelectorAll('.approvalArea .approvalName1');
    var approvalNames2 = document.querySelectorAll('.approvalArea .approvalName2');

    moveApprovalNames(approvalNames1);
    moveApprovalNames(approvalNames2);
});

function moveApprovalNames(approvalNames) {
    approvalNames.forEach(function(approvalName) {
        var nameText = approvalName.textContent.trim();

        var resultName = document.createElement('div');
        resultName.className = 'NameArea';
        resultName.textContent = nameText;

        var newCheckbox = document.createElement('input');
        newCheckbox.type = 'checkbox';
        resultName.appendChild(newCheckbox);

        document.querySelector('.resultNameArea').appendChild(resultName);

        approvalName.remove();
    });
}