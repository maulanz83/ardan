const Sequelize = require('sequelize');
const sequelize = require('../config/database');

const Auth = require('./auth');

const db = {};

db.Sequelize = Sequelize;
db.sequelize = sequelize;

db.Auth = Auth(sequelize, Sequelize.DataTypes);

module.exports = db;