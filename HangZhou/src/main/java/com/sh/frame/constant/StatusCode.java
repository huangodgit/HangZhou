package com.sh.frame.constant;

public enum StatusCode {
	ok("200"), error("300"), timeOut("301");

	private String message;

	StatusCode(String message) {
		this.message = message;
	}

	public String toString() {
		return this.message;
	}
}
