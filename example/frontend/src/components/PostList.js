import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import axios from 'axios';

const API_URL = 'http://localhost:3001/api';

function PostList() {
  const [posts, setPosts] = useState([]);
  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [filters, setFilters] = useState({
    page: 1,
    limit: 10,
    category: '',
    search: '',
    sort: 'created_at',
    order: 'DESC'
  });
  const [totalPages, setTotalPages] = useState(1);

  useEffect(() => {
    fetchPosts();
    fetchCategories();
  }, [filters]);

  const fetchPosts = async () => {
    setLoading(true);
    try {
      const params = new URLSearchParams();
      Object.entries(filters).forEach(([key, value]) => {
        if (value) params.append(key, value);
      });
      
      const response = await axios.get(`${API_URL}/posts?${params}`);
      setPosts(response.data.posts);
      setTotalPages(response.data.totalPages);
      setError(null);
    } catch (err) {
      setError('記事の取得に失敗しました');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  const fetchCategories = async () => {
    try {
      const response = await axios.get(`${API_URL}/categories`);
      setCategories(response.data);
    } catch (err) {
      console.error('Failed to fetch categories:', err);
    }
  };

  const handleSearch = (e) => {
    e.preventDefault();
    setFilters({ ...filters, page: 1 });
  };

  const handleDelete = async (id) => {
    if (!window.confirm('この記事を削除しますか？')) return;
    
    try {
      await axios.delete(`${API_URL}/posts/${id}`);
      fetchPosts();
    } catch (err) {
      alert('削除に失敗しました');
    }
  };

  const formatDate = (dateString) => {
    return new Date(dateString).toLocaleString('ja-JP');
  };

  if (loading) return <div className="loading">読み込み中...</div>;
  if (error) return <div className="error">{error}</div>;

  return (
    <div className="post-list">
      <div className="filters">
        <form onSubmit={handleSearch}>
          <input
            type="text"
            placeholder="検索..."
            value={filters.search}
            onChange={(e) => setFilters({ ...filters, search: e.target.value })}
          />
          <select
            value={filters.category}
            onChange={(e) => setFilters({ ...filters, category: e.target.value, page: 1 })}
          >
            <option value="">全カテゴリー</option>
            {categories.map(cat => (
              <option key={cat.id} value={cat.id}>{cat.name}</option>
            ))}
          </select>
          <select
            value={`${filters.sort}-${filters.order}`}
            onChange={(e) => {
              const [sort, order] = e.target.value.split('-');
              setFilters({ ...filters, sort, order });
            }}
          >
            <option value="created_at-DESC">作成日（新しい順）</option>
            <option value="created_at-ASC">作成日（古い順）</option>
            <option value="updated_at-DESC">更新日（新しい順）</option>
            <option value="updated_at-ASC">更新日（古い順）</option>
          </select>
          <button type="submit">検索</button>
        </form>
      </div>

      {posts.length === 0 ? (
        <p className="no-posts">記事がありません</p>
      ) : (
        <>
          <div className="posts">
            {posts.map(post => (
              <div key={post.id} className="post-item">
                <h2><Link to={`/posts/${post.id}`}>{post.title}</Link></h2>
                <div className="post-meta">
                  <span className="category">{post.category_name || '未分類'}</span>
                  <span className="date">{formatDate(post.created_at)}</span>
                </div>
                <p className="post-content">{post.content.substring(0, 200)}...</p>
                <div className="post-actions">
                  <Link to={`/edit/${post.id}`} className="edit-btn">編集</Link>
                  <button onClick={() => handleDelete(post.id)} className="delete-btn">削除</button>
                </div>
              </div>
            ))}
          </div>

          <div className="pagination">
            <button
              disabled={filters.page === 1}
              onClick={() => setFilters({ ...filters, page: filters.page - 1 })}
            >
              前へ
            </button>
            <span>{filters.page} / {totalPages}</span>
            <button
              disabled={filters.page === totalPages}
              onClick={() => setFilters({ ...filters, page: filters.page + 1 })}
            >
              次へ
            </button>
          </div>
        </>
      )}
    </div>
  );
}

export default PostList;