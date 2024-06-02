const express = require('express');
const fs = require('fs');
const path = require('path');

const router = express.Router();

// Path to the user data file
const dataFilePath = path.join(__dirname, '../data/user.json');

// Helper function to read user data from the file
const readUserData = () => {
    if (!fs.existsSync(dataFilePath)) {
        return [];
    }
    const data = fs.readFileSync(dataFilePath, 'utf8');
    return data ? JSON.parse(data) : [];
};

router.post('/login', (req, res) => {
    const { email, password } = req.body;

    if (!email || !password) {
        const responseMsg = {
            status: 'failed',
            message: 'Missing required fields'
        };
        return res.status(400).json(responseMsg);
    }

    const users = readUserData();

    // Find user with the given email and password
    const user = users.find(user => user.email === email && user.password === password);

    if (user) {
        const responseMsg = {
            status: 'success',
            message: 'Login successful',
        };
        res.json(responseMsg);
    } else {
        const responseMsg = {
            status: 'failed',
            message: 'Invalid email or password'
        };
        res.status(400).json(responseMsg);
    }
});

module.exports = router;
