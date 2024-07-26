package com.pikaboo.master.model.dao;

import com.pikaboo.master.dto.ImageSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.*;

@Mapper
public interface ImageSetDao {
    @Insert("insert into imageMain (userName,imgUrl,likeStatus,privateCheck) values (#{userName}, #{imgUrl}, #{likeStatus}, #{privateCheck})")
    public int insert(ImageSet imageSet) throws SQLException;

    @Update("update imageMain set userName=#{userName}, imgUrl=#{imgUrl} where id=#{id}")
    public void update(ImageSet imageSet) throws SQLException;
    @Update("update imageMain set  imgUrl=#{newUrl} where imgUrl=#{prevUrl}")
    public void urlUpdate(String newUrl, String prevUrl) throws SQLException;

    @Delete("delete from imageMain where id=#{id}")
    public void delete(int id) throws SQLException;
    @Delete("delete imgUrl from imageMain where imgUrl=#{url}")
    public void deleteUrl(String url) throws SQLException;

    @Select("select id, userName, imgUrl, likeStatus, privateCheck from imageMain where id=#{id}")
    public ImageSet select(int id) throws SQLException;

    @Select("SELECT id, userName, imgUrl, likeStatus, privateCheck FROM imageMain")
    List<ImageSet> selectAll() throws SQLException;

}
