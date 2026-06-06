const express = require('express');
const router = express.Router();
const freelancerController = require('../controllers/freelancerController.js');

router.get('/', freelancerController.list);
router.get('/:id', freelancerController.getById);
router.post('/:id/review', freelancerController.addReview);

module.exports = router;
