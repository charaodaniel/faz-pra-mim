#!/bin/bash

# ============================================
# Script de criação completo do projeto "Faz pra mim"
# Execute: chmod +x criar-faz-pra-mim.sh && ./criar-faz-pra-mim.sh
# ============================================

echo "╔═══════════════════════════════════════════════════════════╗"
echo "║                                                           ║"
echo "║     🚀 CRIANDO PROJETO COMPLETO - FAZ PRA MIM 🚀          ║"
echo "║                                                           ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""

# Criar estrutura de pastas
echo "📁 Criando estrutura de pastas..."
mkdir -p src/public/css
mkdir -p src/public/js
mkdir -p src/views
mkdir -p src/routes
mkdir -p src/controllers
mkdir -p src/models
mkdir -p src/database
mkdir -p src/middleware
mkdir -p src/public/images
echo "✅ Pastas criadas!"
echo ""

# ============================================
# 1. LANDING PAGE (index.html)
# ============================================
echo "📄 Criando Landing Page..."
cat > src/views/index.html << 'EOF'
<!DOCTYPE html>
<html class="light" lang="pt-BR">
<head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Faz pra mim | Encontre o profissional certo</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script>
tailwind.config = {
  darkMode: "class",
  theme: {
    extend: {
      colors: {
        primary: "#630ed4",
        "primary-container": "#7c3aed",
        "on-primary-container": "#ede0ff",
        secondary: "#795900",
        "secondary-container": "#ffc329",
        background: "#fef7ff",
        "surface-container-low": "#f9f1ff",
        "surface-container-highest": "#e8dfee",
        "outline-variant": "#ccc3d8",
        "on-surface": "#1d1a24",
        "on-surface-variant": "#4a4455",
      }
    }
  }
}
</script>
<style>
.material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; }
.hero-pattern { background-image: radial-gradient(circle at 2px 2px, #7c3aed15 1px, transparent 0); background-size: 24px 24px; }
</style>
</head>
<body class="bg-background text-on-surface font-inter overflow-x-hidden">

<header class="fixed top-0 w-full z-50 bg-surface/80 backdrop-blur-md shadow-sm">
  <div class="flex justify-between items-center px-6 md:px-10 h-16 max-w-7xl mx-auto">
    <div class="text-2xl font-bold text-primary">🔧 Faz pra mim</div>
    <nav class="hidden md:flex gap-6">
      <a href="/" class="text-primary border-b-2 border-primary pb-1">Início</a>
      <a href="/buscar" class="text-on-surface-variant hover:text-primary">Freelancers</a>
      <a href="#" class="text-on-surface-variant hover:text-primary">Como funciona</a>
      <a href="#" class="text-on-surface-variant hover:text-primary">Categorias</a>
    </nav>
    <div class="flex gap-3">
      <button onclick="window.location.href='/perfil'" class="text-primary px-4 py-2 hover:bg-primary/10 rounded-lg transition">Entrar</button>
      <button onclick="window.location.href='/dashboard'" class="bg-primary text-white px-5 py-2 rounded-lg hover:opacity-90 transition">Profissional</button>
    </div>
  </div>
</header>

<section class="relative pt-32 pb-20 px-6 md:px-10 hero-pattern">
  <div class="max-w-7xl mx-auto flex flex-col md:flex-row items-center gap-8">
    <div class="flex-1 text-center md:text-left">
      <h1 class="text-4xl md:text-5xl font-extrabold text-on-surface mb-4">Encontre o profissional <span class="text-primary">certo</span>, agora mesmo</h1>
      <p class="text-lg text-on-surface-variant mb-6 max-w-xl">A plataforma que conecta freelancers talentosos a clientes que precisam de resultados excepcionais. De design a serviços domésticos, nós cuidamos de tudo.</p>
      <div class="flex flex-col sm:flex-row gap-4 justify-center md:justify-start">
        <button onclick="window.location.href='/buscar'" class="bg-primary-container text-on-primary-container px-8 py-3 rounded-xl font-semibold hover:shadow-lg transition flex items-center gap-2 group">
          Começar Agora
          <span class="material-symbols-outlined group-hover:translate-x-1 transition">arrow_forward</span>
        </button>
        <div class="flex items-center gap-2 px-4">
          <span class="material-symbols-outlined text-secondary" style="font-variation-settings: 'FILL' 1;">verified</span>
          <span class="text-sm">Profissionais verificados</span>
        </div>
      </div>
    </div>
    <div class="flex-1 relative">
      <div class="absolute inset-0 bg-primary/5 rounded-full blur-3xl"></div>
      <img src="https://images.pexels.com/photos/3184418/pexels-photo-3184418.jpeg?auto=compress&cs=tinysrgb&w=800" class="relative rounded-2xl shadow-2xl w-full h-96 object-cover" alt="Profissionais trabalhando"/>
      <div class="absolute -bottom-4 -left-4 bg-white/80 backdrop-blur-md p-4 rounded-2xl shadow-lg">
        <div class="flex items-center gap-3"><div class="bg-secondary-container p-2 rounded-full"><span class="material-symbols-outlined text-on-secondary-container">trending_up</span></div><div><div class="text-xl font-bold">15k+</div><div class="text-xs text-gray-500">Jobs Realizados</div></div></div>
      </div>
    </div>
  </div>
</section>

<section class="py-20 px-6 md:px-10 bg-surface-container-low">
  <div class="max-w-7xl mx-auto text-center mb-12">
    <h2 class="text-3xl md:text-4xl font-bold mb-2">Para todos os objetivos</h2>
    <p class="text-on-surface-variant">Três caminhos, um só destino: excelência.</p>
  </div>
  <div class="grid md:grid-cols-3 gap-6">
    <div class="bg-white p-6 rounded-2xl border hover:border-primary transition-all hover:shadow-lg group">
      <div class="w-16 h-16 bg-primary/10 rounded-2xl flex items-center justify-center mb-4 group-hover:bg-primary-container transition-colors"><span class="material-symbols-outlined text-primary text-3xl group-hover:text-white">person_celebrate</span></div>
      <h3 class="text-xl font-bold mb-2">Freelancers</h3>
      <p class="text-on-surface-variant mb-4">Aumente seus ganhos, gerencie projetos e construa uma reputação sólida com as melhores ferramentas do mercado.</p>
      <a href="#" class="text-primary font-semibold inline-flex items-center gap-1 hover:gap-2 transition">Saiba mais <span class="material-symbols-outlined text-sm">chevron_right</span></a>
    </div>
    <div class="bg-white p-6 rounded-2xl border hover:border-primary transition-all hover:shadow-lg group">
      <div class="w-16 h-16 bg-secondary/20 rounded-2xl flex items-center justify-center mb-4 group-hover:bg-secondary-container transition-colors"><span class="material-symbols-outlined text-secondary text-3xl group-hover:text-white">business</span></div>
      <h3 class="text-xl font-bold mb-2">Empresas</h3>
      <p class="text-on-surface-variant mb-4">Escalone seu time sob demanda com especialistas qualificados. Gestão de contratos e faturas em um só lugar.</p>
      <a href="#" class="text-secondary font-semibold inline-flex items-center gap-1 hover:gap-2 transition">Soluções Enterprise <span class="material-symbols-outlined text-sm">chevron_right</span></a>
    </div>
    <div class="bg-white p-6 rounded-2xl border hover:border-primary transition-all hover:shadow-lg group">
      <div class="w-16 h-16 bg-orange-100 rounded-2xl flex items-center justify-center mb-4 group-hover:bg-tertiary-container transition-colors"><span class="material-symbols-outlined text-orange-600 text-3xl group-hover:text-white">shopping_cart</span></div>
      <h3 class="text-xl font-bold mb-2">Clientes</h3>
      <p class="text-on-surface-variant mb-4">Precisa de um conserto em casa ou um design rápido? Publique seu projeto e receba propostas em minutos.</p>
      <a href="#" class="text-orange-600 font-semibold inline-flex items-center gap-1 hover:gap-2 transition">Contratar Agora <span class="material-symbols-outlined text-sm">chevron_right</span></a>
    </div>
  </div>
</section>

<section class="py-20 px-6 md:px-10">
  <div class="max-w-7xl mx-auto text-center mb-12">
    <span class="text-primary font-semibold text-sm uppercase tracking-wider">Como funciona</span>
    <h2 class="text-3xl md:text-4xl font-bold mt-2">Simples e rápido</h2>
  </div>
  <div class="grid md:grid-cols-3 gap-8 relative">
    <div class="hidden md:block absolute top-20 left-0 w-full h-0.5 border-t-2 border-dashed border-outline-variant"></div>
    <div class="text-center relative z-10">
      <div class="w-20 h-20 rounded-full bg-primary-container text-on-primary-container flex items-center justify-center text-3xl font-bold mx-auto mb-4 shadow-lg">1</div>
      <h4 class="text-xl font-bold mb-2">Publique seu Job</h4>
      <p class="text-on-surface-variant">Descreva o que você precisa de forma clara e objetiva para atrair os melhores profissionais.</p>
    </div>
    <div class="text-center relative z-10">
      <div class="w-20 h-20 rounded-full bg-secondary-container text-on-secondary-container flex items-center justify-center text-3xl font-bold mx-auto mb-4 shadow-lg">2</div>
      <h4 class="text-xl font-bold mb-2">Compare Propostas</h4>
      <p class="text-on-surface-variant">Analise portfólios, avaliações e orçamentos de profissionais interessados no seu projeto.</p>
    </div>
    <div class="text-center relative z-10">
      <div class="w-20 h-20 rounded-full bg-primary text-white flex items-center justify-center text-3xl font-bold mx-auto mb-4 shadow-lg">3</div>
      <h4 class="text-xl font-bold mb-2">Contrate e Relaxe</h4>
      <p class="text-on-surface-variant">Acompanhe o progresso e pague apenas quando estiver satisfeito com o resultado.</p>
    </div>
  </div>
</section>

<section class="py-20 px-6 md:px-10 bg-surface-container-highest">
  <div class="max-w-7xl mx-auto">
    <h2 class="text-3xl md:text-4xl font-bold text-center mb-12">Categorias Populares</h2>
    <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
      <div class="bg-white p-6 rounded-2xl text-center hover:bg-primary/5 transition cursor-pointer group"><span class="material-symbols-outlined text-primary text-5xl mb-3 group-hover:scale-110 transition">palette</span><div class="font-semibold">Design</div></div>
      <div class="bg-white p-6 rounded-2xl text-center hover:bg-primary/5 transition cursor-pointer group"><span class="material-symbols-outlined text-primary text-5xl mb-3 group-hover:scale-110 transition">code</span><div class="font-semibold">Desenvolvimento</div></div>
      <div class="bg-white p-6 rounded-2xl text-center hover:bg-primary/5 transition cursor-pointer group"><span class="material-symbols-outlined text-primary text-5xl mb-3 group-hover:scale-110 transition">campaign</span><div class="font-semibold">Marketing</div></div>
      <div class="bg-white p-6 rounded-2xl text-center hover:bg-primary/5 transition cursor-pointer group"><span class="material-symbols-outlined text-primary text-5xl mb-3 group-hover:scale-110 transition">home_repair_service</span><div class="font-semibold">Reparos</div></div>
      <div class="bg-white p-6 rounded-2xl text-center hover:bg-primary/5 transition cursor-pointer group"><span class="material-symbols-outlined text-primary text-5xl mb-3 group-hover:scale-110 transition">edit_note</span><div class="font-semibold">Escrita</div></div>
      <div class="bg-white p-6 rounded-2xl text-center hover:bg-primary/5 transition cursor-pointer group"><span class="material-symbols-outlined text-primary text-5xl mb-3 group-hover:scale-110 transition">video_camera_back</span><div class="font-semibold">Vídeo</div></div>
      <div class="bg-white p-6 rounded-2xl text-center hover:bg-primary/5 transition cursor-pointer group"><span class="material-symbols-outlined text-primary text-5xl mb-3 group-hover:scale-110 transition">cleaning_services</span><div class="font-semibold">Limpeza</div></div>
      <div class="bg-white p-6 rounded-2xl text-center hover:bg-primary/5 transition cursor-pointer group"><span class="material-symbols-outlined text-primary text-5xl mb-3 group-hover:scale-110 transition">psychology</span><div class="font-semibold">Consultoria</div></div>
    </div>
  </div>
</section>

<footer class="bg-surface-container-lowest border-t py-8 px-6 md:px-10">
  <div class="max-w-7xl mx-auto flex flex-col md:flex-row justify-between items-center gap-4">
    <div class="text-xl font-bold text-primary">🔧 Faz pra mim</div>
    <div class="flex gap-6 text-sm text-on-surface-variant"><a href="#" class="hover:text-primary">Termos de Uso</a><a href="#" class="hover:text-primary">Privacidade</a><a href="#" class="hover:text-primary">Ajuda</a><a href="#" class="hover:text-primary">API</a></div>
    <div class="text-sm text-on-surface-variant">© 2024 Faz pra mim. Todos os direitos reservados.</div>
  </div>
</footer>

<script>
  document.querySelectorAll('section > div, section > div:first-child').forEach(el => {
    if(el.classList) {
      el.classList.add('transition-all', 'duration-700', 'opacity-0', 'translate-y-8');
      new IntersectionObserver((entries) => {
        entries.forEach(entry => { if(entry.isIntersecting) { entry.target.classList.add('opacity-100', 'translate-y-0'); entry.target.classList.remove('opacity-0', 'translate-y-8'); } });
      }, {threshold:0.1}).observe(el);
    }
  });
</script>
</body>
</html>
EOF
echo "✅ Landing Page criada!"
echo ""

# ============================================
# 2. DASHBOARD
# ============================================
echo "📄 Criando Dashboard..."
cat > src/views/dashboard.html << 'EOF'
<!DOCTYPE html>
<html class="light" lang="pt-BR">
<head>
<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>Dashboard | Faz pra mim</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
<script>
tailwind.config = {
  darkMode: "class",
  theme: {
    extend: {
      colors: {
        primary: "#630ed4",
        "primary-container": "#7c3aed",
        "on-primary-container": "#ede0ff",
        secondary: "#795900",
        background: "#fef7ff",
        "surface-container-low": "#f9f1ff",
        "outline-variant": "#ccc3d8",
        "on-surface": "#1d1a24",
        "on-surface-variant": "#4a4455",
      }
    }
  }
}
</script>
<style>
.material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; }
.chart-bar { transition: height 0.8s ease-out; }
</style>
</head>
<body class="bg-background font-inter">

<header class="fixed top-0 w-full bg-white/80 backdrop-blur-md border-b z-50">
  <div class="flex justify-between items-center px-6 md:px-10 h-16 max-w-7xl mx-auto">
    <div class="text-xl font-bold text-primary">🔧 Faz pra mim</div>
    <div class="flex items-center gap-4">
      <button class="relative p-2 text-gray-500"><span class="material-symbols-outlined">notifications</span><span class="absolute top-1 right-1 w-2 h-2 bg-red-500 rounded-full"></span></button>
      <div class="flex items-center gap-3">
        <span class="text-sm text-on-surface-variant hidden md:block">Carlos Silva</span>
        <div class="w-8 h-8 rounded-full bg-primary flex items-center justify-center text-white text-sm font-bold">CS</div>
      </div>
    </div>
  </div>
</header>

<aside class="fixed left-0 top-16 h-full w-64 bg-surface-container-low border-r hidden md:flex flex-col">
  <div class="p-6"><h2 class="text-xl font-bold text-primary">Dashboard</h2><p class="text-sm text-on-surface-variant">Painel do Profissional</p></div>
  <nav class="flex-1 px-4 space-y-1">
    <a href="#" class="flex items-center gap-3 px-4 py-3 bg-primary-container text-on-primary-container rounded-lg transition"><span class="material-symbols-outlined">dashboard</span><span>Dashboard</span></a>
    <a href="/perfil" class="flex items-center gap-3 px-4 py-3 text-on-surface-variant hover:bg-surface rounded-lg transition"><span class="material-symbols-outlined">person</span><span>Meu Perfil</span></a>
    <a href="#" class="flex items-center gap-3 px-4 py-3 text-on-surface-variant hover:bg-surface rounded-lg transition"><span class="material-symbols-outlined">work</span><span>Projetos</span></a>
    <a href="#" class="flex items-center gap-3 px-4 py-3 text-on-surface-variant hover:bg-surface rounded-lg transition"><span class="material-symbols-outlined">payments</span><span>Financeiro</span></a>
    <a href="#" class="flex items-center gap-3 px-4 py-3 text-on-surface-variant hover:bg-surface rounded-lg transition"><span class="material-symbols-outlined">analytics</span><span>Analytics</span></a>
  </nav>
  <div class="p-4 border-t mt-auto"><button class="w-full bg-primary text-white py-3 rounded-xl font-bold flex items-center justify-center gap-2 hover:opacity-90 transition"><span class="material-symbols-outlined">add</span> Novo Serviço</button></div>
</aside>

<main class="md:ml-64 pt-24 px-4 md:px-8 pb-20">
  <div class="max-w-6xl mx-auto space-y-6">
    <div><h1 class="text-3xl md:text-4xl font-bold">Bem-vindo de volta, Carlos!</h1><p class="text-lg text-on-surface-variant">Aqui está o resumo do seu desempenho esta semana</p></div>
    
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
      <div class="bg-white p-5 rounded-xl shadow-sm border hover:shadow-md transition"><div class="flex justify-between mb-3"><span class="material-symbols-outlined text-primary bg-purple-50 p-2 rounded-lg">visibility</span><span class="text-xs text-green-600 bg-green-50 px-2 py-1 rounded-full">+12%</span></div><p class="text-sm text-on-surface-variant">Visualizações</p><h3 class="text-2xl font-bold">1,240</h3></div>
      <div class="bg-white p-5 rounded-xl shadow-sm border hover:shadow-md transition"><div class="flex justify-between mb-3"><span class="material-symbols-outlined text-primary bg-purple-50 p-2 rounded-lg">contact_mail</span><span class="text-xs text-green-600 bg-green-50 px-2 py-1 rounded-full">+5%</span></div><p class="text-sm text-on-surface-variant">Contatos</p><h3 class="text-2xl font-bold">45</h3></div>
      <div class="bg-white p-5 rounded-xl shadow-sm border hover:shadow-md transition"><div class="flex justify-between mb-3"><span class="material-symbols-outlined text-secondary bg-yellow-50 p-2 rounded-lg">star</span><span class="text-xs text-gray-500">124 reviews</span></div><p class="text-sm text-on-surface-variant">Avaliação</p><h3 class="text-2xl font-bold">4.9</h3></div>
      <div class="bg-white p-5 rounded-xl shadow-sm border hover:shadow-md transition"><div class="flex justify-between mb-3"><span class="material-symbols-outlined text-orange-600 bg-orange-50 p-2 rounded-lg">ads_click</span><span class="text-xs text-gray-500">vs 15%</span></div><p class="text-sm text-on-surface-variant">Conversão</p><h3 class="text-2xl font-bold">18%</h3></div>
    </div>

    <div class="bg-white p-6 rounded-xl shadow-sm border">
      <div class="flex justify-between items-center mb-6"><div><h3 class="text-lg font-semibold">Visualizações de Perfil</h3><p class="text-sm text-on-surface-variant">Últimos 7 dias</p></div><select class="text-sm border rounded-lg px-3 py-1"><option>Semana atual</option><option>Semana anterior</option></select></div>
      <div class="relative h-64 flex items-end justify-between gap-3 px-2 border-b" id="chartContainer">
        <div class="text-center text-gray-500 w-full py-4">Carregando gráfico...</div>
      </div>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
      <div class="bg-white p-6 rounded-xl shadow-sm border"><h3 class="text-lg font-semibold mb-4">Contatos Recentes</h3><div class="space-y-3"><div class="flex items-center justify-between p-3 bg-gray-50 rounded-lg"><div class="flex items-center gap-3"><div class="w-10 h-10 rounded-full bg-purple-100 flex items-center justify-center text-purple-700 font-bold">MS</div><div><p class="font-semibold">Mariana Souza</p><p class="text-sm text-gray-500">Desenvolvimento Web</p></div></div><button class="bg-primary text-white px-3 py-1.5 rounded-lg text-sm">Responder</button></div><div class="flex items-center justify-between p-3 bg-gray-50 rounded-lg"><div class="flex items-center gap-3"><div class="w-10 h-10 rounded-full bg-blue-100 flex items-center justify-center text-blue-700 font-bold">TF</div><div><p class="font-semibold">TechFlow Solutions</p><p class="text-sm text-gray-500">UI/UX Design</p></div></div><button class="bg-primary text-white px-3 py-1.5 rounded-lg text-sm">Responder</button></div><div class="flex items-center justify-between p-3 bg-gray-50 rounded-lg"><div class="flex items-center gap-3"><div class="w-10 h-10 rounded-full bg-yellow-100 flex items-center justify-center text-yellow-700 font-bold">JP</div><div><p class="font-semibold">João Pedro</p><p class="text-sm text-gray-500">Consultoria</p></div></div><button class="bg-primary text-white px-3 py-1.5 rounded-lg text-sm">Responder</button></div></div></div>
      <div class="bg-white p-6 rounded-xl shadow-sm border"><h3 class="text-lg font-semibold mb-4">Avaliações Recentes</h3><div class="space-y-4"><div><div class="flex justify-between"><span class="font-semibold">Ana Beatriz</span><div class="flex text-yellow-500">★★★★★</div></div><p class="text-sm text-gray-600 mt-1">"Excelente profissional! Entregou antes do prazo com qualidade acima da média."</p></div><div><div class="flex justify-between"><span class="font-semibold">Roberto Silva</span><div class="flex text-yellow-500">★★★★★</div></div><p class="text-sm text-gray-600 mt-1">"Muito atencioso nos detalhes técnicos. Recomendo muito!"</p></div></div></div>
    </div>

    <div class="relative overflow-hidden bg-primary-container rounded-2xl p-6 md:p-8 text-white">
      <div class="relative z-10"><h2 class="text-xl md:text-2xl font-bold mb-2">Quer alcançar mais clientes?</h2><p class="mb-4 opacity-90">Profissionais que impulsionam seu perfil têm até 3x mais visualizações e contatos diretos na primeira semana.</p><button class="bg-secondary-container text-on-secondary-container px-6 py-3 rounded-xl font-semibold hover:scale-105 transition flex items-center gap-2"><span class="material-symbols-outlined">rocket_launch</span> Impulsionar Perfil</button></div>
      <div class="absolute -right-10 -bottom-10 w-40 h-40 bg-white/10 rounded-full blur-2xl"></div>
      <div class="absolute -left-20 -top-20 w-64 h-64 bg-secondary-container/20 rounded-full blur-3xl"></div>
    </div>
  </div>
</main>

<footer class="w-full py-6 bg-surface-container-highest border-t flex flex-col md:flex-row justify-between items-center px-6 md:px-10 md:ml-64 md:max-w-[calc(100%-256px)]">
  <div class="text-sm text-on-surface-variant">© 2024 Faz pra mim. Todos os direitos reservados.</div>
  <div class="flex gap-4 text-sm"><a href="#" class="text-on-surface-variant hover:text-primary">Privacidade</a><a href="#" class="text-on-surface-variant hover:text-primary">Termos</a><a href="#" class="text-on-surface-variant hover:text-primary">Ajuda</a></div>
</footer>

<nav class="md:hidden fixed bottom-0 left-0 right-0 bg-white border-t flex justify-around items-center h-16 z-50">
  <a href="#" class="flex flex-col items-center text-primary"><span class="material-symbols-outlined">dashboard</span><span class="text-[10px] font-bold">Início</span></a>
  <a href="/perfil" class="flex flex-col items-center text-gray-500"><span class="material-symbols-outlined">person</span><span class="text-[10px]">Perfil</span></a>
  <a href="#" class="flex flex-col items-center text-gray-500"><span class="material-symbols-outlined">work</span><span class="text-[10px]">Projetos</span></a>
</nav>

<script>
  const chartData = [45, 65, 55, 85, 100, 40, 35];
  const days = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];
  document.getElementById('chartContainer').innerHTML = days.map((day, i) => `<div class="flex flex-col items-center flex-1 gap-2"><div class="w-full bg-purple-200 hover:bg-purple-300 transition-all chart-bar rounded-t-lg" style="height: ${chartData[i]}%; min-height: 4px;"></div><span class="text-xs text-on-surface-variant">${day}</span></div>`).join('');
