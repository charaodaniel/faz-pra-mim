#!/bin/bash
# reorganizar.sh - Reorganiza a estrutura do projeto

echo "📁 Reorganizando estrutura do projeto..."

# Criar nova estrutura de diretórios
mkdir -p src/public/css
mkdir -p src/public/js
mkdir -p src/public/images
mkdir -p src/views
mkdir -p src/routes
mkdir -p src/controllers
mkdir -p src/models
mkdir -p src/database

# Mover arquivos HTML para views
echo "📄 Movendo arquivos HTML..."
mv index.html src/views/ 2>/dev/null
mv perfil.html src/views/ 2>/dev/null
mv dashboard.html src/views/ 2>/dev/null

# Criar style.css na nova localização
echo "🎨 Movendo arquivos CSS..."
cat > src/public/css/style.css << 'EOF'
/* Estilos globais do Faz pra mim */
body {
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
}

.freelancer-card {
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.freelancer-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 10px 30px rgba(124, 58, 237, 0.1);
}

.hero-pattern {
    background-image: radial-gradient(circle at 2px 2px, #7c3aed15 1px, transparent 0);
    background-size: 24px 24px;
}

.glass-card {
    background: rgba(255, 255, 255, 0.7);
    backdrop-filter: blur(10px);
    border: 1px solid rgba(255, 255, 255, 0.3);
}
EOF

# Criar JavaScript principal
echo "📜 Criando JavaScript..."
cat > src/public/js/main.js << 'EOF'
// Faz pra mim - JavaScript principal
const API_BASE = '/api';

async function apiRequest(endpoint, options = {}) {
    try {
        const response = await fetch(`${API_BASE}${endpoint}`, {
            headers: { 'Content-Type': 'application/json' },
            ...options
        });
        return await response.json();
    } catch (error) {
        console.error('API Error:', error);
        throw error;
    }
}

// Utilitários
function formatPrice(price) {
    return new Intl.NumberFormat('pt-BR', {
        style: 'currency',
        currency: 'BRL'
    }).format(price);
}

function formatDate(date) {
    return new Date(date).toLocaleDateString('pt-BR');
}

function renderStars(rating) {
    const fullStars = Math.floor(rating);
    const hasHalfStar = rating % 1 >= 0.5;
    let stars = '⭐'.repeat(fullStars);
    if (hasHalfStar) stars += '½';
    return stars || '☆☆☆☆☆';
}

console.log('🚀 Faz pra mim carregado!');
EOF

# Criar model Freelancer
echo "📦 Criando models..."
cat > src/models/Freelancer.js << 'EOF'
const { openDb } = require('../database/database.js');

class Freelancer {
    static async findAll(filters = {}) {
        const db = await openDb();
        const { category, work_type, city, query, limit = 50 } = filters;
        
        let sql = 'SELECT * FROM freelancers WHERE 1=1';
        let params = [];
        
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
        if (query) {
            sql += ' AND (name LIKE ? OR title LIKE ? OR description LIKE ?)';
            const like = `%${query}%`;
            params.push(like, like, like);
        }
        
        sql += ' ORDER BY rating DESC LIMIT ?';
        params.push(limit);
        
        const freelancers = await db.all(sql, params);
        await db.close();
        return freelancers;
    }
    
    static async findById(id) {
        const db = await openDb();
        const freelancer = await db.get(
            'SELECT * FROM freelancers WHERE id = ?',
            [id]
        );
        
        if (freelancer) {
            const reviews = await db.all(
                'SELECT * FROM reviews WHERE freelancer_id = ? ORDER BY created_at DESC',
                [id]
            );
            freelancer.reviews = reviews;
        }
        
        await db.close();
        return freelancer;
    }
    
    static async updateRating(id) {
        const db = await openDb();
        const avgRating = await db.get(
            'SELECT AVG(rating) as avg, COUNT(*) as total FROM reviews WHERE freelancer_id = ?',
            [id]
        );
        
        await db.run(
            'UPDATE freelancers SET rating = ?, review_count = ? WHERE id = ?',
            [avgRating.avg || 0, avgRating.total || 0, id]
        );
        
        await db.close();
        return avgRating;
    }
}

module.exports = Freelancer;
EOF

# Criar model Review
cat > src/models/Review.js << 'EOF'
const { openDb } = require('../database/database.js');

class Review {
    static async create(data) {
        const db = await openDb();
        const { freelancer_id, client_name, rating, comment } = data;
        
        const result = await db.run(`
            INSERT INTO reviews (freelancer_id, client_name, rating, comment, created_at)
            VALUES (?, ?, ?, ?, datetime('now'))
        `, [freelancer_id, client_name, rating, comment]);
        
        await db.close();
        return { id: result.lastID, ...data };
    }
    
    static async findByFreelancer(freelancerId) {
        const db = await openDb();
        const reviews = await db.all(
            'SELECT * FROM reviews WHERE freelancer_id = ? ORDER BY created_at DESC',
            [freelancerId]
        );
        await db.close();
        return reviews;
    }
}

module.exports = Review;
EOF

# Criar controller Freelancer
echo "🎮 Criando controllers..."
cat > src/controllers/freelancerController.js << 'EOF'
const Freelancer = require('../models/Freelancer.js');
const Review = require('../models/Review.js');

const freelancerController = {
    async list(req, res) {
        try {
            const { category, work_type, city, query } = req.query;
            const freelancers = await Freelancer.findAll({ category, work_type, city, query });
            res.json(freelancers);
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },
    
    async getById(req, res) {
        try {
            const freelancer = await Freelancer.findById(req.params.id);
            if (!freelancer) {
                return res.status(404).json({ error: 'Profissional não encontrado' });
            }
            res.json(freelancer);
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },
    
    async addReview(req, res) {
        try {
            const { client_name, rating, comment } = req.body;
            const freelancer_id = req.params.id;
            
            await Review.create({ freelancer_id, client_name, rating, comment });
            const stats = await Freelancer.updateRating(freelancer_id);
            
            res.json({ success: true, new_rating: stats.avg, new_count: stats.total });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }
};

module.exports = freelancerController;
EOF

# Criar rotas
echo "🛣️ Criando rotas..."
cat > src/routes/freelancers.js << 'EOF'
const express = require('express');
const router = express.Router();
const freelancerController = require('../controllers/freelancerController.js');

router.get('/', freelancerController.list);
router.get('/:id', freelancerController.getById);
router.post('/:id/review', freelancerController.addReview);

module.exports = router;
EOF

# Mover database para pasta correta
echo "🗄️ Movendo arquivos de banco de dados..."
mv database.js src/database/ 2>/dev/null
mv init-db.js src/database/ 2>/dev/null

# Atualizar caminhos nos arquivos
echo "🔄 Atualizando caminhos..."

# Atualizar database.js
cat > src/database/database.js << 'EOF'
const sqlite3 = require('sqlite3');
const { open } = require('sqlite');
const path = require('path');

async function openDb() {
    // Caminho relativo para manter o banco na pasta data
    const dbPath = path.join(process.cwd(), 'data', 'fazpramim.db');
    
    return open({
        filename: dbPath,
        driver: sqlite3.Database
    });
}

module.exports = { openDb };
EOF

# Atualizar init-db.js
cat > src/database/init-db.js << 'EOF'
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
EOF

# Criar novo server.js principal
echo "🖥️ Criando novo server.js..."
cat > server.js << 'EOF'
require('dotenv').config();
const express = require('express');
const cors = require('cors');
const path = require('path');
const freelancerRoutes = require('./src/routes/freelancers.js');
const initDatabase = require('./src/database/init-db.js');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Arquivos estáticos
app.use('/css', express.static(path.join(__dirname, 'src/public/css')));
app.use('/js', express.static(path.join(__dirname, 'src/public/js')));
app.use('/images', express.static(path.join(__dirname, 'src/public/images')));

// Views (HTML)
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'src/views/index.html'));
});

