const Sequelize = require('sequelize');
const sequelize = require('../config/database');

const Note = require('./note');

const db = {};

db.Sequelize = Sequelize;
db.sequelize = sequelize;

db.Note = Note(sequelize, Sequelize.DataTypes);

module.exports = db;