</script>
</body>
</html>
EOF
echo "✅ Dashboard criado!"
echo ""

# ============================================
# 3. PERFIL PROFISSIONAL
# ============================================
echo "📄 Criando Perfil Profissional..."
cat > src/views/perfil.html << 'EOF'
<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>Perfil | Faz pra mim</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
<script>
tailwind.config = {
  darkMode: "class",
  theme: {
    extend: {
      colors: {
        primary: "#630ed4", "primary-container": "#7c3aed", "on-primary-container": "#ede0ff",
        secondary: "#795900", "secondary-container": "#ffc329", background: "#fef7ff",
        "surface-container-low": "#f9f1ff", "outline-variant": "#ccc3d8", "on-surface": "#1d1a24",
        "on-surface-variant": "#4a4455",
      }
    }
  }
}
</script>
<style>
.tab-active { border-bottom: 2px solid #630ed4; color: #630ed4; font-weight: 600; }
.profile-card:hover { transform: translateY(-4px); box-shadow: 0 10px 30px rgba(124, 58, 237, 0.1); }
.material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; }
</style>
</head>
<body class="bg-background">

<nav class="fixed top-0 w-full z-50 bg-surface/80 backdrop-blur-md shadow-sm">
  <div class="flex justify-between items-center px-6 md:px-10 h-16 max-w-7xl mx-auto">
    <div class="text-xl font-bold text-primary cursor-pointer" onclick="window.location.href='/'">🔧 Faz pra mim</div>
    <div class="hidden md:flex gap-6"><a href="/" class="text-on-surface-variant hover:text-primary">Início</a><a href="/buscar" class="text-on-surface-variant hover:text-primary">Freelancers</a><a href="#" class="text-on-surface-variant hover:text-primary">Categorias</a></div>
    <div class="flex gap-3"><button onclick="window.location.href='/dashboard'" class="text-primary px-4 py-2 hover:bg-primary/10 rounded-lg">Dashboard</button><button class="bg-primary text-white px-5 py-2 rounded-lg hover:opacity-90">Sair</button></div>
  </div>
