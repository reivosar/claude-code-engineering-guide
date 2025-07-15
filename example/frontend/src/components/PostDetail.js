import React, { useState, useEffect } from 'react';
import { useParams, Link, useNavigate } from 'react-router-dom';
import axios from 'axios';

const API_URL = 'http://localhost:3001/api';

function PostDetail() {
  const { id } = useParams();
  const navigate = useNavigate();
  const [post, setPost] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    fetchPost();
  }, [id]);

  const fetchPost = async () => {
    setLoading(true);
    try {
      const response = await axios.get(`${API_URL}/posts/${id}`);
      setPost(response.data);
      setError(null);
    } catch (err) {
      setError('記事が見つかりません');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async () => {
    if (!window.confirm('この記事を削除しますか？')) return;
    
    try {
      await axios.delete(`${API_URL}/posts/${id}`);
      navigate('/');
    } catch (err) {
      alert('削除に失敗しました');
    }
  };

  const formatDate = (dateString) => {
    return new Date(dateString).toLocaleString('ja-JP');
  };

  if (loading) return <div className="loading">読み込み中...</div>;
  if (error) return <div className="error">{error}</div>;
  if (!post) return <div className="error">記事が見つかりません</div>;

  return (
    <div className="post-detail">
      <article>
        <h1>{post.title}</h1>
        <div className="post-meta">
          <span className="category">{post.category_name || '未分類'}</span>
          <span className="date">作成: {formatDate(post.created_at)}</span>
          {post.updated_at !== post.created_at && (
            <span className="date">更新: {formatDate(post.updated_at)}</span>
          )}
        </div>
        <div className="post-content">
          {post.content.split('\n').map((paragraph, index) => (
            <p key={index}>{paragraph}</p>
          ))}
        </div>
      </article>
      
      <div className="post-actions">
        <Link to="/" className="back-btn">一覧に戻る</Link>
        <Link to={`/edit/${post.id}`} className="edit-btn">編集</Link>
        <button onClick={handleDelete} className="delete-btn">削除</button>
      </div>
    </div>
  );
}

export default PostDetail;