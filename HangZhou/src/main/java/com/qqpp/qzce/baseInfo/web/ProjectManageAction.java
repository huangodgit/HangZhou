package com.qqpp.qzce.baseInfo.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;

import com.google.gson.Gson;
import com.sh.frame.base.action.BaseAction;
import com.sh.frame.support.CustomExample;
import com.sh.frame.support.PaginationSupport;
import com.sh.frame.utils.JQueryDataTablesUtil;
import com.qqpp.qzce.baseInfo.domain.CollectionArea;
import com.qqpp.qzce.baseInfo.domain.Enterprise;
import com.qqpp.qzce.baseInfo.domain.Project;
import com.qqpp.qzce.baseInfo.domain.ProjectProgress;
import com.qqpp.qzce.baseInfo.service.ICollectionAreaService;
import com.qqpp.qzce.baseInfo.service.IEnterpriseService;
import com.qqpp.qzce.baseInfo.service.IProjectProgressService;
import com.qqpp.qzce.baseInfo.service.IProjectService;
import com.qqpp.qzce.news.domain.DocumentFile;
import com.qqpp.qzce.news.domain.ModuleFile;
import com.qqpp.qzce.news.service.IDocumentFileService;
import com.qqpp.qzce.news.service.IModuleFileService;

public class ProjectManageAction extends BaseAction<Project> {
	private static final long serialVersionUID = 6950808042088342028L;

	@Autowired(required = true)
	private IProjectService projectService;

	private File file;  //input表单中传递过来的文件，命名与input的name属性一致
	private String fileFileName;  
	private String fileContentType; //文件内容类型
	private String uploadDir; //上传相关变量
	private String finalPath; //上传相关变量
	private String fileId; //文件ID
	private Long areaId;

	
	private String filePath;
	private String fileMIME;
	private String fileName;
	@Autowired(required = true)
	private IDocumentFileService documentFileService;

	@Autowired(required = true)
	private ICollectionAreaService collectionAreaService;

	@Autowired(required = true)
	private IEnterpriseService enterpriseService;
	
	@Autowired(required = true)
	private IProjectProgressService projectProgressService;

	private Enterprise enterprise;
	private ProjectProgress tmpProjectProgress;

	private Long enterpriseId;

	private Double swlng;
	private Double swlat;
	private Double nelng;
	private Double nelat;

	@Autowired(required = true)
	private IModuleFileService moduleFileService;
	@Override
	public void prepare() throws Exception {
		if (id != null) {
			entity = projectService.findById(id);
		} else {
			entity = new Project();
		}
	}

	public String insert() {
		return INSERT;
	}

	public String edit() {
		//将文件信息传出
		//查询符合条件的记录  以便于筛选文件

		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(ModuleFile.class);
		detachedCriteria.add(Restrictions.eq("type", entity.getClass().getSimpleName()))
		.add(Restrictions.eq("busiId", entity.getId()));
		List<ModuleFile> moduleFiles = moduleFileService.findAllByCriteria(detachedCriteria);
		if(moduleFiles.size()>0){
			for(ModuleFile mf : moduleFiles){
				DocumentFile documentFile = new DocumentFile();
				documentFile = documentFileService.findById(mf.getFileId());
				String[] fileType = documentFile.getDocumentType().split("/");
				if(fileType[0].equals("image")){
					if(finalPath != null)finalPath += ",";
					else if(finalPath == null)finalPath ="";
					finalPath += (documentFile.getFilePath().substring(1));
				}else{
					if(finalPath != null)finalPath += ",";
					else if(finalPath == null)finalPath ="";
					finalPath += "images/file_module.jpg";
				}

				if(fileFileName !=null)fileFileName += ",";
				else if(fileFileName == null)fileFileName ="";
				fileFileName += documentFile.getName();

				if(fileId != null)fileId +=",";
				else if(fileId == null)fileId ="";
				fileId += documentFile.getId();

			}
		}

		return EDIT;
	}

