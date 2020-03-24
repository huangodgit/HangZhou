package com.sh.frame.constant;


public class SystemContant {

	public final static String CURRENT_USER = "LOGINUSER";
	public final static String CURRENT_USER_ROLES = "_current_user_roles";
	public final static String CURRENT_USER_ORGS = "_current_user_orgs";
	public final static String TEMP_FILE = "tmp_file";
	public final static String TEMP_FILE_ATTACH = "attach_file";
	public static final String NOT_RESOURCE_PATH = ".*/((login)|(upload)|(BaseInfo)|(mainmap)|(logout)|(app)|(rest)|(develop)|(soil)|(static)|(common)|(css)|(images)|(js)|(vendor)|(Touch)|(BaseInfo\\/Town\\/getAreaData)|(BaseInfo\\/Town\\/getTown)|(BaseInfo\\/Village\\/getVillage)|(CivilizationPoints\\/FamilyCivilizationPointsDeductRecords\\/listLast)|(Schedule\\/Schedule\\/listAll)|(BaseInfo\\/Member\\/listAllPoliticsForIndex)|(BaseInfo\\/Family\\/listAll)|(BaseInfo\\/Member\\/listAll)|(PartyMember\\/VillagePartyMember\\/listAllForActivityTime)|(BaseInfo\\/DataStatistics\\/listAll)|(LivelihoodNews\\/VillageLivelihoodNews\\/listAll)|(403)).*";	//不对匹配该值的访问路径拦截（正则）
	public static final String GOTOLOGIN = "/login.jsp";	

	static {
	}
	
}
