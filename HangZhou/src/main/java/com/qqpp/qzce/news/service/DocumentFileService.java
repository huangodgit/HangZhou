package com.qqpp.qzce.news.service;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.sh.frame.base.service.BaseServiceImpl;
import com.qqpp.qzce.news.domain.DocumentFile;
import com.qqpp.qzce.news.domain.ModuleFile;

@Component(value = "documentFile")
public class DocumentFileService extends BaseServiceImpl<DocumentFile>implements IDocumentFileService {

	private static final long serialVersionUID = 1L;

	@Autowired(required = true)
	private IModuleFileService moduleFileService;

	public DocumentFileService() {
		super(DocumentFile.class);
	}

	public List<DocumentFile> getDocumentFiles(String entityName, Long id) {
		List<DocumentFile> documentFiles = new ArrayList<DocumentFile>();
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(ModuleFile.class);
		detachedCriteria.add(Restrictions.eq("type", entityName)).add(Restrictions.eq("busiId", id));
		List<ModuleFile> moduleFiles = moduleFileService.findAllByCriteria(detachedCriteria);
		if (moduleFiles.size() > 0) {
			List<Long> dfIds = new ArrayList<Long>();
			for (ModuleFile mf : moduleFiles) {
				dfIds.add(mf.getFileId());
			}
			if (dfIds.size() > 0) {
				DetachedCriteria dfdetachedCriteria = DetachedCriteria.forClass(DocumentFile.class);
				dfdetachedCriteria.add(Restrictions.in("id", dfIds));
				documentFiles = getLocalDao().findAllByCriteria(dfdetachedCriteria);
			}
		}
		return documentFiles;
	}

}
