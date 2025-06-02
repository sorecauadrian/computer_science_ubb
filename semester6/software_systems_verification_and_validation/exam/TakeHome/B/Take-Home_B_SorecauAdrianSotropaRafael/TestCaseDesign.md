
# Test Case Design Document

## Test Design Techniques Used
- **Black-box Testing**: Focused on functional inputs and outputs (e.g., valid vs. invalid amounts, discount logic).
- **White-box Testing**: Considered code structure to ensure each branch and condition was tested.

## Test Cases

### TC1: First Order with Credit Card
- Input: amount = 100.0, isFirstOrder = true, method = CREDIT_CARD
- Expected: 10% + 5% discount → $85.00 (before tax in Version A)
- Purpose: Validate compound discounts

### TC2: Returning User with PayPal
- Input: amount = 100.0, isFirstOrder = false, method = PAYPAL
- Expected: 2% discount → $98.00
- Purpose: Validate minor discount

### TC3: Invalid Payment Amount
- Input: amount = 0.0, any user, any method
- Expected: Exception thrown (IllegalArgumentException)
- Purpose: Validate input validation

### TC4: Delivery Fee under $50
- Input: amount = 49.99
- Expected: Fee = $5.00
- Purpose: Boundary condition for delivery fee

### TC5: Delivery Fee at $50
- Input: amount = 50.00
- Expected: Fee = $0.00
- Purpose: Confirm threshold exemption

