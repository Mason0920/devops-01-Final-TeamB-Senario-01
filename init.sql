CREATE TABLE IF NOT EXISTS `reservations`( 
id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT, 
departure varchar(200) NOT NULL, 
destination varchar(200) NOT NULL, 
date DATE NOT NULL,
user_name varchar(200) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
