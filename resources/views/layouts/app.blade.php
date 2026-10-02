<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>@yield('title', 'dotProject+ 2025')</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link href="{{ asset('css/custom.css') }}?v={{ file_exists(public_path('css/custom.css')) ? filemtime(public_path('css/custom.css')) : time() }}" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/frappe-gantt@0.6.1/dist/frappe-gantt.min.css">
    @stack('styles')
</head>
<body>
<main class="bg-secondary min-vh-100">
    @yield('content')

@auth
    <!-- Botão Flutuante do Chat de IA -->
    <button class="btn btn-primary rounded-circle shadow-lg d-flex align-items-center justify-content-center"
            type="button"
            id="toggleAiChatBtn"
            style="position: fixed; bottom: 30px; right: 30px; width: 60px; height: 60px; z-index: 1050; transition: transform 0.2s;">
        <i class="bi bi-robot fs-3"></i>
    </button>

    <!-- Widget do Chat de IA -->
    <div class="card shadow-lg border-0 flex-column"
         id="aiChatWidget"
         style="position: fixed; bottom: 105px; right: 30px; width: 380px; height: 550px; max-height: calc(100vh - 140px); z-index: 1050; border-radius: 1rem; overflow: hidden;">

        <div class="card-header bg-dark text-white border-0 p-3 d-flex justify-content-between align-items-center" data-bs-theme="dark">
            <div class="d-flex align-items-center gap-2">
                <i class="bi bi-stars text-warning fs-5"></i>
                <h6 class="mb-0 fw-bold">{{ __('chat.title') }}</h6>
            </div>
            <div class="d-flex align-items-center gap-1">
                <button type="button" class="btn btn-link text-white-50 p-1 me-1" id="clearAiChatBtn" title="{{ __('chat.clear_history') }}" aria-label="{{ __('chat.clear_history') }}" style="transition: color 0.2s;">
                    <i class="bi bi-trash fs-5"></i>
                </button>
                <button type="button" class="btn btn-link text-white-50 p-1 me-1" id="minimizeAiChatBtn" title="Minimizar" aria-label="Minimizar" style="transition: color 0.2s;">
                    <i class="bi bi-dash-lg fs-5"></i>
                </button>
                <button type="button" class="btn btn-link text-white p-1" id="closeAiChatBtn" title="Fechar" aria-label="Fechar" style="transition: opacity 0.2s;">
                    <i class="bi bi-x-lg fs-5"></i>
                </button>
            </div>
        </div>

        <div id="chat-messages" class="card-body p-3 overflow-auto bg-light" style="flex-grow: 1;">
            <!-- Conteúdo carregado dinamicamente -->
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
@endauth
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/frappe-gantt@0.6.1/dist/frappe-gantt.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>

