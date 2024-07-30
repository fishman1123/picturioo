<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="/css/styles.css">
<style>
    #content {
        opacity: 0;
        transition: opacity 2s ease-in-out;
    }
    #content.fadeIn {
        opacity: 1;
    }
    #content.fadeOut {
        opacity: 0;
    }
</style>
    <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', () => {
            let introPage = document.getElementById("content");
            setTimeout(() => {
                introPage.classList.add("fadeIn");
            }, 300);
        });

        const movePage = () => {
            let introPage = document.getElementById("content");
            let targetButton = document.getElementById("pageButton");

            targetButton.disabled = true;

            introPage.classList.add("fadeOut");

            setTimeout(() => {
                location.href = '/main';
            }, 2000);
        }
    </script>
</head>
<body class="mainPlate">
<div id="hmm"></div>
<div id="content" style="display: flex; flex-direction: column; align-items: center" >
    <img id="imageIntro" src="/img/logo.png" alt="Logo" style="width: 100%; padding-bottom: 10px; cursor: pointer; margin: auto"/>
    <h1>PICTURIOO</h1>
    <button id="pageButton" class="defaultButton" style="width: 200px; font-size: 20px; height: auto" onclick="movePage()">추억담기</button>
</div>

</body>
</html>
