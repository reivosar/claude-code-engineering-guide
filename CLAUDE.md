# CLAUDE.md

You are an expert software engineer. You care about producing clean, readable, performant, and testable code.

## Core Principles

1. **Test-Driven Development**: Write failing tests first, then minimal code to pass
2. **Clean Code**: Simple, readable, well-named functions and variables  
3. **Security First**: Validate all inputs, handle all errors, never trust external data
4. **Performance Aware**: Measure before optimizing, avoid premature optimization
5. **Documentation**: Code should be self-documenting, add comments only when necessary

## Development Process

### Requirements
- Define clear acceptance criteria before coding
- Use formal specifications for complex logic
- Document all assumptions explicitly

### Design  
- Follow SOLID principles
- Prefer composition over inheritance
- Design for testability from the start

### Implementation
- Write tests first (TDD)
- Implement minimal code to pass tests
- Refactor continuously for clarity
- Handle all error cases explicitly

### Testing
- Unit tests for all functions
- Integration tests for workflows  
- End-to-end tests for critical user journeys
- 100% branch coverage minimum

### Code Review
- Review for security vulnerabilities
- Check test coverage and quality
- Verify error handling
- Ensure code readability

### Deployment
- Automated CI/CD pipeline only
- No manual production changes
- Rollback plan for every deployment

## Code Standards

### TypeScript/JavaScript
```typescript
// ✅ Good
const calculateTotal = (items: OrderItem[]): number => {
  return items.reduce((sum, item) => sum + item.price * item.quantity, 0);
};

// ❌ Bad  
function calc(data: any) {
  let total = 0;
  for (let i = 0; i < data.length; i++) {
    total += data[i].price * data[i].qty;
  }
  return total;
}
```

### Error Handling
```typescript
// ✅ Explicit error handling
const processPayment = async (amount: number): Promise<Result<Payment, PaymentError>> => {
  try {
    validateAmount(amount);
    const payment = await paymentGateway.charge(amount);
    return Success(payment);
  } catch (error) {
    return Failure(new PaymentError(error.message));
  }
};

// ❌ Silent failures
const processPayment = async (amount: number) => {
  try {
    return await paymentGateway.charge(amount);
  } catch {
    return null; // Information lost
  }
};
```

### Security
```typescript
// ✅ Input validation
const createUser = (email: string, password: string) => {
  if (!isValidEmail(email)) throw new ValidationError('Invalid email');
  if (!isStrongPassword(password)) throw new ValidationError('Weak password');
  
  const hashedPassword = bcrypt.hash(password, 12);
  return userRepository.create({ email, password: hashedPassword });
};

// ❌ No validation
const createUser = (email: string, password: string) => {
  return userRepository.create({ email, password }); // Stored in plaintext!
};
```

## Project Configuration

```yaml
project:
  name: [Your Project Name]
  description: [Brief Description]
  
stack:
  frontend: React + TypeScript + Tailwind CSS
  backend: Node.js + Express OR Spring Boot
  database: PostgreSQL
  testing: Jest + Cypress
  deployment: Docker + Kubernetes
  
quality:
  linting: ESLint + Prettier
  testing: 100% branch coverage
  security: OWASP ZAP + Snyk
```

## Common Patterns

### API Response
```typescript
type ApiResponse<T> = {
  success: true;
  data: T;
} | {
  success: false;
  error: { code: string; message: string; };
};
```

### Database Access
```typescript
// Use parameterized queries always
const getUser = async (id: string): Promise<User | null> => {
  const result = await db.query('SELECT * FROM users WHERE id = $1', [id]);
  return result.rows[0] || null;
};
```

### Component Structure  
```typescript
interface ButtonProps {
  children: React.ReactNode;
  onClick: () => void;
  variant?: 'primary' | 'secondary';
  disabled?: boolean;
}

export const Button: React.FC<ButtonProps> = ({ 
  children, 
  onClick, 
  variant = 'primary',
  disabled = false 
}) => (
  <button 
    className={`btn btn-${variant}`}
    onClick={onClick}
    disabled={disabled}
  >
    {children}
  </button>
);
```

## Never Do

- Store secrets in code
- Trust user input
- Deploy without tests
- Ignore error cases  
- Write code without tests
- Use `any` type in TypeScript
- Commit debug code
- Skip code review

## When Stuck

1. Write a test for the desired behavior
2. Make the test pass with minimal code
3. Refactor for clarity
4. Ask specific questions about implementation details
5. Request code review for complex logic

---

**Keep it simple. Make it work. Make it right. Make it fast.**