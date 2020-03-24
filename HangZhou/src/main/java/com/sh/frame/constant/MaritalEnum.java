/**
 * 
 */
package com.sh.frame.constant;

/**
 * 
 * 婚姻状况
 * 
 * @author ZXP
 * 
 */
public enum MaritalEnum {
	married(0, "已婚"), single(1, "未婚"), divorced(2, "离异");
	private int value;
	private String showName;

	public int getValue() {
		return value;
	}

	public String getShowName() {
		return showName;
	}

	private MaritalEnum(int value, String name) {
		this.showName = name;
		this.value = value;
	}
}
