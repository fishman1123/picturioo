package com.pikaboo.master.model.service;

import com.pikaboo.master.dto.ImageSet;

import java.sql.SQLException;
import java.util.List;

public interface ImageService {
    public int add(ImageSet imgSet) throws SQLException;
    public void edit(ImageSet imgSet) throws SQLException;
    public void remove(int no) throws SQLException;
    public ImageSet read(int no) throws SQLException;
    public List<ImageSet> readAll() throws SQLException;
}
