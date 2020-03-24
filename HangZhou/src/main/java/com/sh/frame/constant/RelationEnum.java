/**
 * 
 */
package com.sh.frame.constant;

/**
 * 
 * 家庭关系
 * 
 * @author ZXP
 * 
 */
public enum RelationEnum {
	householder(0, "户主"), father(1, "父亲"), mother(2, "母亲"), wife(3, "妻子"), son(
			4, "儿子"), daughter(5, "女儿"), sonInLaw(6, "女婿"), daughterInLaw(7,
			"儿媳"), grandson(8, "孙子"), granddaughter(9, "孙女");
	private int value;
	private String showName;

	public int getValue() {
		return value;
	}

	public String getShowName() {
		return showName;
	}

	private RelationEnum(int value, String name) {
		this.showName = name;
		this.value = value;
	}
}
