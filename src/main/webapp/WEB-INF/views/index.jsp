
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core"  prefix="c" %>

<html>
<link rel="stylesheet" type="text/css" href="/css/styles.css">

<script type="text/javascript">
    document.addEventListener('DOMContentLoaded', () => {
        fetch('/image/all')
            .then(response => response.json())
            .then(data => {
                const container = document.getElementById("imageContainer");
                console.log(data);
                data.forEach(image => {
                    const imgElement = document.createElement('img');
                    imgElement.src = image.imgUrl;  // Use the imgUrl directly
                    console.log("check this: ", imgElement.src);
                    imgElement.alt = image.userName;
                    imgElement.style.width = '200px';
                    imgElement.style.height = 'auto';
                    container.appendChild(imgElement);

                    const nameElement = document.createElement('h1');
                    nameElement.textContent = image.userName;
                    container.appendChild(nameElement);
                });
            })
            .catch(error => console.error('Error fetching images:', error));
    });



</script>
<head>
    <title>Title</title>
</head>

<body>
<div class="mainPlate" style="display: flex; justify-content: center; align-items: center; background-color: aqua; width: 100vw; height: 100vh">


    <div style=" height: 500px; width: 100%; margin-left: 100px; margin-right: 100px" class="mainPageTemplate">
        <h1>THIS IS MAIN</h1>
        <button class="defaultButton" onclick="hello()" role="button">눌러봐라</button>

        <button class="defaultButton" style="margin: 0 20px 0 20px" onclick="location.href = '/'">Go to Main</button>
        <button class="defaultButton" style="margin: 0 20px 0 20px" onclick="location.href = '/upload/create'">Go Upload</button>

        <div style="margin-top: 50px">
            <h3>테스트</h3>

            <div id="imageContainer">

            </div>
        </div>

    </div>



</div>

</body>
</html>