</nav>

<main class="mt-24 mb-16 max-w-7xl mx-auto px-4 md:px-10">
  <header class="bg-white rounded-xl p-6 shadow-sm border mb-6">
    <div class="flex flex-col md:flex-row items-center gap-6">
      <div class="relative"><div class="w-32 h-32 md:w-40 md:h-40 rounded-full bg-gradient-to-br from-primary to-purple-400 flex items-center justify-center text-white text-4xl font-bold shadow-lg">CS</div><div class="absolute bottom-2 right-2 bg-primary text-white p-1 rounded-full"><span class="material-symbols-outlined text-sm">verified</span></div></div>
      <div class="flex-1 text-center md:text-left"><div class="flex flex-col md:flex-row md:items-center gap-2 mb-2"><h1 class="text-3xl md:text-4xl font-bold">Carlos Silva</h1><span class="bg-secondary-container text-on-secondary-container px-3 py-1 rounded-full text-sm font-semibold self-center">TOP RATED</span></div><p class="text-xl text-on-surface-variant mb-2">Desenvolvedor Full Stack</p><div class="flex flex-wrap justify-center md:justify-start gap-3"><span class="flex items-center gap-1 text-secondary"><span class="material-symbols-outlined">star</span> <b>4.9</b> <span class="text-sm">(124 avaliações)</span></span><span class="text-gray-400">•</span><span class="flex items-center gap-1"><span class="material-symbols-outlined text-sm">location_on</span> São Paulo, SP</span><span class="flex items-center gap-1"><span class="material-symbols-outlined text-sm">schedule</span> Responde em ~2h</span></div>
      <div class="flex gap-3 mt-4 justify-center md:justify-start"><button class="bg-primary text-white px-6 py-2 rounded-lg flex items-center gap-2 hover:bg-primary/90 transition"><span class="material-symbols-outlined text-sm">mail</span> Contato</button><button class="border border-gray-300 p-2 rounded-lg hover:bg-gray-50 transition"><span class="material-symbols-outlined text-sm">share</span></button></div></div>
    </div>
  </header>

  <div class="grid grid-cols-1 lg:grid-cols-12 gap-6">
    <div class="lg:col-span-8">
      <div class="bg-white rounded-xl shadow-sm overflow-hidden border">
        <div class="flex border-b px-4"><button class="px-4 py-3 tab-active transition" onclick="switchTab('about')">Sobre</button><button class="px-4 py-3 text-on-surface-variant hover:text-primary transition" onclick="switchTab('portfolio')">Portfólio</button><button class="px-4 py-3 text-on-surface-variant hover:text-primary transition" onclick="switchTab('reviews')">Avaliações</button><button class="px-4 py-3 text-on-surface-variant hover:text-primary transition" onclick="switchTab('contact')">Contato</button></div>
        <div class="p-6">
          <div id="content-about"><h3 class="text-xl font-bold mb-3">Resumo Profissional</h3><p class="text-on-surface-variant mb-6 leading-relaxed">Com mais de 8 anos de experiência, foco em criar soluções web robustas e escaláveis. Especialista em ecossistemas JavaScript (Node.js, React, Next.js) e arquiteturas baseadas em nuvem. Meu objetivo é transformar ideias complexas em interfaces intuitivas e eficientes.</p><h3 class="text-xl font-bold mb-3">Habilidades Técnicas</h3><div class="flex flex-wrap gap-2"><span class="bg-gray-100 px-4 py-2 rounded-lg text-sm">React / Next.js</span><span class="bg-gray-100 px-4 py-2 rounded-lg text-sm">Node.js / Express</span><span class="bg-gray-100 px-4 py-2 rounded-lg text-sm">TypeScript</span><span class="bg-gray-100 px-4 py-2 rounded-lg text-sm">Tailwind CSS</span><span class="bg-gray-100 px-4 py-2 rounded-lg text-sm">PostgreSQL</span><span class="bg-gray-100 px-4 py-2 rounded-lg text-sm">AWS / Docker</span></div></div>
          <div id="content-portfolio" class="hidden"><div class="grid md:grid-cols-2 gap-4"><div class="border rounded-lg overflow-hidden profile-card"><img src="https://images.pexels.com/photos/1779487/pexels-photo-1779487.jpeg?auto=compress&cs=tinysrgb&w=400" class="w-full h-40 object-cover"/><div class="p-3"><h4 class="font-bold">FinTech Dashboard</h4><p class="text-sm text-gray-500">SaaS Platform for internal audits</p></div></div><div class="border rounded-lg overflow-hidden profile-card"><img src="https://images.pexels.com/photos/230544/pexels-photo-230544.jpeg?auto=compress&cs=tinysrgb&w=400" class="w-full h-40 object-cover"/><div class="p-3"><h4 class="font-bold">EcoCommerce</h4><p class="text-sm text-gray-500">Full-stack marketplace</p></div></div></div></div>
          <div id="content-reviews" class="hidden"><div class="flex items-center gap-6 mb-6 p-4 bg-gray-50 rounded-xl"><div class="text-center"><div class="text-4xl font-bold text-primary">4.9</div><div class="flex text-yellow-500 justify-center">★★★★★</div><div class="text-sm text-gray-500">124 avaliações</div></div><div class="flex-1"><div class="flex items-center gap-2"><span class="text-sm w-6">5★</span><div class="flex-1 h-2 bg-gray-200 rounded-full"><div class="h-full bg-yellow-500 rounded-full" style="width: 92%"></div></div><span class="text-sm">92%</span></div><div class="flex items-center gap-2 mt-1"><span class="text-sm w-6">4★</span><div class="flex-1 h-2 bg-gray-200 rounded-full"><div class="h-full bg-yellow-500 rounded-full" style="width: 6%"></div></div><span class="text-sm">6%</span></div></div></div><div class="space-y-4"><div class="border-b pb-4"><div class="flex justify-between mb-1"><span class="font-bold">Mariana L.</span><div class="flex text-yellow-500 text-sm">★★★★★</div><span class="text-xs text-gray-400">2 dias atrás</span></div><p class="text-gray-600 text-sm">"Excelente profissional! Entregou antes do prazo com qualidade impecável."</p></div><div class="border-b pb-4"><div class="flex justify-between mb-1"><span class="font-bold">Ricardo T.</span><div class="flex text-yellow-500 text-sm">★★★★★</div><span class="text-xs text-gray-400">1 semana atrás</span></div><p class="text-gray-600 text-sm">"Muito atencioso e técnico. Resolveu problemas que outros não conseguiram."</p></div></div></div>
          <div id="content-contact" class="hidden"><div class="space-y-3"><div class="flex items-center gap-4 p-4 bg-gray-50 rounded-lg"><div class="w-12 h-12 bg-primary/10 rounded-full flex items-center justify-center"><span class="material-symbols-outlined text-primary">alternate_email</span></div><div><div class="text-xs text-gray-500">Email</div><div class="font-semibold">carlos.silva@fazpramim.com</div></div></div><div class="flex items-center gap-4 p-4 bg-gray-50 rounded-lg"><div class="w-12 h-12 bg-blue-100 rounded-full flex items-center justify-center"><span class="material-symbols-outlined text-blue-600">group</span></div><div><div class="text-xs text-gray-500">LinkedIn</div><div class="font-semibold">/in/carlossilvadev</div></div></div><div class="flex items-center gap-4 p-4 bg-gray-50 rounded-lg"><div class="w-12 h-12 bg-gray-800/10 rounded-full flex items-center justify-center"><span class="material-symbols-outlined text-gray-800">code</span></div><div><div class="text-xs text-gray-500">GitHub</div><div class="font-semibold">@csilva-dev</div></div></div></div></div>
        </div>
      </div>
    </div>
    <aside class="lg:col-span-4 space-y-4">
      <div class="bg-white p-6 rounded-xl shadow-sm border"><div class="text-sm text-gray-500 uppercase tracking-wider">Valor/hora</div><div class="text-4xl font-bold text-primary mt-1">R$ 150<span class="text-lg text-gray-500">/h</span></div><div class="flex items-center gap-2 mt-4 p-3 bg-green-50 text-green-700 rounded-lg"><span class="material-symbols-outlined text-sm">check_circle</span><span class="text-sm font-medium">Disponível para novos projetos</span></div><button class="w-full mt-4 bg-primary text-white py-3 rounded-lg font-semibold hover:bg-primary/90 transition">Contratar Agora</button><button class="w-full mt-2 border border-primary text-primary py-3 rounded-lg font-semibold hover:bg-primary/5 transition">Solicitar Orçamento</button></div>
      <div class="bg-white p-6 rounded-xl shadow-sm border"><h4 class="font-bold mb-3 flex items-center gap-2"><span class="material-symbols-outlined text-primary">verified_user</span> Certificações</h4><ul class="space-y-2"><li class="flex items-center gap-2 text-sm"><span class="material-symbols-outlined text-secondary text-sm">verified</span> AWS Solutions Architect</li><li class="flex items-center gap-2 text-sm"><span class="material-symbols-outlined text-secondary text-sm">verified</span> Google Cloud Professional</li><li class="flex items-center gap-2 text-sm"><span class="material-symbols-outlined text-secondary text-sm">verified</span> Scrum Master Certified</li></ul></div>
    </aside>
  </div>
