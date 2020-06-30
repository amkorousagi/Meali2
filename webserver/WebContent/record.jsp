<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="dao.blob" %>
<html>

<head>
    <meta charset="UTF-8">
    <title>음성인식</title>
    <link rel="stylesheet" href="resources/css/index.css"/>
    <link rel="stylesheet" href="resources/css/all.css"/>
    <script type="text/javascript" src="resources/js/nav.js"></script>
	<meta name="viewport" content="width=device-width"/>
</head>

<body>
<jsp:include page="sub_header.jsp"/>
<jsp:include page="nav.jsp"/>
<section class="container">
    <input type=checkbox id="chk-hear-mic"><label for="chk-hear-mic">마이크 소리 듣기</label>
    <button id="record">녹음</button>
    <button id="stop">정지</button>
    <div id="sound-clips"></div>
    <script>
    	const record = document.getElementById("record")
        const stop = document.getElementById("stop")
        const soundClips = document.getElementById("sound-clips")
        const chkHearMic = document.getElementById("chk-hear-mic")

        const audioCtx = new(window.AudioContext || window.webkitAudioContext)() // 오디오 컨텍스트 정의

        const analyser = audioCtx.createAnalyser()
        //        const distortion = audioCtx.createWaveShaper()
        //        const gainNode = audioCtx.createGain()
        //        const biquadFilter = audioCtx.createBiquadFilter()

        function makeSound(stream) {
            const source = audioCtx.createMediaStreamSource(stream)

            source.connect(analyser)
            //            analyser.connect(distortion)
            //            distortion.connect(biquadFilter)
            //            biquadFilter.connect(gainNode)
            //            gainNode.connect(audioCtx.destination) // connecting the different audio graph nodes together
            analyser.connect(audioCtx.destination)

        }

        if (navigator.mediaDevices) {
            console.log('getUserMedia supported.')

            const constraints = {
                audio: true
            }
            let chunks = []

            navigator.mediaDevices.getUserMedia(constraints)
                .then(stream => {

                    const mediaRecorder = new MediaRecorder(stream)
                    
                    chkHearMic.onchange = e => {
                        if(e.target.checked == true) {
                            audioCtx.resume()
                            makeSound(stream)
                        } else {
                            audioCtx.suspend()
                        }
                    }
                    
                    record.onclick = () => {
                        mediaRecorder.start()
                        console.log(mediaRecorder.state)
                        console.log("recorder started")
                        record.style.background = "red"
                        record.style.color = "black"
                    }

                    stop.onclick = () => {
                        mediaRecorder.stop()
                        console.log(mediaRecorder.state)
                        console.log("recorder stopped")
                        record.style.background = ""
                        record.style.color = ""
                    }

                    mediaRecorder.onstop = e => {
                        console.log("data available after MediaRecorder.stop() called.")

                        const audio = document.createElement('audio')
                        audio.setAttribute('controls', '')
                        audio.controls = true
                        const b = new Blob(chunks, {
                            'type': 'audio/ogg codecs=opus'
                        })
                        chunks = []
                        const audioURL = URL.createObjectURL(b)
                        audio.src = audioURL
                        console.log("recorder stopped")
                    }

                    mediaRecorder.ondataavailable = e => {
                        chunks.push(e.data)
                    }
                })
                .catch(err => {
                    console.log('The following error occurred: ' + err)
                })
        }
    </script>
    <%
		request.setCharacterEncoding("UTF-8");
    	
    	
    %>
</section>
<jsp:include page="footer.jsp"/>
</body>
</html>