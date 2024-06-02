const express = require('express');
const path = require('path');
const http = require('http');
const cors = require('cors');
const bodyParser = require('body-parser')
const db = require('./models');
const notesRouter = require('./routes/notes');
const app = express();

app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

// hello world
app.use('/notes', notesRouter);

db.sequelize.sync().then(() => {
  console.log('Database synchronized');
  app.listen(3000, () => {
    console.log('Server is running on port 3000');
  });
});
// const port = process.env.PORT || '5000';

// app.listen(port, () => {
//     console.log(`Server running on port ${port}`);
// }
// );