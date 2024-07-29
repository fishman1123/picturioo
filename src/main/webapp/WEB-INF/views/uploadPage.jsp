<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="/css/styles.css">
</head>
<script type="text/javascript">

    const backToMain = () => {
        window.location.href = '/main';
    }

</script>
<body>
<div class="mainPlate uploadPlate">
    <div class="mainPageTemplate uploadPageTemplate">
        <form id="imageForm" style="display: flex; flex-direction: column; align-items: center" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
            <div>
                <div style="margin-top: 30px; text-align: center">
                    <h1>콧수염을 눌러 주세요</h1>
                </div>
                <div class="fileUploadContainer">
                    <img id="imagePreview" src="/img/logo.png" alt="Logo" style="max-width: 250px; height: 160px; padding-bottom: 10px; cursor: pointer; margin: auto">
                    <input type="file" id="imageInput" class="padded-input" accept="image/*" style="display: none;" name="targetImage">
                    <label for="imageInput" style="cursor: pointer;">이미지 선택</label>
                    <div class="file-status" id="fileStatus">No files have been selected</div>
                </div>
                <div id="container1" style="margin-top: 10px; height: 30px">
                    <label class="input">
                        <input id="textInput" class="input__field" onclick="wohhh(this.nextElementSibling)" onblur="checkInput(this, this.nextElementSibling)" style="height: 100%" type="text" placeholder=" " name="userName" />
                        <span id="inputText1" class="input__label" style="top: 7px; left: 7px">이름을 작성해주세요</span>
                    </label>
                </div>
            </div>
            <button class="defaultButton uploadButton" type="submit">업로드</button>
            <button style="margin-top: 10px" class="defaultButton uploadButton" type="button" onclick="backToMain()">업로드 취소</button>
        </form>
    </div>
</div>

<script type="text/javascript">
    let trackingValue = "";
    document.addEventListener('DOMContentLoaded', function() {
        const imagePreview = document.getElementById('imagePreview');
        const imageInput = document.getElementById('imageInput');

        imagePreview.addEventListener('click', function() {
            imageInput.click();
        });

        imageInput.addEventListener('change', function(event) {
            const file = event.target.files[0];
            const fileStatus = document.getElementById('fileStatus');

            if (file) {
                fileStatus.innerText = 'Selected file: ' + file.name;
                const reader = new FileReader();
                reader.onload = function(e) {
                    imagePreview.src = e.target.result;
                };
                reader.readAsDataURL(file);
            } else {
                fileStatus.innerText = 'No files have been selected';
                imagePreview.src = '/img/logo.png';
            }
        });
    });

    const validateForm = () => {
        const imagePreview = document.getElementById('imagePreview');
        const nameInput = document.getElementById('textInput');

        if (imagePreview.src.includes('/img/logo.png')) {
            alert("사진을 넣으셔야 합니다!");
            return false;  // Prevent form submission
        }
        if (nameInput.value.trim() === "") {
            alert("이름을 넣으셔야 합니다!");
            return false;  // Prevent form submission
        }
        return true;  // Allow form submission
    }

    const wohhh = (labelElement) => {
        console.log("ㅗㅗㅗㅗㅗㅗㅗㅗ");
        trackingValue = document.getElementById(labelElement.id).textContent;
        labelElement.innerText = "검색용 이름입니다!";
        console.log(`Label ID: ${labelElement.id}`);
    }

    const checkInput = (inputElement, labelElement) => {
        if (inputElement.value === "") {
            labelElement.innerText = trackingValue;
        }
        console.log(`Label ID: ${labelElement.id}`);
    }
</script>
</body>
</html>