</main>

<script>
function switchTab(tab) {
  const tabs = ['about', 'portfolio', 'reviews', 'contact'];
  tabs.forEach(t => document.getElementById(`content-${t}`).classList.add('hidden'));
  document.getElementById(`content-${tab}`).classList.remove('hidden');
  const btns = document.querySelectorAll('[onclick^="switchTab"]');
  btns.forEach(btn => { btn.classList.remove('tab-active'); btn.classList.add('text-on-surface-variant'); });
  event.target.classList.add('tab-active'); event.target.classList.remove('text-on-surface-variant');
}
</script>
</body>
</html>
EOF
echo "✅ Perfil Profissional criado!"
echo ""

# ============================================
# 4. PÁGINA DE BUSCA
# ============================================
echo "📄 Criando Página de Busca..."
cat > src/views/buscar.html << 'EOF'
<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>Buscar Profissionais | Faz pra mim</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
<script>
tailwind.config = {
  darkMode: "class",
  theme: {
    extend: {
      colors: {
        primary: "#630ed4", "primary-container": "#7c3aed", background: "#fef7ff",
        "on-surface": "#1d1a24", "on-surface-variant": "#4a4455",
      }
    }
  }
}
</script>
</head>
<body class="bg-background">

<header class="fixed top-0 w-full bg-white shadow-sm z-50">
  <div class="flex justify-between items-center px-6 h-16 max-w-7xl mx-auto">
    <div class="text-xl font-bold text-primary cursor-pointer" onclick="window.location.href='/'">🔧 Faz pra mim</div>
    <div class="flex gap-3"><button class="text-primary px-4 py-2">Entrar</button><button class="bg-primary text-white px-5 py-2 rounded-lg">Profissional</button></div>
  </div>
