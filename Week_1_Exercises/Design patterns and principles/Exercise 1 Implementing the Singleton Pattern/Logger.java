public class Logger 
{
	private static Logger instance;
	
	private Logger() {}
	public static synchronized Logger getInstance()
	{
		if(instance==null)
			instance = new Logger();
		return instance;
	}
	public void display(String message)
	{
	System.out.println("Log:"+message);
	}	
}
package com.examle.singleton;

public class LoggerMain {

	public static void main(String[] args) {
		Logger l1 = Logger.getInstance();
		Logger l2 = Logger.getInstance();

		l1.display("This is abc");
		l2.display("This is efg");

		if (l1 == l2)
			System.out.println("Same");
		else
			System.out.println("Different");
	}
}
