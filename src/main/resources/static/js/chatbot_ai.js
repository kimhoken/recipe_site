// 중복 전송 방지
let isSending = false;

// 자주 묻는 질문 중복 로딩 방지
let popularLoaded = false;



// 챗봇 열기
function openChatbot() {

    const chatbot = document.getElementById("chatbotWrap");

    if (!chatbot) {
        console.error("chatbotWrap을 찾을 수 없습니다.");
        return;
    }

    chatbot.style.display = "block";

    // 처음 열었을 때 한 번만 자주 묻는 질문 조회
    if (!popularLoaded) {
        loadPopularQuestions();
        popularLoaded = true;
    }

    // 입력창 포커스
    const input = document.getElementById("chatInput");

    if (input) {
        input.focus();
    }
}


// 챗봇 닫기
function closeChatbot() {

    const chatbot = document.getElementById("chatbotWrap");

    if (chatbot) {
        chatbot.style.display = "none";
    }
}


// 자주 묻는 질문 불러오기
async function loadPopularQuestions() {

    const menu = document.getElementById("parentMenu");

    if (!menu) {
        return;
    }

    try {

        const response = await fetch("/api/chatbot/popular");

        if (!response.ok) {
            throw new Error("자주 묻는 질문 조회 실패");
        }

        const questions = await response.json();

        // 기존 메뉴 삭제
        menu.innerHTML = "";

        questions.forEach(item => {

            const button = document.createElement("button");

            button.type = "button";
            button.textContent = item.question;

            button.addEventListener("click", function () {
                sendQuickQuestion(item.question);
            });

            menu.appendChild(button);
        });

    } catch (error) {

        console.error("자주 묻는 질문 오류:", error);

        // 오류가 나도 챗봇 자체는 사용할 수 있도록 메뉴만 비움
        menu.innerHTML = "";
    }
}


// 자주 묻는 질문 클릭
function sendQuickQuestion(question) {

    if (isSending) {
        return;
    }

    const input = document.getElementById("chatInput");

    if (!input) {
        return;
    }

    input.value = question;

    sendChatMessage();
}


// AI 챗봇 메시지 전송
async function sendChatMessage() {

    // 이미 답변 생성 중이면 중복 전송 방지
    if (isSending) {
        return;
    }

    const input = document.getElementById("chatInput");

    if (!input) {
        return;
    }

    const question = input.value.trim();

    if (question === "") {
        return;
    }

    isSending = true;

    // 사용자 메시지 출력
    addUserMessage(question);

    // 입력창 초기화
    input.value = "";

    // 입력창/전송버튼 잠금
    setInputDisabled(true);

    // 로딩 메시지 출력
    showLoadingMessage();

    try {

        const response = await fetch(
            "/api/chatbot/ask?question=" + encodeURIComponent(question)
        );

        if (!response.ok) {
            throw new Error("챗봇 응답 오류");
        }

        const data = await response.json();

        // 로딩 메시지 제거
        removeLoadingMessage();

        // AI 답변 출력
        addBotMessage(
            data.answer,
            data.link_url,
            data.link_text
        );

    } catch (error) {

        console.error("AI 챗봇 오류:", error);

        removeLoadingMessage();

        addBotMessage(
            "죄송해요. 답변을 불러오는 중 문제가 발생했어요.",
            null,
            null
        );

    } finally {

        isSending = false;

        // 입력창 다시 활성화
        setInputDisabled(false);

        input.focus();
    }
}


// 사용자 메시지 출력
function addUserMessage(message) {

    const chatBody = document.getElementById("chatBody");

    if (!chatBody) {
        return;
    }

    const row = document.createElement("div");
    row.className = "user-row";

    const msg = document.createElement("div");
    msg.className = "user-msg";

    // 사용자 입력을 HTML로 실행하지 않도록 textContent 사용
    msg.textContent = message;

    row.appendChild(msg);
    chatBody.appendChild(row);

    scrollChatBottom();
}


// 챗봇 메시지 출력
function addBotMessage(message, linkUrl, linkText) {

    const chatBody = document.getElementById("chatBody");

    if (!chatBody) {
        return;
    }

    const row = document.createElement("div");
    row.className = "bot-row";

    // 챗봇 아이콘
    const icon = document.createElement("img");

    icon.src = "/images/bot.png";
    icon.className = "bot-icon";
    icon.alt = "도우미봇";


    // 답변 말풍선
    const content = document.createElement("div");
    content.className = "bot-msg";


    // 답변 텍스트
    const text = document.createElement("div");
    text.className = "bot-answer-text";

    // AI 응답을 HTML로 직접 삽입하지 않음
    text.textContent = message;

    content.appendChild(text);


    // DB에 링크가 있는 경우에만 링크 버튼 생성
    if (linkUrl && linkText) {

        const link = document.createElement("a");

        link.href = linkUrl;
        link.className = "chat-link-btn";
        link.textContent = linkText + " →";

        content.appendChild(link);
    }


    row.appendChild(icon);
    row.appendChild(content);

    chatBody.appendChild(row);

    scrollChatBottom();
}


// 로딩 메시지 출력
function showLoadingMessage() {

    const chatBody = document.getElementById("chatBody");

    if (!chatBody) {
        return;
    }

    // 혹시 기존 로딩 메시지가 있다면 제거
    removeLoadingMessage();


    const row = document.createElement("div");

    row.className = "bot-row";
    row.id = "chatLoading";


    const icon = document.createElement("img");

    icon.src = "/images/bot.png";
    icon.className = "bot-icon";
    icon.alt = "도우미봇";


    const message = document.createElement("div");

    message.className = "bot-msg loading-msg";


    const text = document.createElement("span");

    text.textContent = "답변을 작성하고 있어요";


    const dots = document.createElement("span");

    dots.className = "loading-dots";
    dots.textContent = "...";


    message.appendChild(text);
    message.appendChild(dots);


    row.appendChild(icon);
    row.appendChild(message);

    chatBody.appendChild(row);

    scrollChatBottom();
}


// 로딩 메시지 제거
function removeLoadingMessage() {

    const loading = document.getElementById("chatLoading");

    if (loading) {
        loading.remove();
    }
}


// 입력창 / 전송버튼 활성화 상태 변경
function setInputDisabled(disabled) {

    const input = document.getElementById("chatInput");
    const button = document.querySelector(".chat-send-btn");

    if (input) {
        input.disabled = disabled;
    }

    if (button) {
        button.disabled = disabled;
    }
}


// Enter 키 전송
function handleChatKey(event) {

    // 한글 조합 중 Enter 중복 실행 방지
    if (event.isComposing) {
        return;
    }

    if (event.key === "Enter") {

        event.preventDefault();

        sendChatMessage();
    }
}


// 채팅창을 가장 아래로 이동
function scrollChatBottom() {

    const chatBody = document.getElementById("chatBody");

    if (!chatBody) {
        return;
    }

    chatBody.scrollTop = chatBody.scrollHeight;
}