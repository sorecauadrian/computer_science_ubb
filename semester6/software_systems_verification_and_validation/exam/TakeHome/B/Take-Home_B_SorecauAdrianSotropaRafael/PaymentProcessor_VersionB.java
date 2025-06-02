
package src;

public class PaymentProcessor {

    public enum PaymentMethod {
        CREDIT_CARD, PAYPAL, CASH
    }

    public double processPayment(double amount, boolean isFirstOrder, PaymentMethod method) {
        if (amount <= 0) {
            throw new IllegalArgumentException("Amount must be positive");
        }

        double discount = 0.0;

        if (isFirstOrder) {
            discount += 0.1; // 10% discount for first order
        }

        switch (method) {
            case CREDIT_CARD:
                discount += 0.05;
                break;
            case PAYPAL:
                discount += 0.02;
                break;
        }

        // FIXED: Apply tax after discount
        double discountedAmount = amount * (1 - discount);
        double finalAmount = discountedAmount * (1 + 0.15);  // apply 15% tax

        return Math.round(finalAmount * 100.0) / 100.0;
    }

    public double calculateDeliveryFee(double amount) {
        return amount < 50.0 ? 5.0 : 0.0;
    }
}
