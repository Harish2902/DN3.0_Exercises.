import java.util.ArrayList;
import java.util.List;

public interface Stock {
    void registerObserver(Observer observer);

    void deregisterObserver(Observer observer);

    void notifyObservers();
}

public class StockMarket implements Stock {
    private List<Observer> observers = new ArrayList<>();
    private double stockPrice;

    public void registerObserver(Observer observer) {
        observers.add(observer);
    }

    public void deregisterObserver(Observer observer) {
        observers.remove(observer);
    }

    public void notifyObservers() {
        for (Observer observer : observers) {
            observer.update(stockPrice);
        }
    }

    public void setStockPrice(double price) {
        this.stockPrice = price;
        notifyObservers();
    }
}

public interface Observer {
    void update(double stockPrice);
}

public class MobileApp implements Observer {
    public void update(double stockPrice) {
        System.out.println("MobileApp: Stock price updated to $" + stockPrice);
    }
}

public class WebApp implements Observer {
    public void update(double stockPrice) {
        System.out.println("WebApp: Stock price updated to $" + stockPrice);
    }
}

public class ObserverPatternTest {
    public static void main(String[] args) {
        StockMarket stockMarket = new StockMarket();
        Observer mobileApp = new MobileApp();
        Observer webApp = new WebApp();
        stockMarket.registerObserver(mobileApp);
        stockMarket.registerObserver(webApp);
        stockMarket.setStockPrice(150.75);
        stockMarket.deregisterObserver(mobileApp);
        stockMarket.setStockPrice(155.50);
    }
}