</header>

<main class="pt-20 pb-12 px-4 md:px-10">
  <div class="max-w-7xl mx-auto">
    <div class="bg-gradient-to-r from-purple-50 to-white rounded-2xl p-6 mb-8">
      <h1 class="text-2xl md:text-3xl font-bold mb-4">Encontre o profissional ideal para seu projeto</h1>
      <div class="flex flex-col md:flex-row gap-3"><input type="text" id="searchInput" placeholder="Ex: desenvolvedor, designer, eletricista..." class="flex-1 p-3 border rounded-xl"><select id="categoryFilter" class="p-3 border rounded-xl w-full md:w-48"><option value="all">Todas categorias</option><option value="Serviços Digitais">💻 Serviços Digitais</option><option value="Serviços Presenciais">🔧 Serviços Presenciais</option></select><button onclick="searchFreelancers()" class="bg-primary text-white px-8 py-3 rounded-xl font-semibold">Buscar</button></div>
    </div>
    <div id="results" class="grid md:grid-cols-2 lg:grid-cols-3 gap-6"><div class="text-center py-12 text-gray-500">Digite sua busca acima para encontrar profissionais</div></div>
  </div>
</main>

<script>
const API_URL = 'http://localhost:3000/api';
async function searchFreelancers() {
  const query = document.getElementById('searchInput').value;
  const category = document.getElementById('categoryFilter').value;
  const res = await fetch(`${API_URL}/freelancers?query=${encodeURIComponent(query)}&category=${category}`);
  const data = await res.json();
  const container = document.getElementById('results');
  if(data.length === 0) { container.innerHTML = '<div class="text-center py-12 text-gray-500 col-span-full">Nenhum profissional encontrado</div>'; return; }
  container.innerHTML = data.map(f => `<div class="bg-white rounded-xl p-5 shadow-sm border hover:shadow-md transition"><div class="flex items-center gap-3 mb-3"><div class="w-12 h-12 rounded-full bg-primary text-white flex items-center justify-center font-bold text-lg">${f.name?.charAt(0) || '?'}</div><div><h3 class="font-bold">${f.name}</h3><p class="text-sm text-gray-500">${f.title}</p></div></div><div class="flex items-center gap-2 text-sm mb-2"><span class="text-yellow-500">★ ${f.rating || 0}</span><span>(${f.review_count || 0} avaliações)</span></div><p class="text-sm text-gray-600 mb-3">${f.description?.substring(0, 100) || ''}...</p><div class="flex flex-wrap gap-2 mb-3"><span class="text-xs bg-gray-100 px-2 py-1 rounded">${f.work_type === 'REMOTO' ? '💻 Remoto' : '📍 Presencial'}</span>${f.city ? `<span class="text-xs bg-gray-100 px-2 py-1 rounded">📍 ${f.city}</span>` : ''}</div><div class="flex justify-between items-center"><span class="text-xl font-bold text-primary">R$ ${f.price_hourly || 0}/h</span><button class="bg-primary text-white px-4 py-2 rounded-lg text-sm hover:opacity-90">Contatar</button></div></div>`).join('');
}
</script>
</body>
</html>
EOF
echo "✅ Página de Busca criada!"
echo ""

