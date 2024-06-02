const express = require('express');
const router = express.Router();
const db = require('../models');
const Note = db.Note;

// Create a new note
router.post('/add', async (req, res) => {
  const { email, title, content } = req.body;
  console.log(req.body);
  try {
    const note = await Note.create({ email, title, content });
    res.json(note);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get notes by email
router.get('/:email', async (req, res) => {
  const { email } = req.params;

  try {
    const notes = await Note.findAll({ where: { email } });
    res.json(notes);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
