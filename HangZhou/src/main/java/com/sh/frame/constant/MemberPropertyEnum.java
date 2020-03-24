/**
 * 
 */
package com.sh.frame.constant;

/**
 * 
 * 人口属性
 * 
 * @author ZXP
 * 
 */
public enum MemberPropertyEnum {
	local(0, "本村户籍"), out(1, "外村户籍");
	private int value;
	private String showName;

	public int getValue() {
		return value;
	}

	public String getShowName() {
		return showName;
	}

	private MemberPropertyEnum(int value, String name) {
		this.showName = name;
		this.value = value;
	}
}