# ============================================
# 5. SERVER.JS
# ============================================
echo "📄 Criando Server.js..."
cat > server.js << 'EOF'
const express = require('express');
const cors = require('cors');
const path = require('path');
const { openDb } = require('./src/database/database.js');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());
app.use(express.static('src/public'));

// Rotas das páginas
app.get('/', (req, res) => res.sendFile(path.join(__dirname, 'src/views/index.html')));
app.get('/dashboard', (req, res) => res.sendFile(path.join(__dirname, 'src/views/dashboard.html')));
app.get('/perfil', (req, res) => res.sendFile(path.join(__dirname, 'src/views/perfil.html')));
app.get('/buscar', (req, res) => res.sendFile(path.join(__dirname, 'src/views/buscar.html')));

// API: Buscar freelancers
app.get('/api/freelancers', async (req, res) => {
  const db = await openDb();
  const { category, work_type, city, query } = req.query;
  let sql = 'SELECT * FROM freelancers WHERE 1=1';
  let params = [];
  if (category && category !== 'all') { sql += ' AND category = ?'; params.push(category); }
  if (work_type && work_type !== 'all') { sql += ' AND work_type IN (?, "AMBOS")'; params.push(work_type); }
  if (city && city !== '') { sql += ' AND city = ?'; params.push(city); }
  if (query) { sql += ' AND (name LIKE ? OR title LIKE ? OR description LIKE ?)'; const like = `%${query}%`; params.push(like, like, like); }
  sql += ' ORDER BY rating DESC LIMIT 50';
  const freelancers = await db.all(sql, params);
  await db.close();
  res.json(freelancers);
});

