
# Regression Testing Strategy

## Overview
After fixing the bug in `processPayment` (i.e., applying tax after discount instead of before),
a regression testing process is needed to ensure existing functionality is not broken.

## Strategy

### 1. Retest All Affected Functionalities
The main function affected is `processPayment`, so all tests related to it must be re-executed:
- **TC1**: First Order with Credit Card
- **TC2**: Returning User with PayPal
- **TC3**: Invalid Payment Amount

### 2. Selective Retest (Unrelated Functions)
- **TC4 & TC5** test `calculateDeliveryFee`, which is **unaffected** by the bug fix.
- However, as a safety measure, we re-execute them due to the interaction with `processPayment`.

## Justification
- Tests selected based on **direct impact of the fix**.
- Full re-execution of all tests is feasible due to small size.
- Ensures confidence that discount/tax calculations and edge cases remain valid.

## Conclusion
We recommend re-running the full test suite as the cost is minimal and confidence gain is high.
