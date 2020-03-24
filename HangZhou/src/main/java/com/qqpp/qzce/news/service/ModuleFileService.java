package com.qqpp.qzce.news.service;

import org.springframework.stereotype.Component;

import com.sh.frame.base.service.BaseServiceImpl;
import com.qqpp.qzce.news.domain.ModuleFile;

@Component(value = "moduleFileService")
public class ModuleFileService extends BaseServiceImpl<ModuleFile>implements IModuleFileService {

	private static final long serialVersionUID = 1L;

	public ModuleFileService() {
		super(ModuleFile.class);
	}

}
