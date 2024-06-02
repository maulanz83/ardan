const express = require('express');
const router = express.Router();
const db = require('../models');
const auth = db.Auth;

router.post('/register', (req, res) => {
    const { email, password} = req.body;

    if (!email || !password) {
        return res.status(400).json({ status: 'failed', message: 'Missing required fields' });
    }

    auth.findOne({ where: { email } }).then(user => {
        if (user) {
            return res.status(400).json({ status: 'failed', message: 'Email already been used' });
        }

        auth.create({ email, password }).then(() => {
            res.json({ status: 'success', message: 'User registered successfully' });
        });
    });
}
);

router.post('/login', (req, res) => {
    const { email, password } = req.body;

    if (!email || !password) {
        return res.status(400).json({ status: 'failed', message: 'Missing required fields' });
    }

    auth.findOne({ where: { email, password } }).then(user => {
        if (user) {
            res.json({ status: 'success', message: 'Login successful' });
        } else {
            res.status(400).json({ status: 'failed', message: 'Invalid email or password' });
        }
    });
}
);

module.exports = router;