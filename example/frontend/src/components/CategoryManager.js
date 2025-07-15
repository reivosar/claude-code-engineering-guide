import React, { useState, useEffect } from 'react';
import axios from 'axios';

const API_URL = 'http://localhost:3001/api';

function CategoryManager() {
  const [categories, setCategories] = useState([]);
  const [newCategory, setNewCategory] = useState('');
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    fetchCategories();
  }, []);

  const fetchCategories = async () => {
    setLoading(true);
    try {
      const response = await axios.get(`${API_URL}/categories`);
      setCategories(response.data);
      setError(null);
    } catch (err) {
      setError('カテゴリーの取得に失敗しました');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    
    if (!newCategory.trim()) {
      setError('カテゴリー名を入力してください');
      return;
    }

    try {
      await axios.post(`${API_URL}/categories`, { name: newCategory });
      setNewCategory('');
      fetchCategories();
      setError(null);
    } catch (err) {
      if (err.response?.status === 409) {
        setError('このカテゴリーは既に存在します');
      } else {
        setError('カテゴリーの作成に失敗しました');
      }
    }
  };

  const handleDelete = async (id, name) => {
    if (!window.confirm(`カテゴリー「${name}」を削除しますか？`)) return;
    
    try {
      await axios.delete(`${API_URL}/categories/${id}`);
      fetchCategories();
      setError(null);
    } catch (err) {
      if (err.response?.status === 409) {
        setError('記事が存在するカテゴリーは削除できません');
      } else {
        setError('削除に失敗しました');
      }
    }
  };

  if (loading) return <div className="loading">読み込み中...</div>;

  return (
    <div className="category-manager">
      <h2>カテゴリー管理</h2>
      
      {error && <div className="error">{error}</div>}
      
      <form onSubmit={handleSubmit} className="category-form">
        <input
          type="text"
          value={newCategory}
          onChange={(e) => setNewCategory(e.target.value)}
          placeholder="新しいカテゴリー名"
        />
        <button type="submit">追加</button>
      </form>

      <div className="category-list">
        <h3>既存のカテゴリー</h3>
        {categories.length === 0 ? (
          <p>カテゴリーがありません</p>
        ) : (
          <ul>
            {categories.map(cat => (
              <li key={cat.id}>
                <span>{cat.name}</span>
                <button
                  onClick={() => handleDelete(cat.id, cat.name)}
                  className="delete-btn"
                >
                  削除
                </button>
              </li>
            ))}
          </ul>
        )}
      </div>
    </div>
  );
}

export default CategoryManager;