/**
 * 
 */
package com.sh.frame.constant;

/**
 * 
 * 家庭属性
 * @author ZXP
 * 
 */
public enum FamilyPropertyEnum {
	soldier(0, "军属"),partyMember(1, "党员"), fiveGuarantees(2, "五保户");
	private int value;
	private String showName;

	public int getValue() {
		return value;
	}

	public String getShowName() {
		return showName;
	}

	private FamilyPropertyEnum(int value, String name) {
		this.showName = name;
		this.value = value;
	}
}
