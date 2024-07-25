package com.pikaboo.master.model.service;

import com.pikaboo.master.model.dao.ImageSetDao;
import com.pikaboo.master.dto.ImageSet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.List;

@Service
public class ImageServiceImpl implements ImageService {
    @Autowired
    ImageSetDao imageDao;


    @Override
    public int add(ImageSet imgSet) throws SQLException {
        return imageDao.insert(imgSet);
    }

    @Override
    public void edit(ImageSet imgSet) throws SQLException {

    }

    @Override
    public void remove(int no) throws SQLException {

    }

    @Override
    public ImageSet read(int id) throws SQLException {
        return imageDao.select(id);
    }

    @Override
    public List<ImageSet> readAll() throws SQLException {
        return imageDao.selectAll();
    }
}
