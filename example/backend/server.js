const express = require('express');
const sqlite3 = require('sqlite3').verbose();
const cors = require('cors');
const bodyParser = require('body-parser');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3001;

app.use(cors());
app.use(bodyParser.json());

const db = new sqlite3.Database('blog.db');

db.serialize(() => {
  db.run(`
    CREATE TABLE IF NOT EXISTS categories (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT UNIQUE NOT NULL,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    )
  `);

  db.run(`
    CREATE TABLE IF NOT EXISTS posts (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      content TEXT NOT NULL,
      category_id INTEGER,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
      updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (category_id) REFERENCES categories(id)
    )
  `);

  db.run(`INSERT OR IGNORE INTO categories (name) VALUES ('技術')`, (err) => {
    if (!err) console.log('Default category created');
  });
  db.run(`INSERT OR IGNORE INTO categories (name) VALUES ('日記')`, (err) => {
    if (!err) console.log('Default category created');
  });
  db.run(`INSERT OR IGNORE INTO categories (name) VALUES ('ニュース')`, (err) => {
    if (!err) console.log('Default category created');
  });
});

app.get('/api/posts', (req, res) => {
  const { page = 1, limit = 10, category, search, sort = 'created_at', order = 'DESC' } = req.query;
  const offset = (page - 1) * limit;
  
  let query = `
    SELECT p.*, c.name as category_name 
    FROM posts p 
    LEFT JOIN categories c ON p.category_id = c.id 
    WHERE 1=1
  `;
  const params = [];

  if (category) {
    query += ' AND p.category_id = ?';
    params.push(category);
  }

  if (search) {
    query += ' AND (p.title LIKE ? OR p.content LIKE ?)';
    params.push(`%${search}%`, `%${search}%`);
  }

  const allowedSorts = ['created_at', 'updated_at'];
  const allowedOrders = ['ASC', 'DESC'];
  const safeSort = allowedSorts.includes(sort) ? sort : 'created_at';
  const safeOrder = allowedOrders.includes(order.toUpperCase()) ? order.toUpperCase() : 'DESC';
  
  query += ` ORDER BY p.${safeSort} ${safeOrder} LIMIT ? OFFSET ?`;
  params.push(parseInt(limit), parseInt(offset));

  const countQuery = query.replace(/SELECT.*FROM/, 'SELECT COUNT(*) as total FROM').replace(/ORDER BY.*$/, '');
  const countParams = params.slice(0, -2);

  db.get(countQuery, countParams, (err, row) => {
    if (err) {
      res.status(500).json({ error: err.message });
      return;
    }

    db.all(query, params, (err, posts) => {
      if (err) {
        res.status(500).json({ error: err.message });
        return;
      }
      const total = row ? row.total : 0;
      res.json({
        posts: posts || [],
        total: total,
        page: parseInt(page),
        limit: parseInt(limit),
        totalPages: Math.ceil(total / limit)
      });
    });
  });
});

app.post('/api/posts', (req, res) => {
  const { title, content, category_id } = req.body;
  
  if (!title || !content) {
    return res.status(400).json({ error: 'Title and content are required' });
  }

  db.run(
    'INSERT INTO posts (title, content, category_id) VALUES (?, ?, ?)',
    [title, content, category_id],
    function(err) {
      if (err) {
        res.status(500).json({ error: err.message });
        return;
      }
      res.json({ id: this.lastID, title, content, category_id });
    }
  );
});

app.get('/api/posts/:id', (req, res) => {
  const { id } = req.params;
  
  db.get(
    `SELECT p.*, c.name as category_name 
     FROM posts p 
     LEFT JOIN categories c ON p.category_id = c.id 
     WHERE p.id = ?`,
    [id],
    (err, post) => {
      if (err) {
        res.status(500).json({ error: err.message });
        return;
      }
      if (!post) {
        res.status(404).json({ error: 'Post not found' });
        return;
      }
      res.json(post);
    }
  );
});

app.put('/api/posts/:id', (req, res) => {
  const { id } = req.params;
  const { title, content, category_id } = req.body;
  
  if (!title || !content) {
    return res.status(400).json({ error: 'Title and content are required' });
  }

  db.run(
    'UPDATE posts SET title = ?, content = ?, category_id = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?',
    [title, content, category_id, id],
    function(err) {
      if (err) {
        res.status(500).json({ error: err.message });
        return;
      }
      if (this.changes === 0) {
        res.status(404).json({ error: 'Post not found' });
        return;
      }
      res.json({ id, title, content, category_id });
    }
  );
});

app.delete('/api/posts/:id', (req, res) => {
  const { id } = req.params;
  
  db.run('DELETE FROM posts WHERE id = ?', [id], function(err) {
    if (err) {
      res.status(500).json({ error: err.message });
      return;
    }
    if (this.changes === 0) {
      res.status(404).json({ error: 'Post not found' });
      return;
    }
    res.json({ message: 'Post deleted successfully' });
  });
});

app.get('/api/categories', (req, res) => {
  db.all('SELECT * FROM categories ORDER BY name', (err, categories) => {
    if (err) {
      res.status(500).json({ error: err.message });
      return;
    }
    res.json(categories);
  });
});

app.post('/api/categories', (req, res) => {
  const { name } = req.body;
  
  if (!name) {
    return res.status(400).json({ error: 'Name is required' });
  }

  db.run(
    'INSERT INTO categories (name) VALUES (?)',
    [name],
    function(err) {
      if (err) {
        if (err.message.includes('UNIQUE')) {
          res.status(409).json({ error: 'Category already exists' });
        } else {
          res.status(500).json({ error: err.message });
        }
        return;
      }
      res.json({ id: this.lastID, name });
    }
  );
});

app.delete('/api/categories/:id', (req, res) => {
  const { id } = req.params;
  
  db.get('SELECT COUNT(*) as count FROM posts WHERE category_id = ?', [id], (err, row) => {
    if (err) {
      res.status(500).json({ error: err.message });
      return;
    }
    
    if (row.count > 0) {
      res.status(409).json({ error: 'Cannot delete category with existing posts' });
      return;
    }
    
    db.run('DELETE FROM categories WHERE id = ?', [id], function(err) {
      if (err) {
        res.status(500).json({ error: err.message });
        return;
      }
      if (this.changes === 0) {
        res.status(404).json({ error: 'Category not found' });
        return;
      }
      res.json({ message: 'Category deleted successfully' });
    });
  });
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});