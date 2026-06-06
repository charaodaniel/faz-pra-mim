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
# Instale as dependências
npm install

# Inicialize o banco de dados
npm run init-db

# Execute o servidor
npm run dev



# ============================================
# ATUALIZAR DATABASE - Adicionar tabela de empresas
# ============================================
cat > src/database/init-db.js << 'EOF'
const { openDb } = require('./database.js');

async function initDatabase() {
  const db = await openDb();
  
  // Tabela de usuários (unificada)
  await db.exec(`
    CREATE TABLE IF NOT EXISTS users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      email TEXT UNIQUE NOT NULL,
      phone TEXT,
      avatar TEXT,
      user_type TEXT DEFAULT 'cliente', -- freelancer, empresa, cliente
      document TEXT, -- CPF ou CNPJ
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    )
  `);
  
  // Tabela de freelancers/PJ
  await db.exec(`
    CREATE TABLE IF NOT EXISTS freelancers (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER,
      title TEXT,
      description TEXT,
      category TEXT,
      subcategory TEXT,
      work_type TEXT DEFAULT 'AMBOS',
      city TEXT,
      state TEXT,
      service_radius INTEGER DEFAULT 30,
      price_hourly REAL,
      price_fixed REAL,
      rating REAL DEFAULT 0,
      review_count INTEGER DEFAULT 0,
      is_verified INTEGER DEFAULT 0,
      is_boosted INTEGER DEFAULT 0,
      boost_expires_at DATETIME,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (user_id) REFERENCES users(id)
    )
  `);
  
  // Tabela de pequenas empresas
  await db.exec(`
    CREATE TABLE IF NOT EXISTS empresas (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER,
      company_name TEXT NOT NULL,
      cnpj TEXT UNIQUE,
      segmento TEXT, -- tecnologia, construção, alimentação, etc
      porte TEXT, -- MEI, ME, EPP
      description TEXT,
      services TEXT, -- serviços oferecidos (JSON array)
      city TEXT,
      state TEXT,
      address TEXT,
      website TEXT,
      instagram TEXT,
      whatsapp TEXT,
      rating REAL DEFAULT 0,
      review_count INTEGER DEFAULT 0,
      is_verified INTEGER DEFAULT 0,
      is_boosted INTEGER DEFAULT 0,
      boost_expires_at DATETIME,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (user_id) REFERENCES users(id)
    )
  `);
  
  // Tabela de projetos
  await db.exec(`
    CREATE TABLE IF NOT EXISTS projects (
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
    CREATE TABLE IF NOT EXISTS reviews (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      target_id INTEGER NOT NULL,
      target_type TEXT NOT NULL, -- freelancer, empresa
      client_id INTEGER,
      client_name TEXT NOT NULL,
      rating INTEGER NOT NULL,
      comment TEXT,
      punctuality INTEGER,
      quality INTEGER,
      communication INTEGER,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    )
  `);
  
  // Verificar se já tem dados
  const userCount = await db.get('SELECT COUNT(*) as total FROM users');
  
  if (userCount.total === 0) {
    console.log('📦 Inserindo dados de exemplo...');
    
    // Inserir usuários
    await db.run(`
      INSERT INTO users (name, email, phone, user_type, document) VALUES 
      ('Carlos Silva', 'carlos@exemplo.com', '(11) 99999-1111', 'freelancer', '123.456.789-00'),
      ('Ana Souza', 'ana@exemplo.com', '(11) 99999-2222', 'cliente', '987.654.321-00'),
      ('TechNexus Soluções', 'contato@technexus.com', '(11) 99999-3333', 'empresa', '12.345.678/0001-90'),
      ('Mariana Costa', 'mariana@exemplo.com', '(11) 99999-4444', 'freelancer', '111.222.333-44'),
      ('ConstruFácil', 'contato@construfacil.com', '(11) 99999-5555', 'empresa', '98.765.432/0001-10')
    `);
    
    // Inserir freelancers
    await db.run(`
      INSERT INTO freelancers (user_id, title, description, category, work_type, city, price_hourly, rating, review_count, is_verified) VALUES 
      (1, 'Desenvolvedor Full Stack', 'Crio sites e sistemas sob medida com React, Node.js e Python. 8 anos de experiência.', 'Serviços Digitais', 'AMBOS', 'São Paulo', 85, 4.9, 42, 1),
      (4, 'Designer Gráfica', 'Identidade visual, logos e artes para redes sociais. Atendimento personalizado.', 'Serviços Digitais', 'REMOTO', 'Rio de Janeiro', 70, 4.8, 35, 1)
    `);
    
    // Inserir empresas
    await db.run(`
      INSERT INTO empresas (user_id, company_name, cnpj, segmento, porte, description, services, city, rating, review_count, is_verified) VALUES 
      (3, 'TechNexus Soluções', '12.345.678/0001-90', 'Tecnologia', 'ME', 'Empresa especializada em desenvolvimento de software e consultoria em TI para pequenas e médias empresas.', '["Desenvolvimento Web", "Aplicativos Mobile", "Consultoria TI", "Suporte Técnico"]', 'São Paulo', 4.9, 28, 1),
      (5, 'ConstruFácil', '98.765.432/0001-10', 'Construção', 'MEI', 'Reformas residenciais e comerciais, com equipe qualificada e preços acessíveis.', '["Reformas", "Pintura", "Elétrica", "Encanamento", "Acabamento"]', 'São Paulo', 4.7, 15, 0)
    `);
    
    // Inserir projetos
    await db.run(`
      INSERT INTO projects (title, description, category, work_type, budget, client_name, client_email) VALUES 
      ('Sistema para academia', 'Preciso de um sistema de gestão para minha academia com controle de alunos e mensalidades', 'Serviços Digitais', 'REMOTO', 5000, 'João', 'joao@exemplo.com'),
      ('Reforma do escritório', 'Reforma completa do escritório incluindo pintura, elétrica e divisórias', 'Serviços Presenciais', 'PRESENCIAL', 15000, 'Mariana', 'mariana@exemplo.com'),
      ('Logo e identidade visual', 'Criação de logo e identidade visual para minha cafeteria artesanal', 'Serviços Digitais', 'REMOTO', 800, 'Carla', 'carla@exemplo.com')
    `);
    
    console.log('✅ Dados de exemplo inseridos com sucesso!');
    console.log('   - 2 freelancers cadastrados');
    console.log('   - 2 empresas cadastradas');
    console.log('   - 3 projetos abertos');
  } else {
    console.log(`📊 Banco já possui ${userCount.total} usuários cadastrados`);
  }
  
  console.log('✅ Banco de dados inicializado!');
  await db.close();
}

initDatabase().catch(console.error);
