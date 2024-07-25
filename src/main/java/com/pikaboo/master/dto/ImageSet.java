package com.pikaboo.master.dto;

public class ImageSet {
    private String id;
    private String userName;
    private String imgUrl;
    private int likeStatus;
    private boolean privateCheck;
    public ImageSet() {

    }
    public ImageSet(String id, String userName, String imgUrl, int likeStatus, boolean privateCheck) {
        super();
        this.id = id;
        this.userName = userName;
        this.imgUrl = imgUrl;
        this.likeStatus = likeStatus;
        this.privateCheck = privateCheck;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public int getLikeStatus() {
        return likeStatus;
    }

    public void setLikeStatus(int likeStatus) {
        this.likeStatus = likeStatus;
    }

    public boolean getPrivateCheck() {
        return privateCheck;
    }


    public void setPrivateCheck(boolean privateCheck) {
        this.privateCheck = privateCheck;
    }




    @Override
    public String toString() {
        return "ImageSet{" +
                "id='" + id + '\'' +
                ", userName='" + userName + '\'' +
                ", imgUrl='" + imgUrl + '\'' +
                ", likeStatus=" + likeStatus +
                ", privateCheck=" + privateCheck +
                '}';
    }
}
