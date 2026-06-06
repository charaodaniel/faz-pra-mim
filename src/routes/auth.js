const express = require('express');
const bcrypt = require('bcryptjs');
const { openDb } = require('../database/database.js');
const { generateToken, requireRole } = require('../middleware/auth.js');

const router = express.Router();

// Rota de login
router.post('/api/login', async (req, res) => {
  const { email, password } = req.body;
  
  if (!email || !password) {
    return res.status(400).json({ error: 'Preencha email e senha' });
  }
  
  const db = await openDb();
  const user = await db.get('SELECT * FROM users WHERE email = ?', [email]);
  
  if (!user) {
    await db.close();
    return res.status(401).json({ error: 'Email ou senha inválidos' });
  }
  
  if (user.is_active !== 1) {
    await db.close();
    return res.status(401).json({ error: 'Usuário desativado. Contate o administrador.' });
  }
  
  const validPassword = await bcrypt.compare(password, user.password);
  if (!validPassword) {
    await db.close();
    return res.status(401).json({ error: 'Email ou senha inválidos' });
  }
  
  // Atualizar último login
  await db.run('UPDATE users SET last_login = CURRENT_TIMESTAMP WHERE id = ?', [user.id]);
  
  // Registrar log
  await db.run('INSERT INTO logs (user_id, action, ip) VALUES (?, ?, ?)', 
    [user.id, 'login', req.ip]);
  
  await db.close();
  
  const token = generateToken(user.id);
  res.cookie('token', token, { httpOnly: true, maxAge: 7 * 24 * 60 * 60 * 1000 });
  
  // Redirecionar baseado na role
  let redirect = '/';
  if (user.role === 'dev') redirect = '/admin/dev';
  else if (user.role === 'admin') redirect = '/admin/dashboard';
  else if (user.role === 'profissional') redirect = '/dashboard';
  else redirect = '/';
  
  res.json({ 
    success: true, 
    user: { id: user.id, name: user.name, email: user.email, role: user.role },
    redirect
  });
});

// Rota de registro
router.post('/api/register', async (req, res) => {
  const { name, email, password, user_type, phone, document } = req.body;
  
  if (!name || !email || !password) {
    return res.status(400).json({ error: 'Preencha todos os campos obrigatórios' });
  }
  
  const db = await openDb();
  
  const existingUser = await db.get('SELECT id FROM users WHERE email = ?', [email]);
  if (existingUser) {
    await db.close();
    return res.status(400).json({ error: 'Email já cadastrado' });
  }
  
  const hashedPassword = await bcrypt.hash(password, 10);
  
  // Definir role baseado no tipo de usuário
  let role = 'cliente';
  if (user_type === 'profissional') role = 'profissional';
  
  const result = await db.run(
    'INSERT INTO users (name, email, password, user_type, role, phone, document) VALUES (?, ?, ?, ?, ?, ?, ?)',
    [name, email, hashedPassword, user_type || 'cliente', role, phone || '', document || '']
  );
  
  // Criar perfil específico
  if (user_type === 'profissional') {
    await db.run(`
      INSERT INTO freelancers (user_id, name, email, phone, title, description, category, work_type, city)
      VALUES (?, ?, ?, ?, 'Profissional', 'Descrição em breve...', 'Serviços Digitais', 'REMOTO', 'São Paulo')
    `, [result.lastID, name, email, phone || '']);
  }
  
  await db.close();
  
  const token = generateToken(result.lastID);
  res.cookie('token', token, { httpOnly: true, maxAge: 7 * 24 * 60 * 60 * 1000 });
  
  res.json({ 
    success: true, 
    user: { id: result.lastID, name, email, role },
    redirect: role === 'profissional' ? '/dashboard' : '/'
  });
});

// Rota de logout
router.post('/api/logout', async (req, res) => {
  if (req.user) {
    const db = await openDb();
    await db.run('INSERT INTO logs (user_id, action, ip) VALUES (?, ?, ?)', 
      [req.user.id, 'logout', req.ip]);
    await db.close();
  }
  res.clearCookie('token');
  res.json({ success: true });
});

// Rota para verificar sessão
router.get('/api/me', async (req, res) => {
  const token = req.cookies?.token;
  if (!token) {
    return res.json({ authenticated: false });
  }
  
  try {
    const jwt = require('jsonwebtoken');
    const { SECRET_KEY } = require('../middleware/auth.js');
    const decoded = jwt.verify(token, SECRET_KEY);
    const db = await openDb();
    const user = await db.get('SELECT id, name, email, user_type, role, avatar FROM users WHERE id = ? AND is_active = 1', [decoded.userId]);
    await db.close();
    
    if (user) {
      res.json({ authenticated: true, user });
    } else {
      res.json({ authenticated: false });
    }
  } catch (error) {
    res.json({ authenticated: false });
  }
});

module.exports = router;