	public String view() {

		//将文件信息传出
		//查询符合条件的记录  以便于筛选文件

		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(ModuleFile.class);
		detachedCriteria.add(Restrictions.eq("type", entity.getClass().getSimpleName()))
		.add(Restrictions.eq("busiId", entity.getId()));
		List<ModuleFile> moduleFiles = moduleFileService.findAllByCriteria(detachedCriteria);
		if(moduleFiles.size()>0){
			for(ModuleFile mf : moduleFiles){
				DocumentFile documentFile = new DocumentFile();
				documentFile = documentFileService.findById(mf.getFileId());
				String[] fileType = documentFile.getDocumentType().split("/");
				if(fileType[0].equals("image")){
					if(finalPath != null)finalPath += ",";
					else if(finalPath == null)finalPath ="";
					finalPath += (documentFile.getFilePath().substring(1));
					if(fileContentType !=null)fileContentType +=",";
					else if(fileContentType ==null)fileContentType ="";
					fileContentType +="image";
				}else{
					if(finalPath != null)finalPath += ",";
					else if(finalPath == null)finalPath ="";
					finalPath += "images/file_module.jpg";
					if(fileContentType !=null)fileContentType +=",";
					else if(fileContentType ==null)fileContentType ="";
					fileContentType += "file"; 
				}

				if(fileFileName !=null)fileFileName += ",";
				else if(fileFileName == null)fileFileName ="";
				fileFileName += documentFile.getName();

				if(fileId != null)fileId +=",";
				else if(fileId == null)fileId ="";
				fileId += documentFile.getId();

			}
		}

		return VIEW;
	}

	public void save() {
		try {

			if(enterpriseId!=null){
				enterprise=enterpriseService.findById(enterpriseId);
				entity.setEnterprise(enterprise);
			}
			if(id==null){
			entity.setProjectNewestProgress("未开始");
			}
			projectService.saveOrUpdate(entity);
			projectService.flush();
			// 文件保存
			if(fileContentType !=null && fileFileName != null &&finalPath !=null&& !finalPath.isEmpty()){
				String[] fileFileNames = fileFileName.split(",");
				String[] finalPaths = finalPath.split(",");
				String[] fileContentTypes = fileContentType.split(",");
				for(int i=0;i<fileFileNames.length;i++){
					DocumentFile documentFile = new DocumentFile();
					ModuleFile moduleFile = new ModuleFile();
					documentFile.setDocumentType(fileContentTypes[i]);
					documentFile.setFilePath(finalPaths[i]);
					documentFile.setName(fileFileNames[i]);
					documentFileService.saveOrUpdate(documentFile);
					moduleFile.setBusiId(entity.getId());
					moduleFile.setType(entityClass.getSimpleName());
					moduleFile.setFileId(documentFile.getId());
					moduleFileService.saveOrUpdate(moduleFile);
				}
			}


			msgResult.put("status", true);
			msgResult.put("info", "保存成功");
		} catch (Exception e) {
			e.printStackTrace();
			msgResult.put("status", false);
			msgResult.put("info", "保存失败");
		}
		Gson gson = builder.create();
		responseHtml(gson.toJson(msgResult));
	}

	public String list() {
		return LIST;
	}

