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
