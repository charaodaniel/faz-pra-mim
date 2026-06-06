const sqlite3 = require('sqlite3');
const { open } = require('sqlite');
const path = require('path');

async function openDb() {
    // Caminho relativo para manter o banco na pasta data
    const dbPath = path.join(process.cwd(), 'data', 'fazpramim.db');
    
    return open({
        filename: dbPath,
        driver: sqlite3.Database
    });
}

module.exports = { openDb };
