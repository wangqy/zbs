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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO schema_migrations (version) VALUES ('20090311141723');

INSERT INTO schema_migrations (version) VALUES ('20090316140251');

INSERT INTO schema_migrations (version) VALUES ('20090316140916');

INSERT INTO schema_migrations (version) VALUES ('20090316145430');

INSERT INTO schema_migrations (version) VALUES ('20090325012404');

INSERT INTO schema_migrations (version) VALUES ('20090330062839');