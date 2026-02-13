// script.js
document.addEventListener('DOMContentLoaded', () => {
  // Ano no footer
  const yearEl = document.getElementById('year');
  if (yearEl) yearEl.textContent = new Date().getFullYear();

  // Menu mobile
  const toggle = document.querySelector('.menu-toggle');
  const nav = document.getElementById('site-nav');
  if (toggle && nav) {
    toggle.addEventListener('click', () => {
      const isOpen = nav.classList.toggle('open');
      toggle.setAttribute('aria-expanded', String(isOpen));
    });

    // Fechar menu ao clicar em um link
    nav.addEventListener('click', (e) => {
      const target = e.target;
      if (target && target.matches('a')) {
        nav.classList.remove('open');
        toggle.setAttribute('aria-expanded', 'false');
      }
    });
  }

  // Scroll suave para âncoras internas
  document.querySelectorAll('a[href^="#"]').forEach((a) => {
    a.addEventListener('click', (e) => {
      const id = a.getAttribute('href');
      if (!id || id === '#') return;
      const el = document.querySelector(id);
      if (el) {
        e.preventDefault();
        el.scrollIntoView({ behavior: 'smooth', block: 'start' });
        history.pushState(null, '', id);
      }
    });
  });

  // Comunidade (exemplo sem backend) com validação simples e honeypot
  const joinForm = document.querySelector('.join-form');
  if (joinForm) {
    const emailInput = joinForm.querySelector('input[type="email"]');
    const hpInput = joinForm.querySelector('input[name="company"]'); // honeypot
    const messageEl = joinForm.querySelector('.form-message');

    joinForm.addEventListener('submit', (e) => {
      e.preventDefault();

      const email = emailInput?.value?.trim() || '';
      const botField = hpInput?.value?.trim() || '';

      // Honeypot: se preenchido, descartar
      if (botField.length > 0) {
        // Silenciosamente ignora submissões de bots
        return;
      }

      if (!email) {
        showMessage('Por favor, digite seu e-mail.', 'error', messageEl);
        emailInput?.focus();
        return;
      }

      if (!isValidEmail(email)) {
        showMessage('Por favor, insira um e-mail válido.', 'error', messageEl);
        emailInput?.focus();
        return;
      }

      // Aqui você pode integrar com Mailchimp/Brevo/ConvertKit/Back-end próprio
      // Exemplo fictício:
      // fetch('/api/subscribe', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ email }) })

      showMessage('Obrigado por se juntar! Em breve você receberá novidades da PlayUp English.', 'success', messageEl);
      joinForm.reset();
    });
  }

  function isValidEmail(email) {
    // Validação simples e permissiva
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
  }

  function showMessage(text, type, el) {
    if (!el) {
      alert(text);
      return;
    }
    el.textContent = text;
    el.style.color = type === 'success' ? '#2e7d32' : '#c62828';
  }
});
