use picturiooDB;

drop table if exists imageMain;

create table ImageSet(
                       id int primary key  auto_increment,
                       userName varchar(20) not null ,
                       imgUrl varchar(255) ,
                       likeStatus int,
                       privateCheck tinyint

);