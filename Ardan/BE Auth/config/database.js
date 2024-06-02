const { Sequelize } = require('sequelize');

const sequelize = new Sequelize('ptcc', 'root', '', {
  host: '34.101.226.230',
  dialect: 'mysql',
});

module.exports = sequelize;