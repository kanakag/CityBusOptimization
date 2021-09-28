
-- Run the 'route' query only after 'stops' query

create table route(
	route_id int, 
    route_short_name varchar(5),
	route_description varchar(500) not null, 
    source_id varchar(10),
    destination_id varchar(10),
	PRIMARY KEY(route_id),
    FOREIGN KEY (source_id) REFERENCES stops(stop_id),
	FOREIGN KEY (destination_id) REFERENCES stops(stop_id)
	);

insert into route values('10238','6A','6A Fourth St, operates Monday - Sunday','BUS269','BUS694NE');
insert into route values('10239','15','15 Tower Acres, operates Monday - Friday only during Purdues Fall & Spring Semesters on days when classes are held','BUS755','BUS160');
insert into route values('10241','4A','4A Tippecanoe Mall, operates Monday - Sunday','BUS889','BUS699SW');
insert into route values('10242','6B','6B South 9th St, operates Monday - Saturday','TEMP17','BUS185');
insert into route values('10244','24','24 Redpoint','BUS146','BUS219E');
insert into route values('10245','24','24 Redpoint','BUS146','BUS219E');
insert into route values('10247','35','35 Lindberg Express, operates Monday - Saturday during Purdues Fall & Spring Semesters on days when classes are held','BUS415','BUS221E');
insert into route values('10249','28','28 Gold Loop, operates Monday - Friday only during Purdues Fall & Spring Semesters on days when classes are held','BUS417SE','BUS221W');
insert into route values('10251','4B','4B Purdue West, operates Monday - Sunday','BUS425S','BUS696NE');
insert into route values('10255','3','3 Lafayette Square, operates Monday - Sunday','BUS887','BUS696SW');
insert into route values('10256','21A','Route 21A Lark & Alight, operates Monday - Saturday, with limited service during Purdues summer break.','BUS754','BUS219W');
insert into route values('10257','17','17 Ross Ade, operates Monday - Friday during Purdues Fall & Spring Semesters on days when classes are held','BUS289','BUS002');
insert into route values('10258','2B','2B Union St, operates Monday - Saturday','BUS134','BUS695SW');
insert into route values('15201','8','','BUS176','BUS701');
insert into route values('10243','23','23 The Connector Between Lafayette and Purdue/West Lafayette, operates Monday-Friday, and Saturday During the Purdue Fall and Spring Semesters','BUS572','BUS419');
insert into route values('10253','1A','1A Market Square, operates Monday - Sunday','BUS466W','BUS326');
insert into route values('10254','1B','1B Salisbury, operates Monday - Sunday','BUS304','TEMP06');
insert into route values('10260','7','7 South Street, operates Monday - Sunday','BUS173','TEMP584SW');
insert into route values('10262','10','10 Northwestern, operates Monday - Saturday','BUS175','BUS312');
insert into route values('10263','9','9 Park East - Operates Monday - Friday','BUS902','BUS214');
