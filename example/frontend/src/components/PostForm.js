import React, { useState, useEffect } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import axios from 'axios';

const API_URL = 'http://localhost:3001/api';

function PostForm() {
  const navigate = useNavigate();
  const { id } = useParams();
  const isEdit = !!id;
  
  const [post, setPost] = useState({
    title: '',
    content: '',
    category_id: ''
  });
  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    fetchCategories();
    if (isEdit) {
      fetchPost();
    }
  }, [id]);

  const fetchCategories = async () => {
    try {
      const response = await axios.get(`${API_URL}/categories`);
      setCategories(response.data);
    } catch (err) {
      console.error('Failed to fetch categories:', err);
    }
  };

  const fetchPost = async () => {
    try {
      const response = await axios.get(`${API_URL}/posts/${id}`);
      setPost({
        title: response.data.title,
        content: response.data.content,
        category_id: response.data.category_id || ''
      });
    } catch (err) {
      setError('記事の取得に失敗しました');
      console.error(err);
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    
    if (!post.title.trim() || !post.content.trim()) {
      setError('タイトルと本文は必須です');
      return;
    }

    setLoading(true);
    setError(null);

    try {
      if (isEdit) {
        await axios.put(`${API_URL}/posts/${id}`, post);
      } else {
        await axios.post(`${API_URL}/posts`, post);
      }
      navigate('/');
    } catch (err) {
      setError('保存に失敗しました');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    setPost({ ...post, [name]: value });
  };

  return (
    <div className="post-form">
      <h2>{isEdit ? '記事編集' : '新規投稿'}</h2>
      
      {error && <div className="error">{error}</div>}
      
      <form onSubmit={handleSubmit}>
        <div className="form-group">
          <label htmlFor="title">タイトル</label>
          <input
            type="text"
            id="title"
            name="title"
            value={post.title}
            onChange={handleChange}
            placeholder="記事のタイトルを入力"
            required
          />
        </div>

        <div className="form-group">
          <label htmlFor="category_id">カテゴリー</label>
          <select
            id="category_id"
            name="category_id"
            value={post.category_id}
            onChange={handleChange}
          >
            <option value="">未分類</option>
            {categories.map(cat => (
              <option key={cat.id} value={cat.id}>{cat.name}</option>
            ))}
          </select>
        </div>

        <div className="form-group">
          <label htmlFor="content">本文</label>
          <textarea
            id="content"
            name="content"
            value={post.content}
            onChange={handleChange}
            placeholder="記事の本文を入力"
            rows="15"
            required
          />
        </div>

        <div className="form-actions">
          <button type="button" onClick={() => navigate(-1)} className="cancel-btn">
            キャンセル
          </button>
          <button type="submit" disabled={loading} className="submit-btn">
            {loading ? '保存中...' : (isEdit ? '更新' : '投稿')}
          </button>
        </div>
      </form>
    </div>
  );
}

export default PostForm;