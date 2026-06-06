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
