# When to Mock

Test pure functions directly, without mocks. For functions with side effects, mock only the system boundaries they touch, never your own pure functions.

Mock at **system boundaries** only:

- External APIs (payment, email, etc.)
- Databases (sometimes - prefer test DB)
- Time/randomness
- File system (sometimes)

Don't mock:

- Your own classes/modules
- Internal collaborators
- Anything you control

## When a seam needs its own interface

An **adapter** is a concrete implementation that fills an interface at a seam: a production client, an in-memory fake, a mock.

**One adapter means a hypothetical seam. Two adapters means a real one.** Introduce an interface only when something actually varies across it today, typically a production adapter and a test adapter. An interface with a single implementation adds indirection without letting anything be swapped. Keep the dependency inside one module instead, and extract the interface when a second adapter is needed. "We might switch databases someday" is not a second adapter.

**Your own services across a network** (microservices, internal APIs) are something you control, so don't mock them. Define a port (an interface) at the seam instead: keep the logic in one module and inject the transport as an adapter. Production uses an HTTP/gRPC/queue adapter; tests use an in-memory adapter.

## Designing for Mockability

At system boundaries, design interfaces that are easy to mock:

**1. Use dependency injection**

Pass external dependencies in rather than creating them internally:

```typescript
// Easy to mock
function processPayment(order, paymentClient) {
  return paymentClient.charge(order.total);
}

// Hard to mock
function processPayment(order) {
  const client = new StripeClient(process.env.STRIPE_KEY);
  return client.charge(order.total);
}
```

**2. Prefer SDK-style interfaces over generic fetchers**

Create specific functions for each external operation instead of one generic function with conditional logic:

```typescript
// GOOD: Each function is independently mockable
const api = {
  getUser: (id) => fetch(`/users/${id}`),
  getOrders: (userId) => fetch(`/users/${userId}/orders`),
  createOrder: (data) => fetch('/orders', { method: 'POST', body: data }),
};

// BAD: Mocking requires conditional logic inside the mock
const api = {
  fetch: (endpoint, options) => fetch(endpoint, options),
};
```

The SDK approach means:
- Each mock returns one specific shape
- No conditional logic in test setup
- Easier to see which endpoints a test exercises
- Type safety per endpoint
