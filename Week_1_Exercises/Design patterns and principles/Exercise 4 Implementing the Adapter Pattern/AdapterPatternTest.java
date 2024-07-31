public interface PaymentProcessor {
    void processPayment(double amount);
}

public class PaypalPaymentGateway {
    public void makePayment(double amount) {
        System.out.println("Processing payment of $" + amount + " through PayPal.");
    }
}

public class StripePaymentGateway {
    public void charge(double amount) {
        System.out.println("Charging $" + amount + " using Stripe.");
    }
}

public class PaypalAdapter implements PaymentProcessor {
    private PaypalPaymentGateway paypalPaymentGateway;

    public PaypalAdapter(PaypalPaymentGateway paypalPaymentGateway) {
        this.paypalPaymentGateway = paypalPaymentGateway;
    }

    public void processPayment(double amount) {
        paypalPaymentGateway.makePayment(amount);
    }
}

public class StripeAdapter implements PaymentProcessor {
    private StripePaymentGateway stripePaymentGateway;

    public StripeAdapter(StripePaymentGateway stripePaymentGateway) {
        this.stripePaymentGateway = stripePaymentGateway;
    }

    public void processPayment(double amount) {
        stripePaymentGateway.charge(amount);
    }
}

public class AdapterPatternTest {
    public static void main(String[] args) {
        PaypalPaymentGateway paypal = new PaypalPaymentGateway();
        StripePaymentGateway stripe = new StripePaymentGateway();

        PaymentProcessor paypalAdapter = new PaypalAdapter(paypal);
        PaymentProcessor stripeAdapter = new StripeAdapter(stripe);

        paypalAdapter.processPayment(100.00);
        stripeAdapter.processPayment(200.00);
    }
}
