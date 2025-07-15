import React from 'react';
import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
import PostList from './components/PostList';
import PostDetail from './components/PostDetail';
import PostForm from './components/PostForm';
import CategoryManager from './components/CategoryManager';
import './App.css';

function App() {
  return (
    <Router>
      <div className="app">
        <header className="header">
          <h1><Link to="/">Blog System</Link></h1>
          <nav>
            <Link to="/">記事一覧</Link>
            <Link to="/new">新規投稿</Link>
            <Link to="/categories">カテゴリー管理</Link>
          </nav>
        </header>
        
        <main className="main">
          <Routes>
            <Route path="/" element={<PostList />} />
            <Route path="/posts/:id" element={<PostDetail />} />
            <Route path="/new" element={<PostForm />} />
            <Route path="/edit/:id" element={<PostForm />} />
            <Route path="/categories" element={<CategoryManager />} />
          </Routes>
        </main>
      </div>
    </Router>
  );
}

export default App;