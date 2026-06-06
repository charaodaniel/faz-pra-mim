const { openDb } = require('./database.js');
const bcrypt = require('bcryptjs');

async function initDatabase() {
  const db = await openDb();
  
  // Dropar tabelas existentes
  await db.exec(`DROP TABLE IF EXISTS sessions`);
  await db.exec(`DROP TABLE IF EXISTS reviews`);
  await db.exec(`DROP TABLE IF EXISTS projects`);
  await db.exec(`DROP TABLE IF EXISTS freelancers`);
  await db.exec(`DROP TABLE IF EXISTS empresas`);
  await db.exec(`DROP TABLE IF EXISTS users`);
  
  // Tabela de usuários com níveis de acesso
  await db.exec(`
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      email TEXT UNIQUE NOT NULL,
      password TEXT NOT NULL,
      user_type TEXT DEFAULT 'cliente',
      role TEXT DEFAULT 'cliente',
      phone TEXT,
      avatar TEXT,
      document TEXT,
      is_active INTEGER DEFAULT 1,
      last_login DATETIME,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    )
  `);
  
  // Tabela de freelancers/PJ
  await db.exec(`
    CREATE TABLE freelancers (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER UNIQUE,
      name TEXT NOT NULL,
      email TEXT UNIQUE NOT NULL,
      phone TEXT,
      title TEXT NOT NULL,
      description TEXT,
      category TEXT NOT NULL,
      work_type TEXT DEFAULT 'AMBOS',
      city TEXT,
      price_hourly REAL,
      rating REAL DEFAULT 0,
      review_count INTEGER DEFAULT 0,
      is_verified INTEGER DEFAULT 0,
      is_boosted INTEGER DEFAULT 0,
      portfolio TEXT,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
    )
  `);
  
  // Tabela de empresas
  await db.exec(`
    CREATE TABLE empresas (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER UNIQUE,
      company_name TEXT NOT NULL,
      cnpj TEXT UNIQUE,
      segmento TEXT,
      porte TEXT,
      description TEXT,
      services TEXT,
      city TEXT,
      state TEXT,
      website TEXT,
      rating REAL DEFAULT 0,
      review_count INTEGER DEFAULT 0,
      is_verified INTEGER DEFAULT 0,
      is_boosted INTEGER DEFAULT 0,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
    )
  `);
  
  // Tabela de projetos
  await db.exec(`
    CREATE TABLE projects (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      description TEXT NOT NULL,
      category TEXT NOT NULL,
      work_type TEXT NOT NULL,
      city TEXT,
      budget REAL,
      client_id INTEGER,
      client_name TEXT NOT NULL,
      client_email TEXT NOT NULL,
      client_phone TEXT,
      status TEXT DEFAULT 'open',
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (client_id) REFERENCES users(id)
    )
  `);
  
  // Tabela de avaliações
  await db.exec(`
    CREATE TABLE reviews (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      freelancer_id INTEGER NOT NULL,
      client_id INTEGER,
      client_name TEXT NOT NULL,
      rating INTEGER NOT NULL,
      comment TEXT,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (freelancer_id) REFERENCES freelancers(id),
      FOREIGN KEY (client_id) REFERENCES users(id)
    )
  `);
  
  // Tabela de logs do sistema (para admin)
  await db.exec(`
    CREATE TABLE logs (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER,
      action TEXT,
      details TEXT,
      ip TEXT,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (user_id) REFERENCES users(id)
    )
  `);
  
  // Hash das senhas
  const hash = await bcrypt.hash('123456', 10);
  
  console.log('📦 Inserindo usuários com diferentes níveis de acesso...');
  
  // Inserir usuários com diferentes roles
  await db.run(`
    INSERT INTO users (name, email, password, user_type, role, phone, document) VALUES 
    -- DEV (acesso total)
    ('Daniel Developer', 'dev@fazpramim.com', ?, 'developer', 'dev', '(11) 99999-0000', '123.456.789-00'),
    -- ADMIN
    ('Administrador Sistema', 'admin@fazpramim.com', ?, 'admin', 'admin', '(11) 99999-0001', '987.654.321-00'),
    -- PROFISSIONAL (Freelancer)
    ('Carlos Silva', 'carlos@exemplo.com', ?, 'profissional', 'profissional', '(11) 99999-1111', '111.222.333-44'),
    -- PROFISSIONAL (Empresa)
    ('TechNexus Soluções', 'tech@nexus.com', ?, 'profissional', 'profissional', '(11) 99999-2222', '12.345.678/0001-90'),
    -- CLIENTE
    ('Ana Souza', 'ana@exemplo.com', ?, 'cliente', 'cliente', '(11) 99999-3333', '333.444.555-66'),
    ('Maria Santos', 'maria@exemplo.com', ?, 'cliente', 'cliente', '(11) 99999-4444', '444.555.666-77')
  `, [hash, hash, hash, hash, hash, hash]);
  
  // Inserir freelancers
  await db.run(`
    INSERT INTO freelancers (user_id, name, email, phone, title, description, category, work_type, city, price_hourly, rating, review_count, is_verified) VALUES 
    (3, 'Carlos Silva', 'carlos@exemplo.com', '(11) 99999-1111', 'Desenvolvedor Full Stack', 'Especialista em React, Node.js e Python. 8 anos de experiência.', 'Serviços Digitais', 'AMBOS', 'São Paulo', 85, 4.9, 42, 1)
  `);
  
  // Inserir empresas
  await db.run(`
    INSERT INTO empresas (user_id, company_name, cnpj, segmento, porte, description, services, city, rating, review_count, is_verified) VALUES 
    (4, 'TechNexus Soluções', '12.345.678/0001-90', 'Tecnologia', 'ME', 'Empresa de desenvolvimento de software e consultoria em TI.', '["Desenvolvimento Web","Apps","Consultoria"]', 'São Paulo', 4.9, 28, 1)
  `);
  
  // Inserir projetos
  await db.run(`
    INSERT INTO projects (title, description, category, work_type, city, budget, client_name, client_email, status) VALUES 
    ('Sistema para academia', 'Sistema de gestão com controle de alunos e mensalidades', 'Serviços Digitais', 'REMOTO', NULL, 5000, 'João Silva', 'joao@exemplo.com', 'open'),
    ('Reforma do escritório', 'Reforma completa incluindo pintura e elétrica', 'Serviços Presenciais', 'PRESENCIAL', 'São Paulo', 15000, 'Empresa XPTO', 'xpto@exemplo.com', 'open'),
    ('Logo para cafeteria', 'Logo profissional para cafeteria artesanal', 'Serviços Digitais', 'REMOTO', NULL, 800, 'Carla Souza', 'carla@exemplo.com', 'open')
  `);
  
  console.log('\n✅ USUÁRIOS CRIADOS:');
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  console.log('👨‍💻 DEV (acesso total):');
  console.log('   Email: dev@fazpramim.com');
  console.log('   Senha: 123456');
  console.log('');
  console.log('👑 ADMIN (administrador):');
  console.log('   Email: admin@fazpramim.com');
  console.log('   Senha: 123456');
  console.log('');
  console.log('💼 PROFISSIONAIS (Freelancer/Empresa):');
  console.log('   Email: carlos@exemplo.com');
  console.log('   Senha: 123456');
  console.log('   Email: tech@nexus.com');
  console.log('   Senha: 123456');
  console.log('');
  console.log('👤 CLIENTES:');
  console.log('   Email: ana@exemplo.com');
  console.log('   Senha: 123456');
  console.log('   Email: maria@exemplo.com');
  console.log('   Senha: 123456');
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');
  
  await db.close();
}

initDatabase().catch(console.error);
