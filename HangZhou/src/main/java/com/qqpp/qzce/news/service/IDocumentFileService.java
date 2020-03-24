package com.qqpp.qzce.news.service;

import java.util.List;

import com.sh.frame.base.service.IBaseService;
import com.qqpp.qzce.news.domain.DocumentFile;

public interface IDocumentFileService extends IBaseService<DocumentFile> {

	List<DocumentFile> getDocumentFiles(String entityName, Long id);

}
