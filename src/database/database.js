const sqlite3 = require('sqlite3');
const { open } = require('sqlite');
const path = require('path');

async function openDb() {
  return open({
    filename: path.join(__dirname, '../../fazpramim.db'),
    driver: sqlite3.Database
  });
}

module.exports = { openDb };