app.get('/perfil/:id', (req, res) => {
    res.sendFile(path.join(__dirname, 'src/views/perfil.html'));
});

app.get('/dashboard', (req, res) => {
    res.sendFile(path.join(__dirname, 'src/views/dashboard.html'));
});

// Rotas da API
app.use('/api/freelancers', freelancerRoutes);

// Health check
app.get('/health', (req, res) => {
    res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

// Inicializar banco e iniciar servidor
async function startServer() {
    await initDatabase();
    
    app.listen(PORT, () => {
        console.log(`\n🚀 Servidor rodando em http://localhost:${PORT}`);
        console.log(`📁 Estrutura reorganizada!`);
        console.log(`📂 Views: src/views/`);
        console.log(`🗄️ Banco: data/fazpramim.db\n`);
    });
}

startServer();
EOF

# Atualizar package.json
echo "📦 Atualizando package.json..."
cat > package.json << 'EOF'
{
  "name": "faz-pra-mim",
  "version": "3.0.0",
  "description": "Plataforma de serviços para PJs, Freelancers e Pequenas Empresas",
  "main": "server.js",
  "scripts": {
    "start": "node server.js",
    "dev": "nodemon server.js",
    "init-db": "node src/database/init-db.js"
  },
  "dependencies": {
    "express": "^4.18.2",
    "sqlite3": "^5.1.6",
    "sqlite": "^5.1.1",
    "cors": "^2.8.5",
    "dotenv": "^16.3.1"
  },
  "devDependencies": {
    "nodemon": "^3.0.1"
  }
}
EOF

# Atualizar .gitignore
echo "🔒 Atualizando .gitignore..."
cat > .gitignore << 'EOF'
node_modules/
*.db
*.db-journal
data/
.env
.DS_Store
npm-debug.log
*.log
dist/
build/
EOF

# Criar .env
echo "🔐 Criando .env..."
cat > .env << 'EOF'
NODE_ENV=development
PORT=3000
EOF

# Instalar dotenv
npm install dotenv --save

# Remover arquivos antigos da raiz
echo "🗑️ Removendo arquivos antigos da raiz..."
rm -f index.html perfil.html dashboard.html 2>/dev/null
rm -f database.js init-db.js 2>/dev/null

# Verificar estrutura final
echo ""
echo "📁 Estrutura final do projeto:"
tree -L 3 -I 'node_modules|data' 2>/dev/null || ls -la

echo ""
echo "✅ Reorganização concluída!"
echo ""
echo "📂 Nova estrutura:"
echo "   src/views/      - Arquivos HTML"
echo "   src/public/     - CSS, JS, imagens"
echo "   src/routes/     - Rotas da API"
echo "   src/controllers/- Lógica de negócio"
echo "   src/models/     - Models do banco"
echo "   src/database/   - Configuração do banco"
echo ""
echo "🚀 Para iniciar: npm start"
