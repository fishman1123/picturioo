<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setDateHeader("Expires", 0); // Proxies.
%>

<html>
<head>

    <title>Title</title>

    <link rel="stylesheet" type="text/css" href="/css/styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        .modalOverlay {
            display: none; /* Hidden by default */
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            z-index: 1000; /* On top of other elements */
        }

        .modalContainer {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 400px;
            padding: 20px;
            z-index: 1001;
        }

        .modalHeader, .modalFooter {
            padding: 10px 0;
        }

        .modalBody {
            padding: 20px 0;
        }

        #modalImage img {
            max-height: 500px;
        }
    </style>
    <script type="text/javascript">
        let editTrigger = false;
        let originalModalContent = '';


        document.addEventListener('DOMContentLoaded', () => {
            let imageList = {};
            fetch('/image/all')
                .then(response => response.json())
                .then(data => {
                    console.log("data transfer", data);
                    const container = document.getElementById("imageContainer");

                    // Group images by the exact minute
                    data.forEach(image => {
                        const createdAt = new Date(image.createdAt);
                        const minuteKey = createdAt.toISOString().slice(0, 16); // YYYY-MM-DDTHH:mm
                        if (!imageList[minuteKey]) {
                            imageList[minuteKey] = [];
                        }
                        imageList[minuteKey].push(image);
                    });

                    // Loop through the grouped images by minute
                    Object.keys(imageList).forEach(minuteKey => {
                        // Format minuteKey to {year}년{month}월{day}일{hour}시{minute}분
                        const match = minuteKey.match(/(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2})/);
                        const formattedDate = match[1] + '년' + match[2] + '월' + match[3] + '일' + match[4] + '시' + match[5] + '분';

                        // Create and append the <h1> element for the minute
                        const minuteHeader = document.createElement('h3');
                        minuteHeader.textContent = formattedDate;
                        container.appendChild(minuteHeader);

                        // Create and append a <div> for grouping the buttons for this minute
                        const minuteDiv = document.createElement('div');
                        minuteDiv.classList.add('minuteGroup');
                        container.appendChild(minuteDiv);

                        imageList[minuteKey].forEach(image => {
                            const buttonElement = document.createElement('button');
                            const imgElement = document.createElement('img');

                            buttonElement.classList.add("defaultButton");
                            buttonElement.style.width = "auto";
                            buttonElement.style.height = "120px";
                            buttonElement.style.padding = "0";
                            imgElement.src = image.imgUrl;  // Use the imgUrl directly
                            imgElement.alt = image.userName;
                            imgElement.style.width = '100%';
                            imgElement.style.height = '100%';
                            imgElement.setAttribute('data-url', image.imgUrl);
                            buttonElement.onclick = () => showModal(imgElement);
                            minuteDiv.appendChild(buttonElement);

                            buttonElement.appendChild(imgElement);
                        });
                    });

                    console.log(imageList); // For debugging to see the grouped images
                })
                .catch(error => console.error('Error fetching images:', error));
        });


        const showModal = (imageElement) => {
            const modalImage = document.getElementById('modalImage');
            modalImage.innerHTML = '';
            const img = document.createElement('img');
            img.src = imageElement.src;
            img.alt = imageElement.alt;
            img.style.width = '100%';
            img.setAttribute('data-url', imageElement.getAttribute('data-url'));
            modalImage.appendChild(img);
            document.getElementById('modalPage').style.display = 'block';

            // Store original content for undo
            originalModalContent = document.getElementById('imageContent').innerHTML;
            editTrigger = false;  // Ensure edit mode is off initially
        }

        const closeModal = () => {
            document.getElementById('modalPage').style.display = 'none';
        }

        const editPageTransition = () => {
            const modalImage = document.querySelector('#modalImage img');
            const editMainPlate = document.getElementById('imageContent');

            if (editTrigger) {
                // Undo the edit: restore original content
                editMainPlate.innerHTML = originalModalContent;
                editTrigger = false;
            } else {
                // Save original content before editing
                originalModalContent = editMainPlate.innerHTML;

                const editImageContainer = document.createElement('form');
                editImageContainer.method = "post";
                editImageContainer.action = "/image/edit";
                editImageContainer.enctype = "multipart/form-data";
                editImageContainer.classList.add('fileUploadContainer');
                editImageContainer.innerHTML = `
                    <img id="imagePreview" src="" alt="Logo" style="width: 100%; padding-bottom: 10px; cursor: pointer; margin: auto"/>
                    <input type="file" id="imageInput" class="padded-input" accept="image/*" style="display: none;" name="targetImage"/>
                    <input type="hidden" id="originalUrl" name="originalUrl" value="" />
                    <label for="imageInput" style="cursor: pointer;">이미지 선택</label>
                    <button type="button" class="defaultButton" onclick="cancelEdit()">수정취소</button>
                    <button type="submit" class="defaultButton">저장하기</button>
                `;

                editMainPlate.innerHTML = '';
                editMainPlate.appendChild(editImageContainer);

                const imagePreview = document.getElementById('imagePreview');
                imagePreview.src = modalImage.src;

                const originalUrlInput = document.getElementById('originalUrl');
                originalUrlInput.value = modalImage.getAttribute('data-url');
                const imageInput = document.getElementById('imageInput');
                imageInput.addEventListener('change', (event) => {
                    const reader = new FileReader();
                    reader.onload = (e) => {
                        imagePreview.src = e.target.result;
                    };
                    reader.readAsDataURL(event.target.files[0]);
                });

                imagePreview.addEventListener('click', () => {
                    imageInput.click();
                });

                editTrigger = true;
            }
        }


        const cancelEdit = () => {
            document.getElementById('imageContent').innerHTML = originalModalContent;
            editTrigger = false;
        }
        const deleteImage = () => {
            const modalImage = document.querySelector('#modalImage img');
            const imageUrl = modalImage.getAttribute('data-url');

            fetch('/image/delete', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ url: imageUrl })
            })
                .then(response => {
                    if (response.ok) {
                        return response.text(); // Assuming the server returns plain text
                    } else {
                        throw new Error('Network response was not ok.');
                    }
                })
                .then(data => {
                    console.log(data); // For debugging
                    window.location.href = '/main';
                })
                .catch(error => {
                    console.log(error);
                    console.error('Error:', error);
                });
        }




    </script>