// API: Buscar um freelancer
app.get('/api/freelancers/:id', async (req, res) => {
  const db = await openDb();
  const freelancer = await db.get('SELECT * FROM freelancers WHERE id = ?', [req.params.id]);
  if (freelancer) {
    const reviews = await db.all('SELECT * FROM reviews WHERE freelancer_id = ? ORDER BY created_at DESC', [req.params.id]);
    freelancer.reviews = reviews;
  }
  await db.close();
  res.json(freelancer);
});

// API: Criar freelancer
app.post('/api/freelancers', async (req, res) => {
  const db = await openDb();
  const { name, email, phone, title, description, category, work_type, city, price_hourly } = req.body;
  try {
    const result = await db.run(`INSERT INTO freelancers (name, email, phone, title, description, category, work_type, city, price_hourly) VALUES (?,?,?,?,?,?,?,?,?)`, [name, email, phone, title, description, category, work_type, city, price_hourly]);
    await db.close();
    res.json({ id: result.lastID, message: 'Cadastro realizado com sucesso!' });
  } catch(error) { await db.close(); res.status(400).json({ error: 'Erro ao cadastrar' }); }
});

// API: Criar projeto
app.post('/api/projects', async (req, res) => {
  const db = await openDb();
  const { title, description, category, work_type, city, budget, client_name, client_email } = req.body;
  const result = await db.run(`INSERT INTO projects (title, description, category, work_type, city, budget, client_name, client_email) VALUES (?,?,?,?,?,?,?,?)`, [title, description, category, work_type, city, budget, client_name, client_email]);
  await db.close();
  res.json({ id: result.lastID, message: 'Projeto criado com sucesso!' });
});

// API: Listar projetos
app.get('/api/projects', async (req, res) => {
  const db = await openDb();
  const projects = await db.all('SELECT * FROM projects WHERE status = "open" ORDER BY created_at DESC LIMIT 20');
  await db.close();
  res.json(projects);
});

// API: Estatísticas
app.get('/api/stats', async (req, res) => {
  const db = await openDb();
  const stats = await db.get(`SELECT (SELECT COUNT(*) FROM freelancers) as total_freelancers, (SELECT COUNT(*) FROM projects WHERE status='open') as open_projects, (SELECT COUNT(*) FROM reviews) as total_reviews`);
  await db.close();
  res.json(stats);
});

app.listen(PORT, () => {
  console.log('\n╔═══════════════════════════════════════════════════════════╗');
  console.log('║                                                           ║');
  console.log('║     🚀 FAZ PRA MIM - Servidor rodando! 🚀                 ║');
  console.log('║                                                           ║');
  console.log('╠═══════════════════════════════════════════════════════════╣');
  console.log(`║                                                           ║`);
  console.log(`║     📍 http://localhost:${PORT}                             ║`);
  console.log(`║     📊 Dashboard: http://localhost:${PORT}/dashboard        ║`);
  console.log(`║     👤 Perfil: http://localhost:${PORT}/perfil              ║`);
  console.log(`║     🔍 Buscar: http://localhost:${PORT}/buscar              ║`);
  console.log(`║                                                           ║`);
  console.log('╚═══════════════════════════════════════════════════════════╝\n');
});
EOF
echo "✅ Server.js criado!"
echo ""

# ============================================
# 6. DATABASE
# ============================================
echo "📄 Criando Database..."
cat > src/database/database.js << 'EOF'
const sqlite3 = require('sqlite3');
const { open } = require('sqlite');
const path = require('path');

async function openDb() {
  return open({
    filename: path.join(__dirname, '../../fazpramim.db'),
    driver: sqlite3.Database
  });
}

module.exports = { openDb };
EOF

cat > src/database/init-db.js << 'EOF'
const { openDb } = require('./database.js');

