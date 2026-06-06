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
