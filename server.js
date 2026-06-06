const express = require('express');
const cors = require('cors');
const path = require('path');
const { openDb } = require('./database.js');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());
app.use(express.static('.'));

// Rotas API
app.get('/health', (req, res) => res.json({ status: 'ok' }));

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});

app.get('/perfil/:id', (req, res) => {
    res.sendFile(path.join(__dirname, 'perfil.html'));
});

app.get('/dashboard', (req, res) => {
    res.sendFile(path.join(__dirname, 'dashboard.html'));
});

// API: Buscar freelancers
app.get('/api/freelancers', async (req, res) => {
    const db = await openDb();
    const { category, work_type, city, query } = req.query;
    
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
    
    sql += ' ORDER BY rating DESC LIMIT 50';
    
    try {
        const freelancers = await db.all(sql, params);
        await db.close();
        res.json(freelancers);
    } catch (error) {
        await db.close();
        res.status(500).json({ error: error.message });
    }
});

// API: Detalhes do freelancer
app.get('/api/freelancers/:id', async (req, res) => {
    const db = await openDb();
    try {
        const freelancer = await db.get(
            'SELECT * FROM freelancers WHERE id = ?',
            [req.params.id]
        );
        
        if (freelancer) {
            const reviews = await db.all(
                'SELECT * FROM reviews WHERE freelancer_id = ? ORDER BY created_at DESC',
                [req.params.id]
            );
            freelancer.reviews = reviews;
            
            const stats = await db.get(
                `SELECT 
                    AVG(rating) as media,
                    COUNT(*) as total,
                    SUM(CASE WHEN rating = 5 THEN 1 ELSE 0 END) as cinco,
                    SUM(CASE WHEN rating = 4 THEN 1 ELSE 0 END) as quatro,
                    SUM(CASE WHEN rating = 3 THEN 1 ELSE 0 END) as tres,
                    SUM(CASE WHEN rating = 2 THEN 1 ELSE 0 END) as dois,
                    SUM(CASE WHEN rating = 1 THEN 1 ELSE 0 END) as um
                 FROM reviews WHERE freelancer_id = ?`,
                [req.params.id]
            );
            freelancer.reviews_stats = stats || { media: 0, total: 0 };
        }
        
        await db.close();
        res.json(freelancer);
    } catch (error) {
        await db.close();
        res.status(500).json({ error: error.message });
    }
});

// API: Adicionar avaliação
app.post('/api/freelancers/:id/review', async (req, res) => {
    const db = await openDb();
    const { client_name, rating, comment } = req.body;
    
    try {
        await db.run(`
            INSERT INTO reviews (freelancer_id, client_name, rating, comment)
            VALUES (?, ?, ?, ?)
        `, [req.params.id, client_name, rating, comment]);
        
        const avgRating = await db.get(
            'SELECT AVG(rating) as avg FROM reviews WHERE freelancer_id = ?',
            [req.params.id]
        );
        
        const count = await db.get(
            'SELECT COUNT(*) as total FROM reviews WHERE freelancer_id = ?',
            [req.params.id]
        );
        
        await db.run(
            'UPDATE freelancers SET rating = ?, review_count = ? WHERE id = ?',
            [avgRating.avg, count.total, req.params.id]
        );
        
        await db.close();
        res.json({ success: true, new_rating: avgRating.avg, new_count: count.total });
    } catch (error) {
        await db.close();
        res.status(500).json({ error: error.message });
    }
});

app.listen(PORT, () => {
    console.log(`\n🚀 Servidor rodando em http://localhost:${PORT}`);
    console.log(`📁 Acesse a plataforma no navegador\n`);
});
