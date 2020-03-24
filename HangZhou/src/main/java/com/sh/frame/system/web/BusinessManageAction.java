package com.sh.frame.system.web;

import com.google.gson.Gson;
import com.sh.frame.base.action.BaseAction;
import com.sh.frame.support.CustomExample;
import com.sh.frame.support.PaginationSupport;
import com.sh.frame.system.domain.Business;
import com.sh.frame.system.domain.Image;
import com.sh.frame.system.service.IBusinessService;
import com.sh.frame.system.service.IImageService;
import com.sh.frame.utils.JQueryDataTablesUtil;
import org.apache.struts2.ServletActionContext;
import org.hibernate.Criteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

public class BusinessManageAction extends BaseAction<Business> {
    private static final long serialVersionUID = 6950808042088342028L;

    @Autowired
    private IBusinessService businessService;

    @Autowired
    private IImageService imageService;

    private File image;//图片
    private String imageFileName;//图片保存名字(originalName)
    private String imageContentType;//图片保存类型(imageType)
    private String uploadDir;//图片保存路径(imageName)

    private Long imageId;
    private Long[] imageIds;

    private DateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSSS");
    private DateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd");

    @Override
    public void prepare() throws Exception {
        if (id != null) {
            entity = businessService.findById(id);
            entity.setTime(dateFormat2.parse(entity.getSpecialCondition().getTime()));
            entity.setState(entity.getSpecialCondition().getState());
            entity.setDescription(entity.getSpecialCondition().getDescription());
            entity.setFounder(entity.getSpecialCondition().getFounder());
        } else {
            entity = new Business();
        }
    }

    public String list() {
        return LIST;
    }

    public String insert() {
        return INSERT;
    }

    public String edit() {
        return EDIT;
    }

    public String view() {
        return VIEW;
    }

    public String image() {
        return "image";
    }

    public void save() {
        try {
            businessService.saveOrUpdate(entity);
            // 图像信息关联
            if (imageIds != null) {
                // 图像信息关联
                for (Long imageId : imageIds) {
                    Image image = imageService.findById(imageId);
                    if (image.getBusiness() == null) {
                        image.setBusiness(entity);
                        entity.getImages().add(image);
                        imageService.saveOrUpdate(image);
                    }
                }
                //建立关联
                businessService.saveOrUpdate(entity);
            }
            //建立关联
            businessService.saveOrUpdate(entity);
            businessService.flush();
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

    public void delete() {
        try {
            String path = "D:/ideaProject/HangZhou/src/main/webapp/upload";
            for (Image image : entity.getImages()) {
                File file = new File(path, image.getImageName());
                if (file.exists()) file.delete();
            }
            businessService.delete(entity);
            businessService.flush();
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
        CustomExample<Business> example = new CustomExample<Business>(this.getModel()) {
            public void appendCondition(Criteria criteria) {
                criteria.addOrder(Order.asc("id")).addOrder(Order.asc("name"));
            }
        };
        example.enableLike(MatchMode.ANYWHERE);
        this.listResult = businessService.findPageByExample(example, PaginationSupport.pageToIndex(pageNum, numPerPage),
                numPerPage);
        responseText(JQueryDataTablesUtil.prepareResponseJsonData(this.getAoData_echo(), this.getAoData_props(),
                listResult));
    }

    public void listAllForBusinessImages() {
        Gson gson = builder.excludeFieldsWithoutExposeAnnotation().create();
        responseText(gson.toJson(entity.getImages()));
    }

    public void uploadFiles() {
        // 图片保存路径
        String path = "D:/ideaProject/HangZhou/src/main/webapp/upload";
        // Session Id
        String sid = ServletActionContext.getRequest().getSession().getId();

        File imageDir = new File(path);
        if (!imageDir.exists()) imageDir.mkdirs();
        // 文件扩展名
        String extName = null;
        if (imageFileName.lastIndexOf(".") >= 0) {
            extName = imageFileName.substring(imageFileName.lastIndexOf("."));
        }
        // 新文件名
        String newName = sid + dateFormat.format(new Date()) + (new Random().nextInt(10000)) + extName;

        try {
            // 保存操作
            image.renameTo(new File(path, newName));
            Image imageEntity = new Image();
            imageEntity.setImageName(newName);
            imageEntity.setOriginalName(imageFileName);
            imageEntity.setImageType(imageContentType);
            // 文件大小
            imageEntity.setImageSize(new File(path, newName).length());

            imageService.saveOrUpdate(imageEntity);
            imageService.flush();

            msgResult.put("imageId", imageEntity.getId());
            msgResult.put("status", true);
        } catch (Exception e) {
            e.printStackTrace();
            msgResult.put("status", false);
        }
        Gson gson = builder.create();
        responseText(gson.toJson(msgResult));
    }

    //删除上传图像
    public void deleteFile() {
        msgResult.put("status", false);
        if (imageId != null) {
            ServletActionContext.getRequest().getSession();
            String path = "D:/ideaProject/HangZhou/src/main/webapp/upload";
            Image image = imageService.findById(imageId);
            File file = new File(path, image.getImageName());
            if (file.exists()) file.delete();

            try {
                imageService.delete(image);
                imageService.flush();
                msgResult.put("status", true);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        Gson gson = builder.create();
        responseText(gson.toJson(msgResult));
    }

    public IBusinessService getBusinessService() {
        return businessService;
    }

    public void setBusinessService(IBusinessService businessService) {
        this.businessService = businessService;
    }

    public IImageService getImageService() {
        return imageService;
    }

    public void setImageService(IImageService imageService) {
        this.imageService = imageService;
    }

    public File getImage() {
        return image;
    }

    public void setImage(File image) {
        this.image = image;
    }

    public String getImageContentType() {
        return imageContentType;
    }

    public void setImageContentType(String imageContentType) {
        this.imageContentType = imageContentType;
    }

    public String getImageFileName() {
        return imageFileName;
    }

    public void setImageFileName(String imageFileName) {
        this.imageFileName = imageFileName;
    }

    public String getUploadDir() {
        return uploadDir;
    }

    public void setUploadDir(String uploadDir) {
        this.uploadDir = uploadDir;
    }

    public Long getImageId() {
        return imageId;
    }

    public void setImageId(Long imageId) {
        this.imageId = imageId;
    }

    public Long[] getImageIds() {
        return imageIds;
    }

    public void setImageIds(Long[] imageIds) {
        this.imageIds = imageIds;
    }

    public DateFormat getDateFormat() {
        return dateFormat;
    }

    public void setDateFormat(DateFormat dateFormat) {
        this.dateFormat = dateFormat;
    }

}
