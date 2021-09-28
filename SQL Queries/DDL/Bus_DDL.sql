create table bus(
    bus_id varchar(10),
    licence_plate_no varchar(10) not null unique,
    bus_type varchar(20) not null,
    bus_capacity int not null,
    PRIMARY KEY(bus_id)
);



insert into bus values("ABC123","IND123","double-decker",64);
insert into bus values("KHD232","IND456","regular",34);
insert into bus values("SND234","IND985","double-decker",64);
insert into bus values("PIN492","IND342","regular",34);
insert into bus values("FKD456","IND545","regular",34);
insert into bus values("PPD375","IND353","regular",34);
insert into bus values("TYU049","IND343","mini-bus",20);
insert into bus values("OSO902","IND442","mini-bus",20);
insert into bus values("DJS567","IND393","regular",34);
insert into bus values("DJW890","IND355","regular",34);
insert into bus values("KHD231","IND457","regular",34);
insert into bus values("KHD233","IND458","regular",34);
insert into bus values("KHD234","IND459","regular",34);
insert into bus values("KHD235","IND450","regular",34);
insert into bus values("KHD236","IND460","regular",34);
insert into bus values("KHD237","IND461","regular",34);
insert into bus values("KHD238","IND462","regular",34);
insert into bus values("KHD239","IND463","regular",34);
insert into bus values("KHD240","IND464","regular",34);
insert into bus values("KHD241","IND465","regular",34);
insert into bus values("KHD242","IND466","regular",34);
insert into bus values("KHD243","IND467","regular",34);
insert into bus values("KHD244","IND4618","regular",34);
insert into bus values("KHD245","IND469","regular",34);
insert into bus values("KHD246","IND470","regular",34);
insert into bus values("KHD247","IND471","regular",34);
insert into bus values("KHD248","IND472","regular",34);
insert into bus values("KHD249","IND473","regular",34);
insert into bus values("KHD250","IND474","regular",34);
insert into bus values("KHD251","IND475","regular",34);
insert into bus values("KHD252","IND476","regular",34);
insert into bus values("KHD253","IND477","regular",34);
