// Menu mobile
const menuToggle = document.querySelector('.menu-toggle');
const mainNav = document.querySelector('.main-nav');

if (menuToggle && mainNav) {
  menuToggle.addEventListener('click', () => {
    const isOpen = mainNav.classList.toggle('open');
    menuToggle.setAttribute('aria-expanded', String(isOpen));
  });
}

// Carrossel simples (depoimentos)
const track = document.querySelector('.carousel-track');
const prev = document.querySelector('.carousel-nav.prev');
const next = document.querySelector('.carousel-nav.next');

if (track && prev && next) {
  const step = () => track.firstElementChild?.getBoundingClientRect().width + 18 || 320;

  prev.addEventListener('click', () => {
    track.scrollBy({ left: -step(), behavior: 'smooth' });
  });
  next.addEventListener('click', () => {
    track.scrollBy({ left: step(), behavior: 'smooth' });
  });
}

// Formulário da comunidade (exemplo sem backend)
const joinForm = document.querySelector('.join-form');
if (joinForm) {
  joinForm.addEventListener('submit', (e) => {
    e.preventDefault();
    const email = joinForm.querySelector('input[type="email"]')?.value?.trim();
    if (!email) return alert('Por favor, digite seu e-mail.');
    // Aqui você pode integrar com um serviço como Mailchimp, Brevo ou API própria
    alert('Obrigado por se juntar! Em breve você receberá novidades da PlayUp English.');
    joinForm.reset();
  });
}