async function initDatabase() {
  const db = await openDb();
  
  // Tabela de freelancers
  await db.exec(`
    CREATE TABLE IF NOT EXISTS freelancers (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      email TEXT UNIQUE,
      phone TEXT,
      title TEXT,
      description TEXT,
      category TEXT,
      work_type TEXT DEFAULT 'AMBOS',
      city TEXT,
      price_hourly REAL,
      rating REAL DEFAULT 0,
      review_count INTEGER DEFAULT 0,
      is_verified INTEGER DEFAULT 0,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    )
  `);
  
  // Tabela de projetos
  await db.exec(`
    CREATE TABLE IF NOT EXISTS projects (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      description TEXT,
      category TEXT,
      work_type TEXT,
      city TEXT,
      budget REAL,
      client_name TEXT,
      client_email TEXT,
      status TEXT DEFAULT 'open',
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    )
  `);
  
  // Tabela de avaliações
  await db.exec(`
    CREATE TABLE IF NOT EXISTS reviews (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      freelancer_id INTEGER,
      client_name TEXT,
      rating INTEGER,
      comment TEXT,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (freelancer_id) REFERENCES freelancers(id)
    )
  `);
  
  // Verificar se já tem dados
  const count = await db.get('SELECT COUNT(*) as total FROM freelancers');
  
  if (count.total === 0) {
    console.log('📦 Inserindo dados de exemplo...');
    
    await db.run(`
      INSERT INTO freelancers (name, email, phone, title, description, category, work_type, city, price_hourly, rating, review_count, is_verified) VALUES 
      ('Ana Silva', 'ana@exemplo.com', '(11) 99999-1111', 'Desenvolvedora Full Stack', 'Crio sites e sistemas sob medida para sua empresa com React, Node.js e Python. Entregas rápidas e código de qualidade.', 'Serviços Digitais', 'REMOTO', 'São Paulo', 85, 4.9, 42, 1),
      ('Carlos Santos', 'carlos@exemplo.com', '(11) 99999-2222', 'Eletricista Residencial', 'Instalações elétricas, reparos, manutenção e laudos técnicos. Atendimento 24h para emergências.', 'Serviços Presenciais', 'PRESENCIAL', 'São Paulo', 65, 4.8, 28, 1),
      ('Mariana Costa', 'mariana@exemplo.com', '(11) 99999-3333', 'Designer Gráfica', 'Identidade visual, logos, artes para redes sociais e materiais impressos. Crio marcas que se destacam.', 'Serviços Digitais', 'REMOTO', 'Rio de Janeiro', 70, 4.9, 35, 1),
      ('José Oliveira', 'jose@exemplo.com', '(11) 99999-4444', 'Encanador', 'Desentupimento, instalação e reparos hidráulicos. Serviço rápido e garantido.', 'Serviços Presenciais', 'PRESENCIAL', 'São Paulo', 60, 4.7, 19, 0),
      ('Fernanda Lima', 'fernanda@exemplo.com', '(11) 99999-5555', 'Social Media', 'Gerencio redes sociais, crio conteúdo estratégico e aumento seu engajamento. Resultados mensuráveis.', 'Serviços Digitais', 'REMOTO', 'Belo Horizonte', 55, 4.8, 31, 1),
      ('Roberto Alves', 'roberto@exemplo.com', '(11) 99999-6666', 'Personal Trainer', 'Treinos personalizados na sua casa, academia ou online. Foco em resultados e saúde.', 'Profissionais Especializados', 'AMBOS', 'São Paulo', 90, 4.9, 52, 1),
      ('Carla Souza', 'carla@exemplo.com', '(11) 99999-7777', 'Diarista', 'Limpeza e organização residencial e comercial. Materiais inclusos e equipe treinada.', 'Serviços Presenciais', 'PRESENCIAL', 'São Paulo', 40, 4.6, 15, 0),
      ('Ricardo Mendes', 'ricardo@exemplo.com', '(11) 99999-8888', 'Tradutor', 'Tradução inglês-português para documentos, sites e materiais técnicos. Precisão e rapidez.', 'Serviços Digitais', 'REMOTO', 'Curitiba', 45, 4.9, 23, 1),
      ('Patrícia Rocha', 'patricia@exemplo.com', '(11) 99999-9999', 'Advogada', 'Consultoria jurídica empresarial e para pessoas físicas. Direito civil e trabalhista.', 'Profissionais Especializados', 'REMOTO', 'São Paulo', 150, 4.9, 38, 1),
      ('Lucas Andrade', 'lucas@exemplo.com', '(11) 98888-1111', 'Jardineiro', 'Cuidado de jardins, poda, paisagismo e manutenção de áreas verdes.', 'Serviços Presenciais', 'PRESENCIAL', 'São Paulo', 50, 4.7, 12, 0)
    `);
    
    await db.run(`
      INSERT INTO projects (title, description, category, work_type, city, budget, client_name, client_email) VALUES 
      ('Preciso de site para meu consultório', 'Site institucional com agendamento online e integração com WhatsApp para agendamentos', 'Serviços Digitais', 'REMOTO', NULL, 2500, 'Dr. Paulo', 'paulo@exemplo.com'),
      ('Chuveiro queimando disjuntor', 'Chuveiro elétrico está desarmando o disjuntor toda vez que liga. Precisa de avaliação urgente.', 'Serviços Presenciais', 'PRESENCIAL', 'São Paulo - Zona Sul', 150, 'Maria', 'maria@exemplo.com'),
      ('Logo para minha cafeteria', 'Preciso de um logo profissional para minha cafeteria artesanal. Estilo rústico e acolhedor.', 'Serviços Digitais', 'REMOTO', NULL, 500, 'João', 'joao@exemplo.com')
    `);
    
    await db.run(`
      INSERT INTO reviews (freelancer_id, client_name, rating, comment) VALUES 
      (1, 'Ana Beatriz', 5, 'Excelente profissional! Entregou antes do prazo com qualidade acima da média.'),
      (1, 'Roberto Silva', 5, 'Muito atencioso nos detalhes técnicos. Recomendo para projetos complexos.'),
      (2, 'Carla Mendes', 5, 'Designer talentosa, superou minhas expectativas. Voltarei a contratar!')
    `);
    
    // Atualizar médias
    await db.run(`UPDATE freelancers SET rating = (SELECT AVG(rating) FROM reviews WHERE freelancer_id = 1), review_count = (SELECT COUNT(*) FROM reviews WHERE freelancer_id = 1) WHERE id = 1`);
    await db.run(`UPDATE freelancers SET rating = (SELECT AVG(rating) FROM reviews WHERE freelancer_id = 2), review_count = (SELECT COUNT(*) FROM reviews WHERE freelancer_id = 2) WHERE id = 2`);
    
    console.log('✅ Dados de exemplo inseridos com sucesso!');
  } else {
    console.log(`📊 Banco já possui ${count.total} freelancers cadastrados`);
  }
  
  console.log('✅ Banco de dados inicializado!');
  await db.close();
}

initDatabase().catch(console.error);
EOF
echo "✅ Database criado!"
echo ""

# ============================================
# 7. PACKAGE.JSON
# ============================================
echo "📄 Criando Package.json..."
cat > package.json << 'EOF'
{
  "name": "faz-pra-mim",
  "version": "1.0.0",
  "description": "Plataforma de conexão entre prestadores de serviços e clientes",
  "main": "server.js",
  "scripts": {
    "start": "node server.js",
    "dev": "nodemon server.js",
    "init-db": "node src/database/init-db.js"
  },
  "keywords": ["freelancer", "servicos", "plataforma", "nodejs", "sqlite"],
  "author": "Faz pra mim",
  "license": "MIT",
  "dependencies": {
    "express": "^4.18.2",
    "sqlite3": "^5.1.6",
    "sqlite": "^5.1.1",
    "cors": "^2.8.5"
  },
  "devDependencies": {
    "nodemon": "^3.0.1"
  }
}
EOF
echo "✅ Package.json criado!"
echo ""

# ============================================
# 8. .GITIGNORE
# ============================================
echo "📄 Criando .gitignore..."
cat > .gitignore << 'EOF'
node_modules/
fazpramim.db
*.log
.env
.DS_Store
*.sqlite
*.sqlite-journal
dist/
build/
EOF
echo "✅ .gitignore criado!"
echo ""

# ============================================
# 9. README.md
# ============================================
echo "📄 Criando README.md..."
cat > README.md << 'EOF'
# 🔧 Faz pra mim

Plataforma de conexão entre prestadores de serviços (freelancers/PJ) e clientes.

## 🚀 Funcionalidades

- ✅ Landing page moderna e responsiva
- ✅ Dashboard profissional com métricas
- ✅ Perfil de profissional com portfólio
- ✅ Busca de profissionais por categoria
- ✅ Sistema de avaliações
- ✅ Banco de dados SQLite

## 📋 Pré-requisitos

- Node.js (v14 ou superior)
- npm

## 🛠️ Instalação

```bash
# Clone o repositório
git clone https://github.com/seu-usuario/faz-pra-mim.git
cd faz-pra-mim

# Instale as dependências
npm install

# Inicialize o banco de dados
npm run init-db

# Execute o servidor
npm run dev