// express js run on 0.0.0.0

const express = require('express');
const path = require('path');
const http = require('http');
const cors = require('cors');
const bodyParser = require('body-parser')
const db = require('./models');
const authh = require('./routes/auth');

const app = express();
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

app.use('/auth', authh);

db.sequelize.sync().then(() => {
    console.log('Database synchronized');
    app.listen(8890, () => {
      console.log('Server is running on port 8890');
    });
  });

// const register = require('./modules/register');
// app.use(register);

// const login = require('./modules/login');
// app.use(login);

// const port = 8890;
// const hostname = '0.0.0.0';

// app.listen(port, hostname, () => {
//     console.log(`Server running at http://${hostname}:${port}/`);
// });
