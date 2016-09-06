#!/bin/bash

echodate()
{
    echo `date "+%Y-%m-%d %H:%M:%S"` $*
}

if [ $(mysql -N -s -u root --password=$MYSQL_ROOT_PASSWORD -e \
    "select count(*) from information_schema.tables where \
        table_schema="\'$MYSQL_DATABASE\'" and table_name='countdetail';") -eq 1 ]; then
    echodate " [Note] table 'countdetail' does exist"
else
    
    echodate " [Note] table 'countdetail' does not exist, creating"
    
    mysql -s -u root --password=$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE -e \
    'CREATE TABLE countdetail (Id int(11) NOT NULL AUTO_INCREMENT,  Section varchar(500) NOT NULL,  `Date` date NOT NULL,  IP varchar(50) DEFAULT NULL,  PRIMARY KEY (Id)) ENGINE=InnoDB  DEFAULT CHARSET=latin1;'
 
    echodate " [Note] table 'countdetail' created"
fi
