CREATE TABLE `blog_posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `body` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `blogs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) DEFAULT NULL,
  `body` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=111 DEFAULT CHARSET=utf8;

CREATE TABLE `countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

CREATE TABLE `globalize_countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(2) DEFAULT NULL,
  `english_name` varchar(255) DEFAULT NULL,
  `date_format` varchar(255) DEFAULT NULL,
  `currency_format` varchar(255) DEFAULT NULL,
  `currency_code` varchar(3) DEFAULT NULL,
  `thousands_sep` varchar(2) DEFAULT NULL,
  `decimal_sep` varchar(2) DEFAULT NULL,
  `currency_decimal_sep` varchar(2) DEFAULT NULL,
  `number_grouping_scheme` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_globalize_countries_on_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=240 DEFAULT CHARSET=latin1;

CREATE TABLE `globalize_languages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `iso_639_1` varchar(2) DEFAULT NULL,
  `iso_639_2` varchar(3) DEFAULT NULL,
  `iso_639_3` varchar(3) DEFAULT NULL,
  `rfc_3066` varchar(255) DEFAULT NULL,
  `english_name` varchar(255) DEFAULT NULL,
  `english_name_locale` varchar(255) DEFAULT NULL,
  `english_name_modifier` varchar(255) DEFAULT NULL,
  `native_name` varchar(255) DEFAULT NULL,
  `native_name_locale` varchar(255) DEFAULT NULL,
  `native_name_modifier` varchar(255) DEFAULT NULL,
  `macro_language` tinyint(1) DEFAULT NULL,
  `direction` varchar(255) DEFAULT NULL,
  `pluralization` varchar(255) DEFAULT NULL,
  `scope` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_globalize_languages_on_iso_639_1` (`iso_639_1`),
  KEY `index_globalize_languages_on_iso_639_2` (`iso_639_2`),
  KEY `index_globalize_languages_on_iso_639_3` (`iso_639_3`),
  KEY `index_globalize_languages_on_rfc_3066` (`rfc_3066`)
) ENGINE=InnoDB AUTO_INCREMENT=7597 DEFAULT CHARSET=latin1;

CREATE TABLE `globalize_translations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL,
  `tr_key` varchar(255) DEFAULT NULL,
  `table_name` varchar(255) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `facet` varchar(255) DEFAULT NULL,
  `built_in` tinyint(1) DEFAULT '1',
  `language_id` int(11) DEFAULT NULL,
  `pluralization_index` int(11) DEFAULT NULL,
  `text` text,
  `namespace` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_globalize_translations_on_tr_key_and_language_id` (`tr_key`,`language_id`),
  KEY `globalize_translations_table_name_and_item_and_language` (`table_name`,`item_id`,`language_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7052 DEFAULT CHARSET=latin1;

CREATE TABLE `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `body` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `cached_tag_list` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` varchar(255) NOT NULL,
  `data` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_sessions_on_session_id` (`session_id`),
  KEY `index_sessions_on_updated_at` (`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=latin1;

CREATE TABLE `specs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `first_name` varchar(255) DEFAULT '',
  `last_name` varchar(255) DEFAULT '',
  `birthdate` date DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

CREATE TABLE `studies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `university_id` int(11) DEFAULT NULL,
  `from` date DEFAULT NULL,
  `to` date DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `study_type_id` int(11) DEFAULT NULL,
  `subject_area_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

CREATE TABLE `study_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE `subject_areas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `taggings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_id` int(11) DEFAULT NULL,
  `taggable_id` int(11) DEFAULT NULL,
  `taggable_type` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_taggings_on_tag_id` (`tag_id`),
  KEY `index_taggings_on_taggable_id_and_taggable_type` (`taggable_id`,`taggable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;

CREATE TABLE `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

CREATE TABLE `universities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `pending` tinyint(1) DEFAULT '1',
  `added_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `authorization_token` varchar(255) DEFAULT NULL,
  `blog_url` varchar(255) DEFAULT NULL,
  `blog_type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1206 DEFAULT CHARSET=utf8;

INSERT INTO schema_migrations (version) VALUES ('1');

INSERT INTO schema_migrations (version) VALUES ('2');

INSERT INTO schema_migrations (version) VALUES ('20090808172602');

INSERT INTO schema_migrations (version) VALUES ('20090808173534');

INSERT INTO schema_migrations (version) VALUES ('20090809102506');

INSERT INTO schema_migrations (version) VALUES ('20090809154107');

INSERT INTO schema_migrations (version) VALUES ('20090809160517');

INSERT INTO schema_migrations (version) VALUES ('20090809195353');

INSERT INTO schema_migrations (version) VALUES ('20090809201211');

INSERT INTO schema_migrations (version) VALUES ('20090813164716');

INSERT INTO schema_migrations (version) VALUES ('20090814102518');

INSERT INTO schema_migrations (version) VALUES ('20090814122826');

INSERT INTO schema_migrations (version) VALUES ('20090814123037');

INSERT INTO schema_migrations (version) VALUES ('20090822151841');

INSERT INTO schema_migrations (version) VALUES ('20090827212247');

INSERT INTO schema_migrations (version) VALUES ('20090827212507');

INSERT INTO schema_migrations (version) VALUES ('20090829110344');

INSERT INTO schema_migrations (version) VALUES ('20090829110454');

INSERT INTO schema_migrations (version) VALUES ('20090829130655');

INSERT INTO schema_migrations (version) VALUES ('20090829131237');

INSERT INTO schema_migrations (version) VALUES ('20090829131413');

INSERT INTO schema_migrations (version) VALUES ('20090830171205');

INSERT INTO schema_migrations (version) VALUES ('20090831162806');

INSERT INTO schema_migrations (version) VALUES ('20090922072030');

INSERT INTO schema_migrations (version) VALUES ('20090922073123');

INSERT INTO schema_migrations (version) VALUES ('20091106184149');

INSERT INTO schema_migrations (version) VALUES ('20091218220905');

INSERT INTO schema_migrations (version) VALUES ('20091218223734');

INSERT INTO schema_migrations (version) VALUES ('20091221190144');

INSERT INTO schema_migrations (version) VALUES ('20091230191525');

INSERT INTO schema_migrations (version) VALUES ('20091230195409');

INSERT INTO schema_migrations (version) VALUES ('3');

INSERT INTO schema_migrations (version) VALUES ('4');

INSERT INTO schema_migrations (version) VALUES ('5');

INSERT INTO schema_migrations (version) VALUES ('6');