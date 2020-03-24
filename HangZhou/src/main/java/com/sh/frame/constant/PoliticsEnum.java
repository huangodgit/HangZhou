/**
 * 
 */
package com.sh.frame.constant;

/**
 * 
 * 政治面貌
 * 
 * @author ZXP
 * 
 */
public enum PoliticsEnum {
	partyMember(0, "中共党员 "), LeagueMember(1, "共青团员"), masses(2, "群众");
	private int value;
	private String showName;

	public int getValue() {
		return value;
	}

	public String getShowName() {
		return showName;
	}

	private PoliticsEnum(int value, String name) {
		this.showName = name;
		this.value = value;
	}
}
