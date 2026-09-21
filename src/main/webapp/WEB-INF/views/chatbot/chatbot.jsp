<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>

    <head>

    </head>

    <body>

        <!-- 화면 오른쪽 아래 챗봇 실행 버튼 -->
        <input type="button" class="chatbot-fixed-btn" value="?" onclick="openChatbot()" />

        <div class="chatbot-wrap" id="chatbotWrap">

            <!-- 챗봇 상단 헤더 -->
            <div class="chat-header">
                <img src="/images/bot.png" class="bot-icon">
                <span>도우미봇</span>

                <button type="button" class="chat-close-btn" onclick="closeChatbot()">
                    x
                </button>
            </div>


            <!-- 채팅 내용 -->
            <div class="chat-body" id="chatBody">

                <!-- 기본 안내 메시지 -->
                <div class="bot-row">

                    <img src="/images/bot.png" class="bot-icon">

                    <div class="bot-msg">
                        안녕하세요! 오늘 뭐 먹지?<br />
                        AI 고객지원 챗봇입니다.<br />
                        궁금한 내용을 자유롭게 질문해 주세요.
                    </div>

                </div>

                <!-- 자주 묻는 질문 -->
                <div class="quick-menu" id="parentMenu"></div>

            </div>


            <!-- 질문 입력 영역 -->
            <div class="chat-input-wrap">

                <input type="text" id="chatInput" class="chat-input" placeholder="궁금한 내용을 입력해주세요." autocomplete="off"
                    onkeydown="handleChatKey(event)" />

                <button type="button" class="chat-send-btn" onclick="sendChatMessage()">
                    전송
                </button>

            </div>

        </div>

        <script src="${pageContext.request.contextPath}/js/chatbot_ai.js"></script>

    </body>

</html>