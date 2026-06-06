const express = require('express');
const cors = require('cors');
const path = require('path');
const cookieParser = require('cookie-parser');
const { openDb } = require('./src/database/database.js');
const { authenticate, requireAuth, requireRole } = require('./src/middleware/auth.js');
const authRoutes = require('./src/routes/auth.js');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());
app.use(cookieParser());
app.use(express.static('src/public'));
app.use(authenticate);

// Rotas de autenticação
app.use(authRoutes);

// ==================== ROTAS PÚBLICAS ====================
app.get('/', (req, res) => res.sendFile(path.join(__dirname, 'src/views/index.html')));
app.get('/login', (req, res) => res.sendFile(path.join(__dirname, 'src/views/login.html')));
app.get('/buscar', (req, res) => res.sendFile(path.join(__dirname, 'src/views/buscar.html')));

// ==================== ROTAS PROTEGIDAS ====================
app.get('/dashboard', requireRole(['profissional', 'admin', 'dev']), (req, res) => 
  res.sendFile(path.join(__dirname, 'src/views/dashboard.html'))
);

app.get('/perfil', requireAuth, (req, res) => 
  res.sendFile(path.join(__dirname, 'src/views/perfil.html'))
);

// ==================== ROTAS ADMIN/DEV ====================
app.get('/admin/dev', requireRole(['dev']), (req, res) => 
  res.sendFile(path.join(__dirname, 'src/views/admin/dev.html'))
);

app.get('/admin/dashboard', requireRole(['admin', 'dev']), (req, res) => 
  res.sendFile(path.join(__dirname, 'src/views/admin/dashboard.html'))
);

// ==================== API PÚBLICA ====================
// Buscar freelancers com pesquisa
app.get('/api/freelancers', async (req, res) => {
  const db = await openDb();
  const { q, category, work_type, city } = req.query;
  
  let sql = 'SELECT * FROM freelancers WHERE 1=1';
  let params = [];
  
  if (q) {
    sql += ' AND (name LIKE ? OR title LIKE ? OR description LIKE ?)';
    const like = `%${q}%`;
    params.push(like, like, like);
  }
  if (category && category !== 'all') {
    sql += ' AND category = ?';
    params.push(category);
  }
  if (work_type && work_type !== 'all') {
    sql += ' AND work_type IN (?, "AMBOS")';
    params.push(work_type);
  }
  if (city) {
    sql += ' AND city = ?';
    params.push(city);
  }
  
  sql += ' ORDER BY rating DESC LIMIT 50';
  const freelancers = await db.all(sql, params);
  await db.close();
  res.json(freelancers);
});

// Estatísticas públicas
app.get('/api/stats', async (req, res) => {
  const db = await openDb();
  const stats = await db.get(`
    SELECT 
      (SELECT COUNT(*) FROM freelancers) as total_freelancers,
      (SELECT COUNT(*) FROM projects WHERE status='open') as open_projects,
      (SELECT COUNT(*) FROM reviews) as total_reviews
  `);
  await db.close();
  res.json(stats);
});

// ==================== API PROTEGIDA ====================
// Criar projeto (requer login)
app.post('/api/projects', requireAuth, async (req, res) => {
  const db = await openDb();
  const { title, description, category, work_type, city, budget } = req.body;
  
  const result = await db.run(`
    INSERT INTO projects (title, description, category, work_type, city, budget, client_id, client_name, client_email)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
  `, [title, description, category, work_type, city, budget, req.user.id, req.user.name, req.user.email]);
  
  await db.close();
  res.json({ id: result.lastID, message: 'Projeto criado!' });
});

// ==================== API ADMIN/DEV ====================
// Estatísticas para admin/dev
app.get('/api/admin/stats', requireRole(['dev', 'admin']), async (req, res) => {
  const db = await openDb();
  const stats = await db.get(`
    SELECT 
      (SELECT COUNT(*) FROM users) as totalUsers,
      (SELECT COUNT(*) FROM freelancers) as totalFreelancers,
      (SELECT COUNT(*) FROM projects) as totalProjects,
      (SELECT COUNT(*) FROM reviews) as totalReviews
  `);
  await db.close();
  res.json(stats);
});

// Listar usuários
app.get('/api/admin/users', requireRole(['dev', 'admin']), async (req, res) => {
  const db = await openDb();
  const users = await db.all('SELECT id, name, email, role, user_type, is_active, created_at FROM users ORDER BY id DESC');
  await db.close();
  res.json(users);
});

// Ativar/desativar usuário
app.post('/api/admin/users/toggle', requireRole(['dev', 'admin']), async (req, res) => {
  const { user_id, active } = req.body;
  const db = await openDb();
  await db.run('UPDATE users SET is_active = ? WHERE id = ?', [active, user_id]);
  await db.close();
  res.json({ success: true });
});

// ==================== INICIAR SERVIDOR ====================
app.listen(PORT, () => {
  console.log('\n╔═══════════════════════════════════════════════════════════╗');
  console.log('║     🚀 FAZ PRA MIM - Servidor rodando! 🚀                 ║');
  console.log('╠═══════════════════════════════════════════════════════════╣');
  console.log(`║     📍 http://localhost:${PORT}                             ║`);
  console.log(`║     🔐 Login: http://localhost:${PORT}/login                ║`);
  console.log('╠═══════════════════════════════════════════════════════════╣');
  console.log('║     👨‍💻 DEV:     dev@fazpramim.com / 123456                 ║');
  console.log('║     👑 ADMIN:   admin@fazpramim.com / 123456               ║');
  console.log('║     💼 PRO:     carlos@exemplo.com / 123456                ║');
  console.log('║     👤 CLIENTE: ana@exemplo.com / 123456                   ║');
  console.log('╚═══════════════════════════════════════════════════════════╝\n');
});
