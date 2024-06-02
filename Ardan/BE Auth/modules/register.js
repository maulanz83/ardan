const express = require('express');
const fs = require('fs');
const path = require('path');

const router = express.Router();

// Path to the user data file
const dataFilePath = path.join(__dirname, '../data/user.json');

// function to read user data from the file
const readUserData = () => {
    if (!fs.existsSync(dataFilePath)) {
        return [];
    }
    const data = fs.readFileSync(dataFilePath, 'utf8');
    return data ? JSON.parse(data) : [];
};

// function to write user data to the file
const writeUserData = (data) => {
    fs.writeFileSync(dataFilePath, JSON.stringify(data, null, 2));
};

// Register a new user
router.post('/register', (req, res) => {
    const { email, password} = req.body;

    if (!email || !password) {
        return res.status(400).json({ status: 'failed', message: 'Missing required fields' });
    }

    const users = readUserData();

    if (users.some(user => user.email === email)) {
        return res.status(400).json({ status: 'failed', message: 'Email already been used' });
    }

    const newUser = {
        email,
        password,  // Assuming password is already encrypted
    };

    users.push(newUser);
    writeUserData(users);

    res.json({ status: 'success', message: 'User registered successfully' });
});






module.exports = router;
