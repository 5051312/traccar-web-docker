create table application_settings (id bigint generated by default as identity, allowCommandsOnlyForAdmins boolean, bingMapsKey varchar(255), defaultPasswordHash varchar(255), disallowDeviceManagementByUsers boolean, eventRecordingEnabled boolean, language varchar(255), matchServiceType varchar(255), matchServiceURL varchar(255), notificationExpirationPeriod integer, registrationEnabled boolean not null, salt varchar(255), updateInterval smallint, userSettings_id bigint, primary key (id));
create table device_icons (id bigint generated by default as identity, defaultIcon_id bigint, offlineIcon_id bigint, selectedIcon_id bigint, primary key (id));
create table devices (id bigint generated by default as identity, autoUpdateOdometer boolean, description varchar(255), iconArrowMovingColor varchar(255), iconArrowOfflineColor varchar(255), iconArrowPausedColor varchar(255), iconArrowRadius double, iconArrowStoppedColor varchar(255), iconMode varchar(255), iconRotation boolean, iconType varchar(255), idleSpeedThreshold double, lastupdate timestamp, minIdleTime integer, name varchar(255), odometer double, phoneNumber varchar(255), plateNumber varchar(255), showName boolean, showOdometer boolean, showProtocol boolean, speedLimit double, status varchar(128), timeout integer, uniqueId varchar(255), vehicleInfo varchar(255), group_id bigint, icon_id bigint, latestPosition_id bigint, owner_id bigint, photo_id bigint, primary key (id));
create table devices_geofences (geofence_id bigint not null, device_id bigint not null, primary key (geofence_id, device_id));
create table events (id bigint generated by default as identity, expired boolean, notificationSent boolean not null, time timestamp, type varchar(255), device_id bigint, geoFence_id bigint, maintenance_id bigint, position_id bigint, primary key (id));
create table geofences (id bigint generated by default as identity, allDevices boolean, color varchar(255), description varchar(255), name varchar(255), points varchar(2048), radius float not null, type varchar(255), primary key (id));
create table groups (id bigint generated by default as identity, description varchar(255), name varchar(255), parent_id bigint, primary key (id));
create table groups_users (group_id bigint not null, user_id bigint not null, primary key (user_id, group_id));
create table maintenances (id bigint generated by default as identity, indexNo integer not null, lastService double not null, name varchar(255), serviceInterval double not null, device_id bigint, primary key (id));
create table notification_settings (id bigint generated by default as identity, fromAddress varchar(255), password varchar(255), port integer not null, pushbulletAccessToken varchar(255), secureConnectionType varchar(255), server varchar(255), useAuthorization boolean not null, username varchar(255), user_id bigint, primary key (id));
create table notification_templates (id bigint generated by default as identity, body varchar(4096), contentType varchar(255), subject varchar(255), type varchar(255), settings_id bigint, primary key (id));
create table pictures (id bigint generated by default as identity, data blob, height integer not null, mimeType varchar(255), type varchar(255), width integer not null, primary key (id));
create table positions (id bigint generated by default as identity, address varchar(255), altitude double, course double, latitude double, longitude double, other varchar(2048), power double, protocol varchar(255), serverTime timestamp, speed double, time timestamp, valid boolean, device_id bigint, primary key (id));
create table reports (id bigint generated by default as identity, disableFilter boolean, fromDate timestamp, includeMap boolean not null, name varchar(255), period varchar(255), preview boolean, toDate timestamp, type varchar(255), primary key (id));
create table reports_devices (report_id bigint not null, device_id bigint not null, primary key (report_id, device_id));
create table reports_geofences (report_id bigint not null, geofence_id bigint not null, primary key (report_id, geofence_id));
create table reports_users (report_id bigint not null, user_id bigint not null, primary key (user_id, report_id));
create table sensors (id bigint generated by default as identity, description varchar(255), intervals varchar(2048), name varchar(255), parameterName varchar(255), visible boolean not null, device_id bigint, primary key (id));
create table ui_state (id bigint generated by default as identity, name varchar(255), value varchar(1024), user_id bigint, primary key (id));
create table user_settings (id bigint generated by default as identity, archiveMarkerType varchar(255), centerLatitude double, centerLongitude double, followedDeviceZoomLevel smallint, hideDuplicates boolean, hideInvalidLocations boolean, hideZeroCoordinates boolean, mapType varchar(255), maximizeOverviewMap boolean, minDistance double, overlays varchar(255), speedForFilter double, speedModifier varchar(255), speedUnit varchar(255), timePrintInterval smallint, timeZoneId varchar(255), traceInterval smallint, zoomLevel integer, primary key (id));
create table users (id bigint generated by default as identity, admin boolean, archive boolean, blocked boolean, companyName varchar(255), email varchar(255), expirationDate date, firstName varchar(255), lastName varchar(255), login varchar(255), manager boolean, maxNumOfDevices integer, notifications boolean, password varchar(255), password_hash_method integer, phoneNumber varchar(255), readOnly boolean, salt varchar(255), managedBy_id bigint, userSettings_id bigint, primary key (id));
create table users_devices (devices_id bigint not null, users_id bigint not null, primary key (users_id, devices_id));
create table users_geofences (user_id bigint not null, geofence_id bigint not null, primary key (geofence_id, user_id));
create table users_notifications (user_id bigint not null, type varchar(255) not null, primary key (user_id, type));
alter table devices add constraint devices_ukey_uniqueid  unique (uniqueId);
create index devices_pkey on devices (id);
create index events_position_event_type on events (position_id, type);
create index events_sent_event_type on events (notificationSent, type);
create index geofences_pkey on geofences (id);
create index groups_pkey on groups (id);
create index maintenances_pkey on maintenances (id);
create index positionsIndex on positions (device_id, time);
create index reports_pkey on reports (id);
create index sensors_pkey on sensors (id);
alter table ui_state add constraint ui_state_user_name  unique (user_id, name);
alter table users add constraint users_ukey_login  unique (login);
alter table application_settings add constraint appsettings_fkey_usersettings_id foreign key (userSettings_id) references user_settings;
alter table device_icons add constraint device_icons_fkey_def_icon_id foreign key (defaultIcon_id) references pictures;
alter table device_icons add constraint device_icons_fkey_off_icon_id foreign key (offlineIcon_id) references pictures;
alter table device_icons add constraint device_icons_fkey_sel_icon_id foreign key (selectedIcon_id) references pictures;
alter table devices add constraint devices_fkey_group_id foreign key (group_id) references groups;
alter table devices add constraint devices_fkey_icon_id foreign key (icon_id) references device_icons;
alter table devices add constraint devices_fkey_position_id foreign key (latestPosition_id) references positions;
alter table devices add constraint devices_fkey_owner_id foreign key (owner_id) references users;
alter table devices add constraint devices_fkey_photo_id foreign key (photo_id) references pictures;
alter table devices_geofences add constraint FK_7rmcefrdt5kphxrng7isgst8a foreign key (device_id) references devices;
alter table devices_geofences add constraint FK_8nat0wpr20pfm63kqn574jv1n foreign key (geofence_id) references geofences;
alter table events add constraint events_fkey_device_id foreign key (device_id) references devices;
alter table events add constraint events_fkey_geofence_id foreign key (geoFence_id) references geofences;
alter table events add constraint events_fkey_maintenance_id foreign key (maintenance_id) references maintenances;
alter table events add constraint events_fkey_position_id foreign key (position_id) references positions;
alter table groups add constraint groups_fkey_parent_id foreign key (parent_id) references groups;
alter table groups_users add constraint FK_odfphff6euk83blqduc0g35x8 foreign key (user_id) references users;
alter table groups_users add constraint FK_3w9ha4mtrw6pijpjyi1bnn5hs foreign key (group_id) references groups;
alter table maintenances add constraint maintenances_fkey_device_id foreign key (device_id) references devices;
alter table notification_settings add constraint nsettings_fkey_user_id foreign key (user_id) references users;
alter table notification_templates add constraint ntemplates_fkey_settings_id foreign key (settings_id) references notification_settings;
alter table positions add constraint positions_fkey_device_id foreign key (device_id) references devices;
alter table reports_devices add constraint FK_1kmwflc0trqigoy22seda7ucy foreign key (device_id) references devices;
alter table reports_devices add constraint FK_ldf17jjghcbbauouy3c8c3kxf foreign key (report_id) references reports;
alter table reports_geofences add constraint FK_9r8q57917j8ph891hurc0r5jn foreign key (geofence_id) references geofences;
alter table reports_geofences add constraint FK_3bw7vgdcp66qv9v9kqxxjxq89 foreign key (report_id) references reports;
alter table reports_users add constraint FK_rswa76rhq84uv1hexqpwbfldf foreign key (user_id) references users;
alter table reports_users add constraint FK_ftt5w5yw091dhyxqbu395auic foreign key (report_id) references reports;
alter table sensors add constraint sensors_fkey_device_id foreign key (device_id) references devices;
alter table ui_state add constraint ui_state_fkey_user_id foreign key (user_id) references users;
alter table users add constraint users_fkey_managedby_id foreign key (managedBy_id) references users;
alter table users add constraint users_fkey_usersettings_id foreign key (userSettings_id) references user_settings;
alter table users_devices add constraint FK_gjr4qgp93a7qxnpl5f8ic3kjl foreign key (users_id) references users;
alter table users_devices add constraint FK_lx5xhwfapdp4oolehin09shin foreign key (devices_id) references devices;
alter table users_geofences add constraint FK_kwptsxruddlbdhri6w4wdss5 foreign key (geofence_id) references geofences;
alter table users_geofences add constraint FK_17mdfqh6q5qkwf6o3vdc2gagb foreign key (user_id) references users;
alter table users_notifications add constraint FK_e80j2tdq8wxmyu39c44arkd7j foreign key (user_id) references users;
;