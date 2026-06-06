const jwt = require('jsonwebtoken');
const { openDb } = require('../database/database.js');

const SECRET_KEY = 'fazpramim_secret_key_2024';

// Níveis de acesso
const ROLES = {
  DEV: 'dev',           // Acesso total
  ADMIN: 'admin',       // Gerenciar usuários, relatórios
  PROFISSIONAL: 'profissional', // Freelancer, PJ, Empresa
  CLIENTE: 'cliente'    // Contratar serviços
};

// Permissões por role
const PERMISSIONS = {
  dev: ['*'], // todas as permissões
  admin: ['view_users', 'edit_users', 'delete_users', 'view_reports', 'view_logs', 'manage_categories'],
  profissional: ['view_profile', 'edit_profile', 'post_services', 'view_proposals', 'manage_portfolio'],
  cliente: ['view_profile', 'edit_profile', 'post_projects', 'hire_services', 'leave_reviews']
};

async function authenticate(req, res, next) {
  const token = req.cookies?.token || req.headers.authorization?.split(' ')[1];
  
  if (!token) {
    req.user = null;
    return next();
  }
  
  try {
    const decoded = jwt.verify(token, SECRET_KEY);
    const db = await openDb();
    const user = await db.get('SELECT id, name, email, user_type, role, is_active FROM users WHERE id = ?', [decoded.userId]);
    await db.close();
    
    if (user && user.is_active === 1) {
      req.user = user;
    } else {
      req.user = null;
    }
  } catch (error) {
    req.user = null;
  }
  next();
}

function requireAuth(req, res, next) {
  if (!req.user) {
    if (req.xhr || req.headers.accept?.includes('application/json')) {
      return res.status(401).json({ error: 'Faça login para continuar' });
    }
    return res.redirect('/login');
  }
  next();
}

function requireRole(allowedRoles) {
  return (req, res, next) => {
    if (!req.user) {
      return res.redirect('/login');
    }
    
    const roles = Array.isArray(allowedRoles) ? allowedRoles : [allowedRoles];
    
    // DEV tem acesso a tudo
    if (req.user.role === 'dev') {
      return next();
    }
    
    if (!roles.includes(req.user.role)) {
      if (req.xhr || req.headers.accept?.includes('application/json')) {
        return res.status(403).json({ error: 'Acesso negado. Você não tem permissão para acessar esta área.' });
      }
      return res.status(403).send(`
        <!DOCTYPE html>
        <html>
        <head><title>Acesso Negado</title><script src="https://cdn.tailwindcss.com"></script></head>
        <body class="bg-gray-100 flex items-center justify-center h-screen">
          <div class="bg-white p-8 rounded-2xl shadow-lg text-center max-w-md">
            <span class="text-6xl">🚫</span>
            <h1 class="text-2xl font-bold mt-4">Acesso Negado</h1>
            <p class="text-gray-600 mt-2">Você não tem permissão para acessar esta página.</p>
            <a href="/" class="inline-block mt-6 bg-primary text-white px-6 py-2 rounded-lg">Voltar ao início</a>
          </div>
        </body>
        </html>
      `);
    }
    
    next();
  };
}

function hasPermission(role, permission) {
  if (role === 'dev') return true;
  const userPermissions = PERMISSIONS[role] || [];
  return userPermissions.includes(permission);
}

function generateToken(userId) {
  return jwt.sign({ userId }, SECRET_KEY, { expiresIn: '7d' });
}

module.exports = { 
  authenticate, 
  requireAuth, 
  requireRole, 
  hasPermission, 
  generateToken, 
  SECRET_KEY,
  ROLES,
  PERMISSIONS
};
