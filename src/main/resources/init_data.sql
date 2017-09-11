/*
SQLyog v10.2
MySQL - 5.6.36 : Database - trustafis
*********************************************************************
*/
/*Data for the table 'TAS_SYS_ROLE' */
insert  into TAS_SYS_ROLE(ROLE_ID,NAME,PURVIEW,IS_ROOT,NOTE) values ('1','Super Administr','A,B,C,D,E,F,G,H,B01,B02,B03,C01,C02,D01,D02,D03,E01,E02,E03,E04,F01,F02,H01,H0101,H0102,H02,H0201,H0202,H03,H0301,H0302,H04,H0401,H0402','Y','Has all system privileges');
/*Data for the table 'TAS_SYS_MANAGER' */
insert  into TAS_SYS_MANAGER(MANAGER_ID,ACCOUNT,PASSWORD,ROLE_ID,IS_ROOT,STATU,LAST_LOGIN,CREATE_DATE,CREATE_BY,MODIFY_DATE,MODIFY_BY) values ('1','admin','CBFF36039C3D0212B3E34C23DCDE1456','1','Y','E','2017-08-31 15:53:49','2016-01-12 18:00:56','aratek','2017-08-31 15:53:49','admin');
