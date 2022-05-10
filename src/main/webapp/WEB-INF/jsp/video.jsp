<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>MediaCapture and Streams API</title>
    <meta name="viewport" content="width=device-width">
    <%--    <link rel="stylesheet" href="main.css">--%>
    <%--    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css?v=2">--%>
    <link rel="stylesheet" href="webjars/bootstrap/4.6.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="webjars/noty/3.1.4/demo/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="webjars/datatables/1.11.4/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="webjars/noty/3.1.4/lib/noty.css"/>

    <script src="webjars/jquery/3.6.0/jquery.min.js" defer></script>
    <script src="webjars/bootstrap/4.6.1/js/bootstrap.min.js" defer></script>
    <script src="webjars/datatables/1.11.4/js/jquery.dataTables.min.js" defer></script>
    <script src="webjars/datatables/1.11.4/js/dataTables.bootstrap4.min.js" defer></script>
    <script src="webjars/noty/3.1.4/lib/noty.min.js" defer></script>
</head>
<body>
<header>
    <h1>MediaCapture, MediaRecorder and Streams API</h1>
</header>
<main>
    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Impedit molestiae itaque facere totam saepe tempore
        esse temporibus, quae reprehenderit aliquid iusto ea laborum, iure eligendi odio exercitationem sapiente illum
        quos.</p>

    <p>
        <button id="btnStart">START RECORDING</button>
        <br/>
        <%--        <button class="tiny button hidden" id="btnStop">STOP REC</button>--%>
        <button id="btnStop" hidden>STOP RECORDING</button>
    </p>
    <video id="vid1" controls hidden></video>

    <video id="vid2" controls src="${savedVideo}"></video>
    <!-- could save to canvas and do image manipulation and saving too -->
    <input id="ajaxfile" hidden type="file"><br>
    <button onclick="uploadFileAjax()">Upload</button>
</main>
<script>
    let blobData = null;

    let constraintObj = {
        audio: true,
        video: {
            facingMode: "user",
            width: {min: 640, ideal: 1280, max: 1920},
            height: {min: 480, ideal: 720, max: 1080}
        }
    };
    // width: 1280, height: 720  -- preference only
    // facingMode: {exact: "user"}
    // facingMode: "environment"

    //handle older browsers that might implement getUserMedia in some way
    if (navigator.mediaDevices === undefined) {
        navigator.mediaDevices = {};
        navigator.mediaDevices.getUserMedia = function (constraintObj) {
            let getUserMedia = navigator.webkitGetUserMedia || navigator.mozGetUserMedia;
            if (!getUserMedia) {
                return Promise.reject(new Error('getUserMedia is not implemented in this browser'));
            }
            return new Promise(function (resolve, reject) {
                getUserMedia.call(navigator, constraintObj, resolve, reject);
            });
        }
    } else {
        navigator.mediaDevices.enumerateDevices()
            .then(devices => {
                devices.forEach(device => {
                    console.log(device.kind.toUpperCase(), device.label);
                    //, device.deviceId
                })
            })
            .catch(err => {
                console.log(err.name, err.message);
            })
    }

    navigator.mediaDevices.getUserMedia(constraintObj)
        .then(function (mediaStreamObj) {
            //connect the media stream to the first video element
            let video = document.querySelector('video');
            if ("srcObject" in video) {
                video.srcObject = mediaStreamObj;
            } else {
                //old version
                video.src = window.URL.createObjectURL(mediaStreamObj);
            }

            video.onloadedmetadata = function (ev) {
                //show in the video element what is being captured by the webcam
                video.pause();
            };

            //add listeners for saving video/audio
            let start = document.getElementById('btnStart');
            let stop = document.getElementById('btnStop');
            let video1 = document.getElementById('vid1');
            let video2 = document.getElementById('vid2');
            let mediaRecorder = new MediaRecorder(mediaStreamObj);
            let chunks = [];

            start.addEventListener('click', (ev) => {
                start.hidden = true;
                stop.hidden = false;
                video2.hidden = true;
                video1.hidden = false;
                video2.pause();
                video.play();
                // video1.play();
                mediaRecorder.start();
                console.log(mediaRecorder.state);
            })
            stop.addEventListener('click', (ev) => {
                stop.hidden = true;
                start.hidden = false;
                mediaRecorder.stop();
                video1.pause();
                video1.hidden = true;
                video2.hidden = false;
                console.log(mediaRecorder.state);
            });
            mediaRecorder.ondataavailable = function (ev) {
                chunks.push(ev.data);
            }
            mediaRecorder.onstop = (ev) => {
                let blob = new Blob(chunks, {'type': 'video/mp4'});
                blobData = blob;
                chunks = [];
                let videoURL = window.URL.createObjectURL(blob);
                video2.src = videoURL;
            }
        })
        .catch(function (err) {
            console.log(err.name, err.message);
        });

    async function uploadFileAjax() {
        if (blobData != null) {
            let formData = new FormData();
            const myFile = new File(
                [blobData],
                "demo.mp4",
                {type: 'video/mp4'}
            );
            formData.append('video', myFile);
            formData.append('id', ${id});
            $.ajax({
                url: '${pageContext.request.contextPath}/video',
                type: 'POST',
                data: formData,
                cache: false,
                processData: false,
                contentType: false
            }).done(function () {
                alert("Video saved");
                window.location.href = "${pageContext.request.contextPath}/tasks";
            }).fail(function () {
                alert("Error connecting");
            });
        } else {
            alert("No changes saved");
            window.location.href = "${pageContext.request.contextPath}/tasks";
        }
    }

    /*********************************
     getUserMedia returns a Promise
     resolve - returns a MediaStream Object
     reject returns one of the following errors
     AbortError - generic unknown cause
     NotAllowedError (SecurityError) - user rejected permissions
     NotFoundError - missing media track
     NotReadableError - user permissions given but hardware/OS error
     OverconstrainedError - constraint video settings preventing
     TypeError - audio: false, video: false
     *********************************/
</script>
</body>
</html>