package org.kosta.borrow.exception;

public class BalanceShortageException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public BalanceShortageException(String message) {
		super(message);
	}

	public BalanceShortageException() {
		super("포인트 부족");
	}
	
	
	
	
}
