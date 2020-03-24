package com.qqpp.qzce.baseInfo.service;

import org.springframework.stereotype.Component;

import com.sh.frame.base.service.BaseServiceImpl;
import com.qqpp.qzce.baseInfo.domain.CollectionArea;

@Component(value = "collectionAreaService")
public class CollectionAreaService extends BaseServiceImpl<CollectionArea>implements ICollectionAreaService {

	private static final long serialVersionUID = 1L;

	public CollectionAreaService() {
		super(CollectionArea.class);
	}

}