@auth
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const toggleBtn = document.getElementById('toggleAiChatBtn');
        const closeBtn = document.getElementById('closeAiChatBtn');
        const minimizeBtn = document.getElementById('minimizeAiChatBtn');
        const clearBtn = document.getElementById('clearAiChatBtn');
        const chatWidget = document.getElementById('aiChatWidget');
        const chatInput = document.getElementById('chat-input');
        const chatForm = document.getElementById('ai-chat-form');
        const chatMessages = document.getElementById('chat-messages');

        const projectId = "{{ $project->project_id ?? $project->id ?? 0 }}";
        const chatHistoryKey = 'ai_chat_history_' + projectId;

        let chatHistory = [];

        function loadHistory() {
            const stored = localStorage.getItem(chatHistoryKey);
            if (stored) {
                try {
                    chatHistory = JSON.parse(stored);
                } catch (e) {
                    chatHistory = [];
                }
            } else {
                chatHistory = [];
            }
            renderChat();
        }

        function saveHistory() {
            localStorage.setItem(chatHistoryKey, JSON.stringify(chatHistory));
        }

        function renderChat() {
            chatMessages.innerHTML = '';

            const greetingText = projectId == 0 
                ? "{{ __('chat.greeting_global') }}" 
                : "{{ __('chat.greeting') }}";

            appendMessageMarkup('ai', greetingText);

            chatHistory.forEach(msg => {
                const sender = msg.role === 'user' ? 'user' : 'ai';
                appendMessageMarkup(sender, msg.content);
            });

            if (chatHistory.length === 0) {
                renderSuggestions();
            }

            chatMessages.scrollTop = chatMessages.scrollHeight;
        }

        function renderSuggestions() {
            const suggestionsHTML = `
            <div id="suggestion-chips-container" class="d-flex flex-column gap-2 mt-3">
                <button type="button" class="suggestion-chip d-flex align-items-center gap-2" data-prompt="{{ __('chat.suggestion_summary') }}">
                    <i class="bi bi-briefcase"></i>
                    <span>{{ __('chat.suggestion_summary') }}</span>
                </button>
                <button type="button" class="suggestion-chip d-flex align-items-center gap-2" data-prompt="{{ __('chat.suggestion_overdue') }}">
                    <i class="bi bi-exclamation-octagon"></i>
                    <span>{{ __('chat.suggestion_overdue') }}</span>
                </button>
                <button type="button" class="suggestion-chip d-flex align-items-center gap-2" data-prompt="{{ __('chat.suggestion_milestones') }}">
                    <i class="bi bi-flag"></i>
                    <span>{{ __('chat.suggestion_milestones') }}</span>
                </button>
            </div>
            `;
            chatMessages.insertAdjacentHTML('beforeend', suggestionsHTML);

            document.querySelectorAll('.suggestion-chip').forEach(chip => {
                chip.addEventListener('click', function () {
                    const prompt = this.getAttribute('data-prompt');
                    submitMessage(prompt);
                });
            });
        }

        function openChat() {
            if (!chatWidget) return;
            chatWidget.classList.add('show');
            if (toggleBtn) {
                toggleBtn.innerHTML = '<i class="bi bi-x-lg fs-3"></i>';
                toggleBtn.style.transform = 'scale(0.9)';
                toggleBtn.setAttribute('title', 'Fechar Chat');
            }
            setTimeout(() => { if (chatInput) chatInput.focus(); }, 150);
            sessionStorage.setItem('ai_chat_state', 'open');
        }

        function closeChat() {
            if (!chatWidget) return;
            chatWidget.classList.remove('show');
            if (toggleBtn) {
                toggleBtn.innerHTML = '<i class="bi bi-robot fs-3"></i>';
                toggleBtn.style.transform = 'scale(1)';
                toggleBtn.setAttribute('title', 'Abrir Chat');
            }
            sessionStorage.setItem('ai_chat_state', 'closed');
        }

        function toggleChat() {
            if (!chatWidget) return;
            if (chatWidget.classList.contains('show')) {
                closeChat();
            } else {
                openChat();
            }
        }

        if (toggleBtn) {
            toggleBtn.addEventListener('click', function(e) {
                e.stopPropagation();
                toggleChat();
            });
        }

        if (closeBtn) {
            closeBtn.addEventListener('click', function(e) {
                e.stopPropagation();
                closeChat();
            });
        }

        if (minimizeBtn) {
            minimizeBtn.addEventListener('click', function(e) {
                e.stopPropagation();
                closeChat();
            });
        }

        // Fechar ao clicar fora do widget
        document.addEventListener('click', function(e) {
            if (chatWidget && chatWidget.classList.contains('show')) {
                if (!chatWidget.contains(e.target) && (!toggleBtn || !toggleBtn.contains(e.target))) {
                    closeChat();
                }
            }
        });

        // Fechar com a tecla ESC
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape' && chatWidget && chatWidget.classList.contains('show')) {
                closeChat();
            }
        });

        // Evitar que cliques dentro do chat fechem o widget
        if (chatWidget) {
            chatWidget.addEventListener('click', function(e) {
                e.stopPropagation();
            });
        }

        if (clearBtn) {
            clearBtn.addEventListener('click', function () {
                if (confirm('Deseja realmente limpar o histórico de conversas deste contexto?')) {
                    localStorage.removeItem(chatHistoryKey);
                    chatHistory = [];
                    renderChat();
                }
            });
        }

        chatForm.addEventListener('submit', function (e) {
            e.preventDefault();
            const message = chatInput.value.trim();
            if (!message) return;
            chatInput.value = '';
            submitMessage(message);
        });

        async function submitMessage(message) {
            const suggestions = document.getElementById('suggestion-chips-container');
            if (suggestions) suggestions.remove();

            appendMessageMarkup('user', message);

            const loadingId = appendLoading();

            try {
                const response = await fetch('{{ route('chat.assistant', [], false) }}', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]')?.getAttribute('content') || '{{ csrf_token() }}',
                        'Accept': 'application/json'
                    },
                    body: JSON.stringify({
                        message: message,
                        history: chatHistory,
                        project_id: projectId !== '0' ? projectId : null
                    })
                });

                let data = null;
                const contentType = response.headers.get('content-type') || '';
                if (contentType.includes('application/json')) {
                    try {
                        data = await response.json();
                    } catch (e) {
                        data = null;
                    }
                }

                const loader = document.getElementById(loadingId);
                if (loader) loader.remove();

                if (response.ok && data && data.reply) {
                    appendMessageMarkup('ai', data.reply);
                    chatHistory.push({ role: 'user', content: message });
                    chatHistory.push({ role: 'assistant', content: data.reply });
                    saveHistory();
                } else {
                    const errorMessage = (data && data.error) 
                        ? data.error 
                        : (response.status === 504 || response.status === 502)
                            ? 'O modelo de IA demorou mais que o esperado para responder. Tente uma pergunta mais específica.'
                            : '{{ __('chat.error_connection') }}';
                    appendMessageMarkup('ai', `<span class="text-danger"><i class="bi bi-exclamation-triangle me-1"></i> ${errorMessage}</span>`);
                }

            } catch (error) {
                const loader = document.getElementById(loadingId);
                if (loader) loader.remove();
                appendMessageMarkup('ai', `<span class="text-danger"><i class="bi bi-exclamation-triangle me-1"></i> {{ __('chat.error_network') }} (${error.message})</span>`);
            }
        }

        function appendMessageMarkup(sender, text) {
            const isUser = sender === 'user';
            const alignClass = isUser ? 'justify-content-end' : '';
            const bubbleClass = isUser ? 'chat-bubble-user' : 'chat-bubble-ai';

            let contentHTML = '';
            if (isUser) {
                contentHTML = `<p class="small mb-0 text-white" style="white-space: pre-line;">${text}</p>`;
            } else {
                if (typeof marked !== 'undefined') {
                    contentHTML = `<div class="small mb-0 text-dark markdown-body">${marked.parse(text)}</div>`;
                } else {
                    const formatted = text.replace(/\n/g, '<br>');
                    contentHTML = `<p class="small mb-0 text-dark">${formatted}</p>`;
                }
            }

            const avatarHTML = isUser 
                ? `<div class="bg-dark text-white rounded-circle d-flex align-items-center justify-content-center ms-2" style="width: 32px; height: 32px; font-size: 0.75rem; font-weight: bold; flex-shrink: 0;">U</div>`
                : `<div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-2" style="width: 32px; height: 32px; flex-shrink: 0;"><i class="bi bi-robot"></i></div>`;

            const msgHTML = `
            <div class="d-flex mb-3 ${alignClass}">
                ${!isUser ? avatarHTML : ''}
                <div class="rounded-3 p-3 shadow-sm ${bubbleClass}" style="max-width: 80%;">
                    ${contentHTML}
                </div>
                ${isUser ? avatarHTML : ''}
            </div>
            `;
            chatMessages.insertAdjacentHTML('beforeend', msgHTML);
            chatMessages.scrollTop = chatMessages.scrollHeight;
        }

        function appendLoading() {
            const id = 'loading-' + Date.now();
            const avatarHTML = `<div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-2" style="width: 32px; height: 32px; flex-shrink: 0;"><i class="bi bi-robot"></i></div>`;
            const msgHTML = `
            <div id="${id}" class="d-flex mb-3">
                ${avatarHTML}
                <div class="bg-white border rounded-3 p-3 shadow-sm d-flex gap-1 align-items-center" style="max-width: 80%;">
                    <div class="spinner-grow spinner-grow-sm text-secondary" role="status" style="width: 8px; height: 8px;"></div>
                    <div class="spinner-grow spinner-grow-sm text-secondary" role="status" style="width: 8px; height: 8px; animation-delay: 0.2s"></div>
                    <div class="spinner-grow spinner-grow-sm text-secondary" role="status" style="width: 8px; height: 8px; animation-delay: 0.4s"></div>
                </div>
            </div>
            `;
            chatMessages.insertAdjacentHTML('beforeend', msgHTML);
            chatMessages.scrollTop = chatMessages.scrollHeight;
            return id;
        }

        loadHistory();

        // Restaurar estado aberto/fechado
        const storedState = sessionStorage.getItem('ai_chat_state');
        if (storedState === 'open') {
            chatWidget.style.transition = 'none';
            if (toggleBtn) toggleBtn.style.transition = 'none';
            chatWidget.classList.add('show');
            if (toggleBtn) {
                toggleBtn.innerHTML = '<i class="bi bi-x-lg fs-3"></i>';
                toggleBtn.style.transform = 'scale(0.9)';
                toggleBtn.setAttribute('title', 'Fechar Chat');
            }
            // Forçar reflow para aplicar instantaneamente
            chatWidget.offsetHeight;
            chatWidget.style.transition = '';
            if (toggleBtn) toggleBtn.style.transition = '';
        }
    });
</script>
@endauth
@includeIf('components.status_modal')
@stack('scripts')
</body>
</html>