	public void delete() {
		try {
			projectService.delete(entity);
			projectService.flush();
			msgResult.put("status", true);
			msgResult.put("info", "删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			msgResult.put("status", false);
			msgResult.put("info", "删除失败");
		}
		Gson gson = builder.create();
		responseHtml(gson.toJson(msgResult));
	}

	public void listAllForJQueryDataTable() {
		CustomExample<Project> example = new CustomExample<Project>(this.getModel()) {
			private static final long serialVersionUID = 1L;

			public void appendCondition(Criteria criteria) {
				criteria.addOrder(Order.desc("id"));
			}
		};
		example.enableLike(MatchMode.ANYWHERE);
		this.listResult = projectService.findPageByExample(example,
				PaginationSupport.pageToIndex(pageNum, numPerPage), numPerPage);
		responseText(JQueryDataTablesUtil.prepareResponseJsonData(this.getAoData_echo(), this.getAoData_props(), listResult));
	}

	public String listForSelect() {
		CustomExample<Project> example = new CustomExample<Project>(this.getModel()) {
			private static final long serialVersionUID = 1L;

			public void appendCondition(Criteria criteria) {

			}
		};
		example.enableLike(MatchMode.ANYWHERE);
		this.listResult = projectService.findPageByExample(example,
				PaginationSupport.pageToIndex(pageNum, numPerPage), numPerPage);
		return "listForSelect";
	}

	//TODO 图片上传处理临时文件 
	//TODO 临时文件的删除
	public void uploadFiles(){

		if(fileFileName.indexOf(",") != -1 || fileFileName.indexOf("，") != -1){
			fileFileName = fileFileName.replace(",", "");
			fileFileName = fileFileName.replace("，", "");
		}
		String path=ServletActionContext.getServletContext().getRealPath(uploadDir);
		HttpServletRequest request = ServletActionContext.getRequest();
		String sessID = request.getSession().getId();
		File dir = new File(path);
		String extName = "";//扩展名
		String newFileName= "";//新文件名
		//如果目录不存在，则创建
		if(!dir.exists()){
			dir.mkdirs();
		}
		String nowTime = new SimpleDateFormat("yyyyMMddHHmmss_SSSS").format(new Date());//当前时间

		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");

		if(fileFileName.lastIndexOf(".")>=0){
			extName = fileFileName.substring(fileFileName.lastIndexOf("."));
		}
		newFileName =sessID+nowTime+ (new Random().nextInt(10000))+extName;
		file.renameTo(new File(path,newFileName));
		msgResult.put("DocumentType", fileContentType);
		msgResult.put("FilePath", uploadDir+"/"+newFileName);
		msgResult.put("Name", fileFileName);
		Gson gson = builder.create();
		responseText(gson.toJson(msgResult));


	}

	public void fileDelete(){
		try{
			if(fileId !=null){

				DocumentFile documentFile = documentFileService.findById(Long.parseLong(fileId));
				DetachedCriteria dc = DetachedCriteria.forClass(ModuleFile.class);
				dc.add(Restrictions.eq("fileId", Long.parseLong(fileId)));
				ModuleFile moduleFile = moduleFileService.findAllByCriteria(dc).get(0);
				File file = new File(ServletActionContext.getServletContext().getRealPath(documentFile.getFilePath()));
				file.delete();
				moduleFileService.delete(moduleFile);
				documentFileService.delete(documentFile);
				msgResult.put("info", "图片删除成功");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		Gson gson = builder.create();
		responseHtml(gson.toJson(msgResult));
	}

	public void fileDown(){
		try {
			DocumentFile documentFile = documentFileService.findById(Long.parseLong(fileId));
			File serverFile = new File(ServletActionContext.getServletContext().getRealPath(documentFile.getFilePath()));
			fileFileName = java.net.URLEncoder.encode(documentFile.getName(),"utf-8");
			HttpServletResponse response = ServletActionContext.getResponse();
			response.setHeader("Content-disposition", "attachment;filename="+fileFileName);

			long fileLength=serverFile.length();  
			String length=String.valueOf(fileLength);  
			response.setHeader("content_Length",length);

			OutputStream servletOutPutStream = response.getOutputStream();
			FileInputStream fileInputStream = new FileInputStream(serverFile);

			byte bytes[] = new byte[1024];
			int len = 0;
			while((len = fileInputStream.read(bytes))!=-1){
				servletOutPutStream.write(bytes,0,len);
			}
			servletOutPutStream.close();
			fileInputStream.close();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}catch(Exception e){
			e.printStackTrace();
		}
	}


	public void listAllForCollectionArea(){
		try{
			if(swlng != null){
				String swlngT = swlng.toString();
				String swlatT = swlat.toString();
				String nelngT = nelng.toString();
				String nelatT = nelat.toString();
				List<Project> list = projectService.findAllByBoundary(swlngT, swlatT, nelngT, nelatT);
				List<Object> lo = new ArrayList<>();
				for (Project object : list){
					if(object==null){
						continue;
					}
					Project project = projectService.findById(object.getId());
					if(project.getCollectionArea()!=null){
						object.setAttribute(true);
					}else{
						object.setAttribute(false);
					}
					lo.add(object);
				}

				responseText(JQueryDataTablesUtil.beanToJson(lo));
			}

		}catch(Exception e){
			e.printStackTrace();
		}
	}
	/**
	 * 与聚集区关联（单条数据）
	 */
	public void relation(){
		try{
			CollectionArea area=collectionAreaService.findById(areaId);
			entity.setCollectionArea(area);
			projectService.saveOrUpdate(entity);
			projectService.flush();
			msgResult.put("status", true);
			msgResult.put("info", "关联成功");
		}catch(Exception e){
			e.printStackTrace();
			msgResult.put("status", false);
			msgResult.put("info", "关联失败");
		}
		Gson gson = builder.create();
		responseHtml(gson.toJson(msgResult));

	}

	public void canclerelation(){
		try{
			entity.setCollectionArea(null);
			projectService.saveOrUpdate(entity);
			projectService.flush();
			msgResult.put("status", true);
			msgResult.put("info", "取消关联成功");
		}catch(Exception e){
			e.printStackTrace();
			msgResult.put("status", false);
			msgResult.put("info", "取消关联失败");
		}
		Gson gson = builder.create();
		responseHtml(gson.toJson(msgResult));
	}

	
	public String progressUp(){
		return "progressUp";
	}
	
	@SuppressWarnings("unchecked")
	public String getProgress(){

		return "getProgress";
	}

	public void save_Progress(){
		if(tmpProjectProgress.getProgressInfo() != null && tmpProjectProgress.getProgressStatus() != null){
			try{
				List<ProjectProgress> progress = entity.getProjectProgress();
				tmpProjectProgress.setOperator(loginUser.getName());
				tmpProjectProgress.setOperateTime(new Date());
				tmpProjectProgress.setProject(entity);
				projectProgressService.saveOrUpdate(tmpProjectProgress);
				entity.setProjectNewestProgress(tmpProjectProgress.getProgressStatus());
				progress.add(tmpProjectProgress);
				projectService.saveOrUpdate(entity);
				msgResult.put("status", true);
				msgResult.put("info", "保存成功");
			} catch (Exception e) {
				e.printStackTrace();
				msgResult.put("status", false);
				msgResult.put("info", "保存失败");
			}
			if(fileName != null && fileName.indexOf(",") >= 0){
				boolean b = saveFile(tmpProjectProgress.getId(),tmpProjectProgress.getClass().getSimpleName());
				if(!b){
					msgResult.put("status", false);
					msgResult.put("info", "保存失败,文件存储异常");
				}
			}
		}else{
			msgResult.put("status", false);
			msgResult.put("info", "保存失败,信息不完整");
		}
		Gson gson = builder.create();
		responseHtml(gson.toJson(msgResult));
	}

	private boolean saveFile(Long id,String className){
		if(id == null){
			id = entity.getId();
		}
		if(className == null){
			className = entityClass.getSimpleName();
		}
		boolean b = false;
		try{
			if(fileName != null && !fileName.equals("")){
				String[] fileNameArr = fileName.split(",");
				String[] filePathArr = filePath.split(",");
				String[] fileMIMEArr = fileMIME.split(",");
				for(int i=0;i<fileNameArr.length;i++){
					if(fileNameArr[i].length() > 0){
						DocumentFile documentFile = new DocumentFile();
						ModuleFile moduleFile = new ModuleFile();
						documentFile.setDocumentType(fileMIMEArr[i]);
						documentFile.setFilePath(filePathArr[i]);
						documentFile.setName(fileNameArr[i]);
						documentFileService.saveOrUpdate(documentFile);
						moduleFile.setBusiId(id);
						moduleFile.setType(className);
						moduleFile.setFileId(documentFile.getId());
						moduleFileService.saveOrUpdate(moduleFile);
						b = true;
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			b = false;
		}
		return b;
	}
	
	public String viewProgress(){
		tmpProjectProgress=projectProgressService.findById(id);
		showFiles(tmpProjectProgress.getClass().getSimpleName(),tmpProjectProgress.getId());
		return "viewProgress";
	}
	
	private void showFiles(String type,Long id){
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(ModuleFile.class);
		detachedCriteria.add(Restrictions.eq("type", type))
		.add(Restrictions.eq("busiId", id));
		List<ModuleFile> moduleFiles = moduleFileService.findAllByCriteria(detachedCriteria);
		if(moduleFiles.size()>0){
			for(ModuleFile mf : moduleFiles){
				DocumentFile documentFile = new DocumentFile();
				documentFile = documentFileService.findById(mf.getFileId());
				String[] fileType = documentFile.getDocumentType().split("/");
				if(fileType[0].equals("image")){
					if(filePath != null)filePath += ",";
					else if(filePath == null)filePath ="";
					filePath += (documentFile.getFilePath().substring(1));
					if(fileMIME !=null)fileMIME +=",";
					else if(fileMIME ==null)fileMIME ="";
					fileMIME +="image";
				}else{
					if(filePath != null)filePath += ",";
					else if(filePath == null)filePath ="";
					filePath += "images/file_module.jpg";
					if(fileMIME !=null)fileMIME +=",";
					else if(fileMIME ==null)fileMIME ="";
					fileMIME += "file"; 
				}

				if(fileName !=null)fileName += ",";
				else if(fileName == null)fileName ="";
				fileName += documentFile.getName();

				if(fileId != null)fileId +=",";
				else if(fileId == null)fileId ="";
				fileId += documentFile.getId();

			}
		}
	}
	
	
	public Long getEnterpriseId() {
		return enterpriseId;
	}

	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public String getFileFileName() {
		return fileFileName;
	}

	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}

	public String getFileContentType() {
		return fileContentType;
	}

	public void setFileContentType(String fileContentType) {
		this.fileContentType = fileContentType;
	}


	public String getUploadDir() {
		return uploadDir;
	}

	public void setUploadDir(String uploadDir) {
		this.uploadDir = uploadDir;
	}

	public String getFinalPath() {
		return finalPath;
	}

	public void setFinalPath(String finalPath) {
		this.finalPath = finalPath;
	}

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public Double getSwlng() {
		return swlng;
	}

	public void setSwlng(Double swlng) {
		this.swlng = swlng;
	}

	public Double getSwlat() {
		return swlat;
	}

	public void setSwlat(Double swlat) {
		this.swlat = swlat;
	}

	public Double getNelng() {
		return nelng;
	}

	public void setNelng(Double nelng) {
		this.nelng = nelng;
	}

	public Double getNelat() {
		return nelat;
	}

	public void setNelat(Double nelat) {
		this.nelat = nelat;
	}

	public Long getAreaId() {
		return areaId;
	}

	public void setAreaId(Long areaId) {
		this.areaId = areaId;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getFileMIME() {
		return fileMIME;
	}

	public void setFileMIME(String fileMIME) {
		this.fileMIME = fileMIME;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public ProjectProgress getTmpProjectProgress() {
		return tmpProjectProgress;
	}

	public void setTmpProjectProgress(ProjectProgress tmpProjectProgress) {
		this.tmpProjectProgress = tmpProjectProgress;
	}



}