</head>
<body>
<div class="mainPlate"
     style="display: flex; justify-content: center; align-items: center; background-color: white; width: 100vw; height: 100vh">

    <div style="height: 90%; width: 100%; margin-left: 60px; margin-right: 60px" class="mainPageTemplate">
        <h1>THIS IS MAIN</h1>
        <div><h1>searchbar</h1></div>
        <div>
            <button class="defaultButton" onclick="hello()" role="button">눌러봐라</button>
            <button class="defaultButton" style="margin: 0 20px 0 20px" onclick="location.href = '/'">Go to Main</button>
            <button class="defaultButton" style="margin: 0 20px 0 20px" onclick="location.href = '/upload/create'">Go Upload</button>
        </div>


        <div style="margin-top: 50px">
            <h3>테스트</h3>
            <div id="imageContainer"></div>
        </div>
        <div id="modalPage" class="modalOverlay">
            <div id="imageContent" class="modalContainer">
                <div id="modalImage" class="modalHeader">
                    <img src="" alt="Modal Image" style="width: 100%;">
                </div>
                <div class="modalBody">
                    <p>TEST</p>
                </div>
                <div class="modalFooter">
                    <button class="defaultButton" onclick="editPageTransition()">수정하기</button>
                    <button class="defaultButton" onclick="deleteImage()">삭제하기</button>
                    <button class="defaultButton" onclick="closeModal()">Close</button>
                </div>
                <c:if test="${not empty message}">
                    <div class="alert alert-success">${message}</div>
                </c:if>
            </div>
        </div>
    </div>
</div>
</body>
</html>
