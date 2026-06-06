const { openDb } = require('./database.js');

async function initDatabase() {
  const db = await openDb();
  
  await db.exec(`
    CREATE TABLE IF NOT EXISTS freelancers (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      email TEXT UNIQUE NOT NULL,
      phone TEXT,
      title TEXT NOT NULL,
      description TEXT,
      category TEXT NOT NULL,
      work_type TEXT DEFAULT 'AMBOS',
      city TEXT,
      state TEXT,
      price_hourly REAL,
      rating REAL DEFAULT 0,
      review_count INTEGER DEFAULT 0,
      is_verified INTEGER DEFAULT 0,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    );
    
    CREATE TABLE IF NOT EXISTS reviews (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      freelancer_id INTEGER NOT NULL,
      client_name TEXT NOT NULL,
      rating INTEGER NOT NULL,
      comment TEXT,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    );
  `);
  
  const count = await db.get('SELECT COUNT(*) as total FROM freelancers');
  
  if (count.total === 0) {
    console.log('📦 Inserindo dados de exemplo...');
    await db.run(`
      INSERT INTO freelancers (name, email, phone, title, description, category, work_type, city, state, price_hourly, rating, review_count, is_verified) VALUES
      ('Carlos Silva', 'carlos@email.com', '(11) 99999-1111', 'Desenvolvedor Full Stack', 'Especialista em React, Node.js e arquiteturas escaláveis. Mais de 8 anos de experiência.', 'Serviços Digitais', 'REMOTO', 'São Paulo', 'SP', 150, 4.9, 124, 1),
      ('Ana Oliveira', 'ana@email.com', '(11) 99999-2222', 'Designer Gráfica', 'Crio identidades visuais impactantes e interfaces intuitivas.', 'Serviços Digitais', 'REMOTO', 'Rio de Janeiro', 'RJ', 85, 4.8, 89, 1),
      ('Marcos Santos', 'marcos@email.com', '(11) 99999-3333', 'Eletricista', 'Instalações e reparos elétricos com garantia e segurança.', 'Serviços Presenciais', 'PRESENCIAL', 'São Paulo', 'SP', 65, 4.7, 45, 1),
      ('Patrícia Lima', 'patricia@email.com', '(11) 99999-4444', 'Social Media', 'Estratégias de conteúdo para aumentar seu engajamento.', 'Serviços Digitais', 'REMOTO', 'Belo Horizonte', 'MG', 70, 4.9, 67, 1),
      ('Roberto Alves', 'roberto@email.com', '(11) 99999-5555', 'Personal Trainer', 'Treinos personalizados para sua rotina e objetivos.', 'Profissionais Especializados', 'AMBOS', 'São Paulo', 'SP', 90, 4.8, 112, 1)
    `);
    console.log('✅ 5 profissionais inseridos!');
  }
  
  console.log('✅ Banco inicializado!');
  await db.close();
}

module.exports = initDatabase;
