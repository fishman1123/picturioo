package com.pikaboo.master.dto;

import java.time.LocalDateTime;

public class ImageSet {
    private String id;
    private String userName;
    private String imgUrl;
    private int likeStatus;
    private boolean privateCheck;
    private LocalDateTime createdAt;

    public ImageSet() {
        this.createdAt = LocalDateTime.now();
    }

    public ImageSet(String id, String userName, String imgUrl, int likeStatus, boolean privateCheck, LocalDateTime createdAt) {
        super();
        this.id = id;
        this.userName = userName;
        this.imgUrl = imgUrl;
        this.likeStatus = likeStatus;
        this.privateCheck = privateCheck;
        this.createdAt = createdAt;
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

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "ImageSet{" +
                "id='" + id + '\'' +
                ", userName='" + userName + '\'' +
                ", imgUrl='" + imgUrl + '\'' +
                ", likeStatus=" + likeStatus +
                ", privateCheck=" + privateCheck +
                ", createdAt=" + createdAt +
                '}';
    }
}
