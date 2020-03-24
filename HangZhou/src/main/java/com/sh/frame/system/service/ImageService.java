package com.sh.frame.system.service;

import com.sh.frame.base.service.BaseServiceImpl;
import com.sh.frame.system.domain.Image;
import org.springframework.stereotype.Component;

@Component(value = "imageService")
public class ImageService extends BaseServiceImpl<Image> implements IImageService{

    private static final long serialVersionUID = 1L;

    public ImageService(){
        super(Image.class);
    }
}
