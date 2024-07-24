<%--
  Created by IntelliJ IDEA.
  User: yongjoocho
  Date: 2024. 7. 24.
  Time: 오후 1:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<link rel="stylesheet" type="text/css" href="/css/styles.css">
<script type="text/javascript">
    //폼 별 리스트 생성
    //DOM 사용
    const wohhh = (labelElement) => {
        console.log("ㅗㅗㅗㅗㅗㅗㅗㅗ");
        labelElement.innerText = "한글로 작성해주세요";
        console.log(`Label ID: ${labelElement.id}`);
    }

    const checkInput = (inputElement, labelElement) => {
        if (inputElement.value === "") {
            labelElement.innerText = "입력하세요~";
        }
        console.log(`Label ID: ${labelElement.id}`);
    }
</script>
<body>
<div class="mainPlate uploadPlate">
    <div class="mainPageTemplate" style="width: 100%; height: 400px; min-width: 200px; max-width: 500px; margin: 0 100px 0 100px;">
        <form>
            <div style="margin-top: 30px; text-align: center">
                <h1>업로드 창입니다</h1>
            </div>
            <div id="container1" style="margin-top: 10px; height: 30px">
                <label class="input">
                    <input class="input__field" onclick="wohhh(this.nextElementSibling)" onblur="checkInput(this, this.nextElementSibling)" style="height: 100%" type="text" placeholder=" " />
                    <span id="inputText1" class="input__label" style="top: 7px; left: 7px">이름 입력~</span>
                </label>
            </div>
            <div id="container2" style="margin-top: 30px; height: 30px">
                <label class="input">
                    <input class="input__field" onclick="wohhh(this.nextElementSibling)" onblur="checkInput(this, this.nextElementSibling)" style="height: 100%" type="text" placeholder=" " />
                    <span id="inputText2" class="input__label" style="top: 7px; left: 7px">뭐든 입력~</span>
                </label>
            </div>
        </form>

    </div>
</div>

</body>
</html>
