# コーディング規約

## TypeScript/JavaScript

```typescript
// ✅ 良い例
interface UserData {
  id: string;
  name: string;
  email: string;
  createdAt: Date;
}

export const createUser = async (data: Omit<UserData, 'id' | 'createdAt'>): Promise<UserData> => {
  try {
    const user = await db.user.create({
      data: {
        ...data,
        id: generateUuid(),
        createdAt: new Date()
      }
    });
    return user;
  } catch (error) {
    logger.error('Failed to create user', { error, data });
    throw new UserCreationError('ユーザーの作成に失敗しました');
  }
};

// ❌ 悪い例
export const createUser = async (data: any) => {
  const user = await db.user.create({ data });
  return user;
};
```

## React コンポーネント

```typescript
// ✅ 良い例
interface ButtonProps {
  children: React.ReactNode;
  onClick: () => void;
  variant?: 'primary' | 'secondary';
  disabled?: boolean;
  loading?: boolean;
}

export const Button: React.FC<ButtonProps> = ({
  children,
  onClick,
  variant = 'primary',
  disabled = false,
  loading = false
}) => {
  const handleClick = useCallback(() => {
    if (!disabled && !loading) {
      onClick();
    }
  }, [disabled, loading, onClick]);

  return (
    <button
      className={cn(
        'px-4 py-2 rounded-lg font-medium transition-colors',
        {
          'bg-blue-600 text-white hover:bg-blue-700': variant === 'primary',
          'bg-gray-200 text-gray-800 hover:bg-gray-300': variant === 'secondary',
          'opacity-50 cursor-not-allowed': disabled || loading
        }
      )}
      onClick={handleClick}
      disabled={disabled || loading}
      aria-busy={loading}
    >
      {loading ? <Spinner /> : children}
    </button>
  );
};
```

## エラーハンドリング

```typescript
// ✅ 包括的なエラーハンドリング
class APIError extends Error {
  constructor(
    message: string,
    public statusCode: number,
    public code: string,
    public details?: unknown
  ) {
    super(message);
    this.name = 'APIError';
  }
}

export const apiCall = async <T>(
  method: string,
  endpoint: string,
  data?: unknown
): Promise<T> => {
  try {
    const response = await fetch(endpoint, {
      method,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${getToken()}`
      },
      body: data ? JSON.stringify(data) : undefined
    });

    if (!response.ok) {
      const error = await response.json();
      throw new APIError(
        error.message || 'API call failed',
        response.status,
        error.code || 'UNKNOWN_ERROR',
        error.details
      );
    }

    return response.json();
  } catch (error) {
    if (error instanceof APIError) {
      throw error;
    }
    
    logger.error('Unexpected error in API call', { error, method, endpoint });
    throw new APIError(
      'ネットワークエラーが発生しました',
      0,
      'NETWORK_ERROR'
    );
  }
};
```

---
[← 開発ワークフロー](workflow.md) | [セキュリティガイドライン →](../security/overview.md)