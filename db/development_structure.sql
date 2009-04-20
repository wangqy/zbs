CREATE TABLE `cases` (
  `id` int(11) NOT NULL auto_increment,
  `callnumber` varchar(20) NOT NULL,
  `phone` varchar(20) default NULL,
  `mobile` varchar(20) default NULL,
  `content` varchar(800) NOT NULL,
  `delta` tinyint(1) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `departments` (
  `id` int(11) NOT NULL auto_increment,
  `code` varchar(10) default NULL,
  `name` varchar(40) default NULL,
  `manager` varchar(10) default NULL,
  `telephone` varchar(20) default NULL,
  `fax` varchar(20) default NULL,
  `email` varchar(50) default NULL,
  `address` varchar(120) default NULL,
  `remark` varchar(800) default NULL,
  `creator_id` int(11) default NULL,
  `modifier_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `events` (
  `id` int(11) NOT NULL auto_increment,
  `state` smallint(6) NOT NULL default '0',
  `timing` datetime NOT NULL,
  `title` varchar(20) NOT NULL,
  `content` varchar(800) NOT NULL,
  `type` varchar(10) NOT NULL,
  `aim` smallint(6) default NULL,
  `emergency` smallint(6) default NULL,
  `security` smallint(6) default NULL,
  `kind` smallint(6) default NULL,
  `name` varchar(20) default NULL,
  `phone` varchar(20) default NULL,
  `mobile` varchar(20) default NULL,
  `sex` smallint(6) default NULL,
  `address` varchar(50) default NULL,
  `email` varchar(50) default NULL,
  `callnumber` varchar(20) NOT NULL,
  `calltag` varchar(20) NOT NULL,
  `creator_id` int(11) NOT NULL,
  `modifier_id` int(11) NOT NULL,
  `case_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `histories` (
  `id` int(11) NOT NULL auto_increment,
  `event_id` int(11) default NULL,
  `handle` int(11) default NULL,
  `department_id` int(11) default NULL,
  `timeout` date default NULL,
  `responser` varchar(255) default NULL,
  `reason` varchar(255) default NULL,
  `remark` varchar(255) default NULL,
  `creator_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `logs` (
  `id` int(11) NOT NULL auto_increment,
  `operate` int(11) default NULL,
  `modulename` varchar(10) default NULL,
  `content` varchar(120) default NULL,
  `objectid` int(11) default NULL,
  `operatedate` datetime default NULL,
  `ip` varchar(15) default NULL,
  `operator_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `notices` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(120) default NULL,
  `content` varchar(800) default NULL,
  `deployed` int(11) default NULL,
  `creator_id` int(11) default NULL,
  `modifier_id` int(11) default NULL,
  `deployee_id` int(11) default NULL,
  `deployed_at` datetime default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `login` varchar(255) default NULL,
  `crypted_password` varchar(40) default NULL,
  `salt` varchar(40) default NULL,
  `remember_token` varchar(255) default NULL,
  `remember_token_expires_at` datetime default NULL,
  `realname` varchar(255) NOT NULL,
  `sex` int(11) default NULL,
  `department_id` int(11) NOT NULL,
  `role` int(11) NOT NULL,
  `position` varchar(255) default NULL,
  `telephone` varchar(20) default NULL,
  `mobile` varchar(20) default NULL,
  `ismanager` int(11) default NULL,
  `email` varchar(120) default NULL,
  `remark` varchar(20) default NULL,
  `disabled` int(11) default NULL,
  `creator` int(11) default NULL,
  `modifier` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `workitems` (
  `id` int(11) NOT NULL auto_increment,
  `store_name` varchar(255) NOT NULL,
  `event_id` int(11) NOT NULL,
  `creator` varchar(255) NOT NULL,
  `last_store_name` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO schema_migrations (version) VALUES ('20090311141723');

INSERT INTO schema_migrations (version) VALUES ('20090316145430');

INSERT INTO schema_migrations (version) VALUES ('20090325012404');

INSERT INTO schema_migrations (version) VALUES ('20090331122950');

INSERT INTO schema_migrations (version) VALUES ('20090331125107');

INSERT INTO schema_migrations (version) VALUES ('20090409075821');

INSERT INTO schema_migrations (version) VALUES ('20090410054847');

INSERT INTO schema_migrations (version) VALUES ('20090414032432');