package com.sh.frame.system.service;

import java.util.Iterator;
import java.util.Stack;
import java.util.TreeSet;

import org.dom4j.DocumentFactory;
import org.dom4j.Element;

import com.sh.frame.system.domain.Module;

public class BootStrapHtmlUtil {
	/**
	 * modify by surya 如非必要，请勿使用本函数
	 * 
	 * @param allModules
	 * @return
	 */
	static public String makeMenuHtml(TreeSet<Module> allModules) {
		Iterator<Module> iterator = allModules.iterator();
		Element navlistUi = null;
		Element levelLi = null;
		Element lastSubMenu = null;
		Integer lastLevel = 0;
		Stack<Element> subMenuStack = new Stack<Element>();
		navlistUi = DocumentFactory.getInstance().createElement("ul");
		navlistUi.addAttribute("class", "nav nav-list");
		Element eli = DocumentFactory.getInstance().createElement("li");
		eli.addAttribute("class", "active");
		Element ea = DocumentFactory.getInstance().createElement("a");
		ea.addAttribute("onclick", "changeMain('main.jsp');");
		Element ei = DocumentFactory.getInstance().createElement("i");
		ei.addAttribute("class", "icon-desktop");
		ei.addText("");
		Element espan = DocumentFactory.getInstance().createElement("span");
		espan.addAttribute("class", "menu-text");
		espan.addText("主页");

		ea.add(ei);
		ea.add(espan);
		eli.add(ea);
		navlistUi.add(eli);
        int num=1;
		while (iterator.hasNext()) {
			if(num==13){
				num=1;
			}
			String pic="";
			Module module = iterator.next();
			// 没有link的子菜单
			if (module.getLink() == null || module.getLink().trim().length() < 3) {// 如没link有子菜单
				levelLi = DocumentFactory.getInstance().createElement("li");
				Element a = DocumentFactory.getInstance().createElement("a");
				a.addAttribute("class", "dropdown-toggle");
				a.addAttribute("href", module.getLink());
				// TODO 图标可定义
				Element i = DocumentFactory.getInstance().createElement("i");
				// 1级菜单-设置图标
				if (module.getLevel() != null && module.getLevel() == 1) {
					switch(num){
					case 1:pic="icon-globe";break;
					case 2:pic="icon-flag";break;
					case 3:pic="icon-group";break;
					case 4:pic="icon-legal";break;
					case 5:pic="icon-home";break;
					case 6:pic="icon-credit-card";break;
					case 7:pic="icon-rss";break;
					case 8:pic="icon-comments";break;
					case 9:pic="icon-list";break;
					case 10:pic="icon-eye-open";break;
					case 11:pic="icon-edit";break;
					case 12:pic="icon-cog";break;
					}
					num++;
					i.addAttribute("class", pic);
				}
				i.addText("");
				Element span = null;
				// 1级菜单-设置菜单名字
				if (module.getLevel() != null && module.getLevel() == 1) {
					span = DocumentFactory.getInstance().createElement("span");
					span.addAttribute("class", "menu-text");
					span.addText(module.getName());
				}
				Element b = DocumentFactory.getInstance().createElement("b");
				// 设置菜单图标-箭头
				b.addAttribute("class", "arrow icon-angle-down");
				b.addText("");
				a.add(i);
				if (span != null) {
					a.add(span);
				} else {
					a.addText(module.getName());
				}
				a.add(b);
				levelLi.add(a);
				if (lastLevel > module.getLevel() && !subMenuStack.isEmpty()) {
					lastSubMenu = subMenuStack.pop();
				}
				if (lastSubMenu != null) {
					subMenuStack.push(lastSubMenu);
				}
				//
				lastSubMenu = DocumentFactory.getInstance().createElement("ul");
				lastSubMenu.addAttribute("class", "submenu");
				levelLi.add(lastSubMenu);
			} else {
				// 带链接的菜单-leaf-叶子菜单
				levelLi = DocumentFactory.getInstance().createElement("li");
				Element a = DocumentFactory.getInstance().createElement("a");
				// a.addAttribute("target", module.getLink());
				// a.addAttribute("href", "javascript:callAction('" +
				// module.getLink() + "')");
				a.addAttribute("onclick", "changeMain('" + module.getLink() + "')");
				// TODO 图标可定义
				Element i = DocumentFactory.getInstance().createElement("i");
				// 设置菜单-图标
				i.addAttribute("class", "icon-double-angle-right");
				i.addText("");
				a.add(i);
				a.addText(module.getName());
				levelLi.add(a);
			}
			// 1级菜单
			if (module.getLevel() != null && module.getLevel() == 1) {
				// 将菜单添加到树种
				navlistUi.add(levelLi);
			} else {
				// leaf-叶子菜单
				if (module.getLink() == null || module.getLink().trim().length() < 3) {// 如有子菜单
					// 将叶子菜单添加到 子菜单中
					subMenuStack.lastElement().add(levelLi);
				} else {
					// 非叶子菜单
					if (lastSubMenu != null) {

						lastSubMenu.add(levelLi);
					}
				}
			}
			lastLevel = module.getLevel();
		}
		return navlistUi.asXML();
	}
}
