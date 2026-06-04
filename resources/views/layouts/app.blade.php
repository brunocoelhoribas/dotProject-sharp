<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>@yield('title', 'dotProject+ 2025')</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link href="{{ asset('css/custom.css') }}" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/frappe-gantt@0.6.1/dist/frappe-gantt.min.css">
    @stack('styles')
</head>
<body>
<main class="bg-secondary min-vh-100">
    @yield('content')

    <button class="btn btn-primary rounded-circle shadow-lg d-flex align-items-center justify-content-center"
            type="button"
            id="toggleAiChatBtn"
            style="position: fixed; bottom: 30px; right: 30px; width: 60px; height: 60px; z-index: 1050; transition: transform 0.2s;">
        <i class="bi bi-robot fs-3"></i>
    </button>

    <div class="card shadow-lg border-0 d-none flex-column"
         id="aiChatWidget"
         style="position: fixed; bottom: 105px; right: 30px; width: 380px; height: 550px; max-height: calc(100vh - 140px); z-index: 1050; border-radius: 1rem; overflow: hidden;">

        <div class="card-header bg-dark text-white border-0 p-3 d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center gap-2">
                <i class="bi bi-stars text-warning fs-5"></i>
                <h6 class="mb-0 fw-bold">{{ __('chat.title') }}</h6>
            </div>
            <button type="button" class="btn-close btn-close-white" id="closeAiChatBtn" aria-label="Close"></button>
        </div>

        <div id="chat-messages" class="card-body p-3 overflow-auto bg-light" style="flex-grow: 1;">
            <div class="d-flex mb-3">
                <div class="bg-white border rounded-3 p-3 shadow-sm" style="max-width: 85%;">
                    <p class="small mb-0 text-dark">{{ __('chat.greeting') }}</p>
                </div>
            </div>
        </div>

        <div class="card-footer p-3 bg-white border-0 shadow-sm">
            <form id="ai-chat-form" class="d-flex gap-2 m-0">
                <input type="text" id="chat-input" class="form-control rounded-pill bg-light border-0 px-3" placeholder="{{ __('chat.placeholder') }}" required autocomplete="off">
                <button type="submit" class="btn btn-primary rounded-circle d-flex align-items-center justify-content-center" style="width: 40px; height: 40px; flex-shrink: 0;">
                    <i class="bi bi-send-fill"></i>
                </button>
            </form>
        </div>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/frappe-gantt@0.6.1/dist/frappe-gantt.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
    document.addEventListener('DOMContentLoaded', function () {

        const toggleBtn = document.getElementById('toggleAiChatBtn');
        const closeBtn = document.getElementById('closeAiChatBtn');
        const chatWidget = document.getElementById('aiChatWidget');
        const chatInput = document.getElementById('chat-input');

        function toggleChat() {
            if (chatWidget.classList.contains('d-none')) {
                chatWidget.classList.remove('d-none');
                chatWidget.classList.add('d-flex');
                toggleBtn.style.transform = 'scale(0.8)';
                setTimeout(() => chatInput.focus(), 100);
            } else {
                chatWidget.classList.add('d-none');
                chatWidget.classList.remove('d-flex');
                toggleBtn.style.transform = 'scale(1)';
            }
        }

        toggleBtn.addEventListener('click', toggleChat);
        closeBtn.addEventListener('click', toggleChat);


        const chatForm = document.getElementById('ai-chat-form');
        const chatMessages = document.getElementById('chat-messages');

        let chatHistory = [];
        const projectId = "{{ $project->project_id ?? '' }}";

        chatForm.addEventListener('submit', async function (e) {
            e.preventDefault();

            const message = chatInput.value.trim();
            if (!message || !projectId) return;

            appendMessage('user', message);
            chatInput.value = '';

            const loadingId = appendLoading();

            try {
                const response = await fetch('{{ route('chat.assistant', $project->project_id ?? $project->id ?? 0) }}', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'X-CSRF-TOKEN': '{{ csrf_token() }}'
                    },
                    body: JSON.stringify({
                        message: message,
                        history: chatHistory
                    })
                });

                const data = await response.json();
                document.getElementById(loadingId).remove();

                if (response.ok) {
                    appendMessage('ai', data.reply);

                    chatHistory.push({ role: 'user', content: message });
                    chatHistory.push({ role: 'assistant', content: data.reply });
                } else {
                    const errorMessage = data.error ? data.error : '{{ __('chat.error_connection') }}';
                    appendMessage('ai', `<span class="text-danger"><i class="bi bi-exclamation-triangle me-1"></i> ${errorMessage}</span>`);
                }

            } catch (error) {
                document.getElementById(loadingId).remove();
                appendMessage('ai', '<span class="text-danger">{{ __('chat.error_network') }}</span>');
            }
        });

        function appendMessage(sender, text) {
            const isUser = sender === 'user';
            const alignClass = isUser ? 'justify-content-end' : '';
            const bgClass = isUser ? 'bg-primary text-white' : 'bg-white border text-dark';

            const formattedText = text.replace(/\n/g, '<br>');

            const msgHTML = `
            <div class="d-flex mb-3 ${alignClass}">
                <div class="rounded-3 p-3 shadow-sm ${bgClass}" style="max-width: 85%;">
                    <p class="small mb-0">${formattedText}</p>
                </div>
            </div>
            `;
            chatMessages.insertAdjacentHTML('beforeend', msgHTML);
            chatMessages.scrollTop = chatMessages.scrollHeight;
        }

        function appendLoading() {
            const id = 'loading-' + Date.now();
            const msgHTML = `
            <div id="${id}" class="d-flex mb-3">
                <div class="bg-white border rounded-3 p-3 shadow-sm d-flex gap-1" style="max-width: 85%;">
                    <div class="spinner-grow spinner-grow-sm text-secondary" role="status"></div>
                    <div class="spinner-grow spinner-grow-sm text-secondary" role="status" style="animation-delay: 0.2s"></div>
                    <div class="spinner-grow spinner-grow-sm text-secondary" role="status" style="animation-delay: 0.4s"></div>
                </div>
            </div>
            `;
            chatMessages.insertAdjacentHTML('beforeend', msgHTML);
            chatMessages.scrollTop = chatMessages.scrollHeight;
            return id;
        }
    });
</script>
@stack('scripts')
</body>
</html>
