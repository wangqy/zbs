CREATE TABLE `ar_workitems` (
  `id` int(11) NOT NULL auto_increment,
  `fei` varchar(255) default NULL,
  `wfid` varchar(255) default NULL,
  `expid` varchar(255) default NULL,
  `wfname` varchar(255) default NULL,
  `wfrevision` varchar(255) default NULL,
  `participant_name` varchar(255) default NULL,
  `store_name` varchar(255) default NULL,
  `dispatch_time` datetime default NULL,
  `last_modified` datetime default NULL,
  `wi_fields` text,
  `activity` varchar(255) default NULL,
  `keywords` text,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_ar_workitems_on_fei` (`fei`),
  KEY `index_ar_workitems_on_expid` (`expid`),
  KEY `index_ar_workitems_on_participant_name` (`participant_name`),
  KEY `index_ar_workitems_on_store_name` (`store_name`),
  KEY `index_ar_workitems_on_wfid` (`wfid`),
  KEY `index_ar_workitems_on_wfname` (`wfname`),
  KEY `index_ar_workitems_on_wfrevision` (`wfrevision`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `cases` (
  `id` int(11) NOT NULL auto_increment,
  `content` varchar(255) default NULL,
  `aim` int(11) default NULL,
  `emergency` int(11) default NULL,
  `security` int(11) default NULL,
  `kind` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `departments` (
  `id` int(11) NOT NULL auto_increment,
  `code_prefix` varchar(3) default NULL,
  `code_suffix` varchar(10) default NULL,
  `name` varchar(40) default NULL,
  `manager` varchar(10) default NULL,
  `telephone` varchar(20) default NULL,
  `fax` varchar(20) default NULL,
  `email` varchar(50) default NULL,
  `address` varchar(120) default NULL,
  `remark` varchar(800) default NULL,
  `creator` int(11) default NULL,
  `modifier` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `employees` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(10) default NULL,
  `sex` int(11) default NULL,
  `department_id` int(11) default NULL,
  `position` varchar(255) default NULL,
  `telephone` varchar(20) default NULL,
  `mobile` varchar(20) default NULL,
  `ismanager` int(11) default NULL,
  `email` varchar(120) default NULL,
  `remark` varchar(20) default NULL,
  `creator` int(11) default NULL,
  `modifier` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `events` (
  `id` int(11) NOT NULL auto_increment,
  `state` int(11) NOT NULL default '0',
  `timing` datetime NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` varchar(255) NOT NULL,
  `type` varchar(255) default NULL,
  `aim` int(11) default NULL,
  `emergency` int(11) default NULL,
  `security` int(11) default NULL,
  `kind` int(11) default NULL,
  `name` varchar(255) default NULL,
  `phone` varchar(255) default NULL,
  `mobile` varchar(255) default NULL,
  `sex` int(11) default NULL,
  `email` varchar(255) default NULL,
  `address` varchar(255) default NULL,
  `callnumber` varchar(255) NOT NULL,
  `calltag` varchar(255) default NULL,
  `person_id` int(11) default NULL,
  `case_id` int(11) default NULL,
  `creator` varchar(255) default NULL,
  `modifier` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `expressions` (
  `id` int(11) NOT NULL auto_increment,
  `fei` varchar(255) NOT NULL,
  `wfid` varchar(255) NOT NULL,
  `expid` varchar(255) NOT NULL,
  `exp_class` varchar(255) NOT NULL,
  `svalue` longtext NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `index_expressions_on_exp_class` (`exp_class`),
  KEY `index_expressions_on_expid` (`expid`),
  KEY `index_expressions_on_fei` (`fei`),
  KEY `index_expressions_on_wfid` (`wfid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `history` (
  `id` int(11) NOT NULL auto_increment,
  `created_at` datetime default NULL,
  `source` varchar(255) NOT NULL,
  `event` varchar(255) NOT NULL,
  `wfid` varchar(255) default NULL,
  `wfname` varchar(255) default NULL,
  `wfrevision` varchar(255) default NULL,
  `fei` varchar(255) default NULL,
  `participant` varchar(255) default NULL,
  `message` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_history_on_created_at` (`created_at`),
  KEY `index_history_on_event` (`event`),
  KEY `index_history_on_participant` (`participant`),
  KEY `index_history_on_source` (`source`),
  KEY `index_history_on_wfid` (`wfid`),
  KEY `index_history_on_wfname` (`wfname`),
  KEY `index_history_on_wfrevision` (`wfrevision`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `people` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `phone` varchar(255) default NULL,
  `mobile` varchar(255) default NULL,
  `sex` int(11) default NULL,
  `email` varchar(255) default NULL,
  `address` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `process_errors` (
  `id` int(11) NOT NULL auto_increment,
  `created_at` datetime default NULL,
  `wfid` varchar(255) NOT NULL,
  `expid` varchar(255) NOT NULL,
  `svalue` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `index_process_errors_on_created_at` (`created_at`),
  KEY `index_process_errors_on_expid` (`expid`),
  KEY `index_process_errors_on_wfid` (`wfid`)
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
  `realname` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO schema_migrations (version) VALUES ('20090311141723');

INSERT INTO schema_migrations (version) VALUES ('20090316140251');

INSERT INTO schema_migrations (version) VALUES ('20090316140916');

INSERT INTO schema_migrations (version) VALUES ('20090316145430');

INSERT INTO schema_migrations (version) VALUES ('20090325012404');

INSERT INTO schema_migrations (version) VALUES ('20090327020212');

INSERT INTO schema_migrations (version) VALUES ('20090327020213');

INSERT INTO schema_migrations (version) VALUES ('20090327020214');

INSERT INTO schema_migrations (version) VALUES ('20090327020215');

INSERT INTO schema_migrations (version) VALUES ('20090330062839');