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
