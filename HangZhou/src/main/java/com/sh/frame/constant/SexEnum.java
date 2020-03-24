/**
 * 
 */
package com.sh.frame.constant;

/**
 * 
 * 性别
 * 
 * @author ZXP
 * 
 */
public enum SexEnum {
	female(0, "女"), male(1, "男");
	private int value;
	private String showName;

	public int getValue() {
		return value;
	}

	public String getShowName() {
		return showName;
	}

	private SexEnum(int value, String name) {
		this.showName = name;
		this.value = value;
	}
}
