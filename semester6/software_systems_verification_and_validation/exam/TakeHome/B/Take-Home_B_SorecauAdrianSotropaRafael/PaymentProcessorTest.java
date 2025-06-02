
package test;

import org.junit.jupiter.api.Test;
import src.PaymentProcessor;
import src.PaymentProcessor.PaymentMethod;

import static org.junit.jupiter.api.Assertions.*;

public class PaymentProcessorTest {

    PaymentProcessor processor = new PaymentProcessor();

    @Test
    public void testFirstOrderWithCreditCard() {
        double result = processor.processPayment(100.0, true, PaymentMethod.CREDIT_CARD);
        // Expected: 100 - 10% - 5% = 85 -> tax applied later in Version B
        assertEquals(85.0, result);
    }

    @Test
    public void testReturningUserWithPayPal() {
        double result = processor.processPayment(100.0, false, PaymentMethod.PAYPAL);
        // 2% discount only: 100 - 2% = 98
        assertEquals(98.0, result);
    }

    @Test
    public void testInvalidAmountThrowsException() {
        assertThrows(IllegalArgumentException.class, () -> {
            processor.processPayment(0.0, true, PaymentMethod.CASH);
        });
    }

    @Test
    public void testDeliveryFeeUnder50() {
        double fee = processor.calculateDeliveryFee(49.99);
        assertEquals(5.0, fee);
    }

    @Test
    public void testDeliveryFeeOver50() {
        double fee = processor.calculateDeliveryFee(50.0);
        assertEquals(0.0, fee);
    }
}
