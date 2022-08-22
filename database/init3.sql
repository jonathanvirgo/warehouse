/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 10.4.24-MariaDB : Database - warehouse
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`warehouse` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `warehouse`;

/*Table structure for table `categories` */

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_slug_unique` (`slug`),
  KEY `categories_parent_id_foreign` (`parent_id`),
  CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `categories` */

insert  into `categories`(`id`,`parent_id`,`order`,`name`,`slug`,`created_at`,`updated_at`) values 
(1,NULL,1,'Category 1','category-1','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(2,NULL,1,'Category 2','category-2','2022-08-20 03:05:03','2022-08-20 03:05:03');

/*Table structure for table `data_rows` */

DROP TABLE IF EXISTS `data_rows`;

CREATE TABLE `data_rows` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data_type_id` int(10) unsigned NOT NULL,
  `field` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `browse` tinyint(1) NOT NULL DEFAULT 1,
  `read` tinyint(1) NOT NULL DEFAULT 1,
  `edit` tinyint(1) NOT NULL DEFAULT 1,
  `add` tinyint(1) NOT NULL DEFAULT 1,
  `delete` tinyint(1) NOT NULL DEFAULT 1,
  `details` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `data_rows_data_type_id_foreign` (`data_type_id`),
  CONSTRAINT `data_rows_data_type_id_foreign` FOREIGN KEY (`data_type_id`) REFERENCES `data_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `data_rows` */

insert  into `data_rows`(`id`,`data_type_id`,`field`,`type`,`display_name`,`required`,`browse`,`read`,`edit`,`add`,`delete`,`details`,`order`) values 
(1,1,'id','number','ID',1,0,0,0,0,0,NULL,1),
(2,1,'name','text','Name',1,1,1,1,1,1,NULL,2),
(3,1,'email','text','Email',1,1,1,1,1,1,NULL,3),
(4,1,'password','password','Password',1,0,0,1,1,0,NULL,4),
(5,1,'remember_token','text','Remember Token',0,0,0,0,0,0,NULL,5),
(6,1,'created_at','timestamp','Created At',0,1,1,0,0,0,NULL,6),
(7,1,'updated_at','timestamp','Updated At',0,0,0,0,0,0,NULL,7),
(8,1,'avatar','image','Avatar',0,1,1,1,1,1,NULL,8),
(9,1,'user_belongsto_role_relationship','relationship','Role',0,1,1,1,1,0,'{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsTo\",\"column\":\"role_id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"roles\",\"pivot\":0}',10),
(10,1,'user_belongstomany_role_relationship','relationship','voyager::seeders.data_rows.roles',0,1,1,1,1,0,'{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsToMany\",\"column\":\"id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"user_roles\",\"pivot\":\"1\",\"taggable\":\"0\"}',11),
(11,1,'settings','hidden','Settings',0,0,0,0,0,0,NULL,12),
(12,2,'id','number','ID',1,0,0,0,0,0,NULL,1),
(13,2,'name','text','Name',1,1,1,1,1,1,NULL,2),
(14,2,'created_at','timestamp','Created At',0,0,0,0,0,0,NULL,3),
(15,2,'updated_at','timestamp','Updated At',0,0,0,0,0,0,NULL,4),
(16,3,'id','number','ID',1,0,0,0,0,0,NULL,1),
(17,3,'name','text','Name',1,1,1,1,1,1,NULL,2),
(18,3,'created_at','timestamp','Created At',0,0,0,0,0,0,NULL,3),
(19,3,'updated_at','timestamp','Updated At',0,0,0,0,0,0,NULL,4),
(20,3,'display_name','text','Display Name',1,1,1,1,1,1,NULL,5),
(21,1,'role_id','text','Role',1,1,1,1,1,1,NULL,9),
(22,4,'id','number','ID',1,0,0,0,0,0,NULL,1),
(23,4,'parent_id','select_dropdown','Parent',0,0,1,1,1,1,'{\"default\":\"\",\"null\":\"\",\"options\":{\"\":\"-- None --\"},\"relationship\":{\"key\":\"id\",\"label\":\"name\"}}',2),
(24,4,'order','text','Order',1,1,1,1,1,1,'{\"default\":1}',3),
(25,4,'name','text','Name',1,1,1,1,1,1,NULL,4),
(26,4,'slug','text','Slug',1,1,1,1,1,1,'{\"slugify\":{\"origin\":\"name\"}}',5),
(27,4,'created_at','timestamp','Created At',0,0,1,0,0,0,NULL,6),
(28,4,'updated_at','timestamp','Updated At',0,0,0,0,0,0,NULL,7),
(29,5,'id','number','ID',1,0,0,0,0,0,NULL,1),
(30,5,'author_id','text','Author',1,0,1,1,0,1,NULL,2),
(31,5,'category_id','text','Category',1,0,1,1,1,0,NULL,3),
(32,5,'title','text','Title',1,1,1,1,1,1,NULL,4),
(33,5,'excerpt','text_area','Excerpt',1,0,1,1,1,1,NULL,5),
(34,5,'body','rich_text_box','Body',1,0,1,1,1,1,NULL,6),
(35,5,'image','image','Post Image',0,1,1,1,1,1,'{\"resize\":{\"width\":\"1000\",\"height\":\"null\"},\"quality\":\"70%\",\"upsize\":true,\"thumbnails\":[{\"name\":\"medium\",\"scale\":\"50%\"},{\"name\":\"small\",\"scale\":\"25%\"},{\"name\":\"cropped\",\"crop\":{\"width\":\"300\",\"height\":\"250\"}}]}',7),
(36,5,'slug','text','Slug',1,0,1,1,1,1,'{\"slugify\":{\"origin\":\"title\",\"forceUpdate\":true},\"validation\":{\"rule\":\"unique:posts,slug\"}}',8),
(37,5,'meta_description','text_area','Meta Description',1,0,1,1,1,1,NULL,9),
(38,5,'meta_keywords','text_area','Meta Keywords',1,0,1,1,1,1,NULL,10),
(39,5,'status','select_dropdown','Status',1,1,1,1,1,1,'{\"default\":\"DRAFT\",\"options\":{\"PUBLISHED\":\"published\",\"DRAFT\":\"draft\",\"PENDING\":\"pending\"}}',11),
(40,5,'created_at','timestamp','Created At',0,1,1,0,0,0,NULL,12),
(41,5,'updated_at','timestamp','Updated At',0,0,0,0,0,0,NULL,13),
(42,5,'seo_title','text','SEO Title',0,1,1,1,1,1,NULL,14),
(43,5,'featured','checkbox','Featured',1,1,1,1,1,1,NULL,15),
(44,6,'id','number','ID',1,0,0,0,0,0,NULL,1),
(45,6,'author_id','text','Author',1,0,0,0,0,0,NULL,2),
(46,6,'title','text','Title',1,1,1,1,1,1,NULL,3),
(47,6,'excerpt','text_area','Excerpt',1,0,1,1,1,1,NULL,4),
(48,6,'body','rich_text_box','Body',1,0,1,1,1,1,NULL,5),
(49,6,'slug','text','Slug',1,0,1,1,1,1,'{\"slugify\":{\"origin\":\"title\"},\"validation\":{\"rule\":\"unique:pages,slug\"}}',6),
(50,6,'meta_description','text','Meta Description',1,0,1,1,1,1,NULL,7),
(51,6,'meta_keywords','text','Meta Keywords',1,0,1,1,1,1,NULL,8),
(52,6,'status','select_dropdown','Status',1,1,1,1,1,1,'{\"default\":\"INACTIVE\",\"options\":{\"INACTIVE\":\"INACTIVE\",\"ACTIVE\":\"ACTIVE\"}}',9),
(53,6,'created_at','timestamp','Created At',1,1,1,0,0,0,NULL,10),
(54,6,'updated_at','timestamp','Updated At',1,0,0,0,0,0,NULL,11),
(55,6,'image','image','Page Image',0,1,1,1,1,1,NULL,12),
(56,8,'id','text','Id',1,0,0,0,0,0,'{}',1),
(57,8,'name','text','Tên',0,1,1,1,1,1,'{}',2),
(58,8,'price_export','number','Giá xuất',0,1,1,1,1,1,'{\"display\":{\"width\":\"6\"}}',4),
(59,8,'price_import','number','Giá nhập',0,1,1,1,1,1,'{\"display\":{\"width\":\"6\"}}',3),
(60,8,'image','image','Image',0,1,1,1,1,1,'{\"display\":{\"width\":\"6\"}}',7),
(62,8,'created_at','timestamp','Created At',0,1,1,1,0,1,'{}',8),
(63,8,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',10),
(91,13,'id','text','Id',1,0,0,0,0,0,'{}',1),
(92,13,'name','text','Name',0,1,1,1,1,1,'{}',2),
(93,13,'created_at','timestamp','Created At',0,1,1,1,0,1,'{}',3),
(94,13,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',4),
(95,8,'product_hasone_type_product_relationship','relationship','Loại',1,1,1,1,1,1,'{\"display\":{\"width\":\"6\"},\"model\":\"App\\\\Models\\\\TypeProduct\",\"table\":\"type_product\",\"type\":\"belongsTo\",\"column\":\"type_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"categories\",\"pivot\":\"0\",\"taggable\":\"0\"}',5),
(96,8,'type_id','text','Type Id',0,1,1,1,1,1,'{}',9),
(97,8,'total','number','Số lượng',0,1,1,1,1,1,'{\"display\":{\"width\":\"6\"},\"default\":0}',6);

/*Table structure for table `data_types` */

DROP TABLE IF EXISTS `data_types`;

CREATE TABLE `data_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name_singular` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name_plural` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `policy_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `controller` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `generate_permissions` tinyint(1) NOT NULL DEFAULT 0,
  `server_side` tinyint(4) NOT NULL DEFAULT 0,
  `details` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `data_types_name_unique` (`name`),
  UNIQUE KEY `data_types_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `data_types` */

insert  into `data_types`(`id`,`name`,`slug`,`display_name_singular`,`display_name_plural`,`icon`,`model_name`,`policy_name`,`controller`,`description`,`generate_permissions`,`server_side`,`details`,`created_at`,`updated_at`) values 
(1,'users','users','User','Users','voyager-person','TCG\\Voyager\\Models\\User','TCG\\Voyager\\Policies\\UserPolicy','TCG\\Voyager\\Http\\Controllers\\VoyagerUserController','',1,0,NULL,'2022-08-20 03:05:03','2022-08-20 03:05:03'),
(2,'menus','menus','Menu','Menus','voyager-list','TCG\\Voyager\\Models\\Menu',NULL,'','',1,0,NULL,'2022-08-20 03:05:03','2022-08-20 03:05:03'),
(3,'roles','roles','Role','Roles','voyager-lock','TCG\\Voyager\\Models\\Role',NULL,'TCG\\Voyager\\Http\\Controllers\\VoyagerRoleController','',1,0,NULL,'2022-08-20 03:05:03','2022-08-20 03:05:03'),
(4,'categories','categories','Category','Categories','voyager-categories','TCG\\Voyager\\Models\\Category',NULL,'','',1,0,NULL,'2022-08-20 03:05:03','2022-08-20 03:05:03'),
(5,'posts','posts','Post','Posts','voyager-news','TCG\\Voyager\\Models\\Post','TCG\\Voyager\\Policies\\PostPolicy','','',1,0,NULL,'2022-08-20 03:05:03','2022-08-20 03:05:03'),
(6,'pages','pages','Page','Pages','voyager-file-text','TCG\\Voyager\\Models\\Page',NULL,'','',1,0,NULL,'2022-08-20 03:05:03','2022-08-20 03:05:03'),
(8,'products','products','Sản phẩm','Sản phẩm',NULL,'App\\Models\\Product',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}','2022-08-20 03:10:16','2022-08-22 03:16:35'),
(13,'type_product','type-product','Loại sản phẩm','Loại sản phẩm','voyager-categories','App\\Models\\TypeProduct',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null}','2022-08-20 11:31:40','2022-08-20 11:31:40');

/*Table structure for table `debts` */

DROP TABLE IF EXISTS `debts`;

CREATE TABLE `debts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pro_id` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `report_date` date DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `debts` */

insert  into `debts`(`id`,`pro_id`,`price`,`total`,`report_date`,`created_by`,`type_id`,`created_at`,`updated_at`) values 
(1,2,640000,14,'2022-08-23',2,NULL,'2022-08-21 12:06:21','2022-08-22 10:21:49'),
(2,4,340000,3,'2022-08-22',2,NULL,'2022-08-22 04:54:28','2022-08-22 04:54:28'),
(3,5,170000,4,'2022-08-22',2,NULL,'2022-08-22 04:54:28','2022-08-22 04:54:28'),
(4,2,440000,11,'2022-08-21',2,NULL,'2022-08-22 10:17:29','2022-08-22 10:20:31');

/*Table structure for table `exports` */

DROP TABLE IF EXISTS `exports`;

CREATE TABLE `exports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pro_id` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `income` int(11) DEFAULT NULL,
  `discount` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `exports` */

/*Table structure for table `failed_jobs` */

DROP TABLE IF EXISTS `failed_jobs`;

CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `failed_jobs` */

/*Table structure for table `imports` */

DROP TABLE IF EXISTS `imports`;

CREATE TABLE `imports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pro_id` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `report_date` date DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `imports` */

insert  into `imports`(`id`,`pro_id`,`total`,`price`,`created_by`,`report_date`,`note`,`type_id`,`created_at`,`updated_at`) values 
(6,2,8,640000,2,'2022-08-22','abv',NULL,'2022-08-21 12:06:21','2022-08-21 12:06:21'),
(7,2,8,640000,2,'2022-08-23','',NULL,'2022-08-21 13:30:57','2022-08-21 13:30:57'),
(8,2,8,640000,2,'2022-08-23','',NULL,'2022-08-21 13:31:42','2022-08-21 13:31:42'),
(9,2,8,640000,2,'2022-08-23','',NULL,'2022-08-21 13:33:05','2022-08-21 13:33:05'),
(10,3,2,170000,2,'2022-08-22','',NULL,'2022-08-22 04:52:45','2022-08-22 04:52:45'),
(11,4,3,340000,2,'2022-08-22','',NULL,'2022-08-22 04:54:28','2022-08-22 04:54:28'),
(12,5,4,170000,2,'2022-08-22','',NULL,'2022-08-22 04:54:28','2022-08-22 04:54:28'),
(13,2,23,440000,2,'2022-08-21','abcd',NULL,'2022-08-22 10:17:29','2022-08-22 10:17:29');

/*Table structure for table `menu_items` */

DROP TABLE IF EXISTS `menu_items`;

CREATE TABLE `menu_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `menu_id` int(10) unsigned DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '_self',
  `icon_class` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `order` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `route` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parameters` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `menu_items_menu_id_foreign` (`menu_id`),
  CONSTRAINT `menu_items_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `menu_items` */

insert  into `menu_items`(`id`,`menu_id`,`title`,`url`,`target`,`icon_class`,`color`,`parent_id`,`order`,`created_at`,`updated_at`,`route`,`parameters`) values 
(1,1,'Dashboard','','_self','voyager-boat',NULL,NULL,1,'2022-08-20 03:05:03','2022-08-20 03:05:03','voyager.dashboard',NULL),
(2,1,'Media','','_self','voyager-images',NULL,NULL,7,'2022-08-20 03:05:03','2022-08-21 03:52:21','voyager.media.index',NULL),
(3,1,'Users','','_self','voyager-person',NULL,NULL,6,'2022-08-20 03:05:03','2022-08-21 03:52:21','voyager.users.index',NULL),
(4,1,'Roles','','_self','voyager-lock',NULL,NULL,5,'2022-08-20 03:05:03','2022-08-21 03:52:21','voyager.roles.index',NULL),
(5,1,'Tools','','_self','voyager-tools',NULL,NULL,11,'2022-08-20 03:05:03','2022-08-21 03:52:18',NULL,NULL),
(6,1,'Menu Builder','','_self','voyager-list',NULL,5,1,'2022-08-20 03:05:03','2022-08-20 03:27:07','voyager.menus.index',NULL),
(7,1,'Database','','_self','voyager-data',NULL,5,2,'2022-08-20 03:05:03','2022-08-20 03:27:07','voyager.database.index',NULL),
(8,1,'Compass','','_self','voyager-compass',NULL,5,3,'2022-08-20 03:05:03','2022-08-20 03:27:07','voyager.compass.index',NULL),
(9,1,'BREAD','','_self','voyager-bread',NULL,5,4,'2022-08-20 03:05:03','2022-08-20 03:27:07','voyager.bread.index',NULL),
(10,1,'Settings','','_self','voyager-settings',NULL,NULL,12,'2022-08-20 03:05:03','2022-08-21 03:52:18','voyager.settings.index',NULL),
(11,1,'Categories','','_self','voyager-categories',NULL,NULL,10,'2022-08-20 03:05:03','2022-08-21 03:52:18','voyager.categories.index',NULL),
(12,1,'Posts','','_self','voyager-news',NULL,NULL,8,'2022-08-20 03:05:03','2022-08-21 03:52:21','voyager.posts.index',NULL),
(13,1,'Pages','','_self','voyager-file-text',NULL,NULL,9,'2022-08-20 03:05:03','2022-08-21 03:52:21','voyager.pages.index',NULL),
(14,1,'Sản phẩm','','_self','voyager-bag','#000000',NULL,2,'2022-08-20 03:10:16','2022-08-21 03:52:18','voyager.products.index','null'),
(19,1,'Loại sản phẩm','','_self','voyager-categories',NULL,NULL,4,'2022-08-20 11:31:40','2022-08-21 03:52:21','voyager.type-product.index',NULL);

/*Table structure for table `menus` */

DROP TABLE IF EXISTS `menus`;

CREATE TABLE `menus` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menus_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `menus` */

insert  into `menus`(`id`,`name`,`created_at`,`updated_at`) values 
(1,'admin','2022-08-20 03:05:03','2022-08-20 03:05:03');

/*Table structure for table `migrations` */

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `migrations` */

insert  into `migrations`(`id`,`migration`,`batch`) values 
(1,'2014_10_12_000000_create_users_table',1),
(2,'2014_10_12_100000_create_password_resets_table',1),
(3,'2016_01_01_000000_add_voyager_user_fields',1),
(4,'2016_01_01_000000_create_data_types_table',1),
(5,'2016_05_19_173453_create_menu_table',1),
(6,'2016_10_21_190000_create_roles_table',1),
(7,'2016_10_21_190000_create_settings_table',1),
(8,'2016_11_30_135954_create_permission_table',1),
(9,'2016_11_30_141208_create_permission_role_table',1),
(10,'2016_12_26_201236_data_types__add__server_side',1),
(11,'2017_01_13_000000_add_route_to_menu_items_table',1),
(12,'2017_01_14_005015_create_translations_table',1),
(13,'2017_01_15_000000_make_table_name_nullable_in_permissions_table',1),
(14,'2017_03_06_000000_add_controller_to_data_types_table',1),
(15,'2017_04_21_000000_add_order_to_data_rows_table',1),
(16,'2017_07_05_210000_add_policyname_to_data_types_table',1),
(17,'2017_08_05_000000_add_group_to_settings_table',1),
(18,'2017_11_26_013050_add_user_role_relationship',1),
(19,'2017_11_26_015000_create_user_roles_table',1),
(20,'2018_03_11_000000_add_user_settings',1),
(21,'2018_03_14_000000_add_details_to_data_types_table',1),
(22,'2018_03_16_000000_make_settings_value_nullable',1),
(23,'2019_08_19_000000_create_failed_jobs_table',1),
(24,'2019_12_14_000001_create_personal_access_tokens_table',1),
(25,'2016_01_01_000000_create_pages_table',2),
(26,'2016_01_01_000000_create_posts_table',2),
(27,'2016_02_15_204651_create_categories_table',2),
(28,'2017_04_11_000000_alter_post_nullable_fields_table',2);

/*Table structure for table `pages` */

DROP TABLE IF EXISTS `pages`;

CREATE TABLE `pages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `author_id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `excerpt` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_keywords` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'INACTIVE',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pages_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `pages` */

insert  into `pages`(`id`,`author_id`,`title`,`excerpt`,`body`,`image`,`slug`,`meta_description`,`meta_keywords`,`status`,`created_at`,`updated_at`) values 
(1,0,'Hello World','Hang the jib grog grog blossom grapple dance the hempen jig gangway pressgang bilge rat to go on account lugger. Nelsons folly gabion line draught scallywag fire ship gaff fluke fathom case shot. Sea Legs bilge rat sloop matey gabion long clothes run a shot across the bow Gold Road cog league.','<p>Hello World. Scallywag grog swab Cat o\'nine tails scuttle rigging hardtack cable nipper Yellow Jack. Handsomely spirits knave lad killick landlubber or just lubber deadlights chantey pinnace crack Jennys tea cup. Provost long clothes black spot Yellow Jack bilged on her anchor league lateen sail case shot lee tackle.</p>\n<p>Ballast spirits fluke topmast me quarterdeck schooner landlubber or just lubber gabion belaying pin. Pinnace stern galleon starboard warp carouser to go on account dance the hempen jig jolly boat measured fer yer chains. Man-of-war fire in the hole nipperkin handsomely doubloon barkadeer Brethren of the Coast gibbet driver squiffy.</p>','pages/page1.jpg','hello-world','Yar Meta Description','Keyword1, Keyword2','ACTIVE','2022-08-20 03:05:03','2022-08-20 03:05:03');

/*Table structure for table `password_resets` */

DROP TABLE IF EXISTS `password_resets`;

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `password_resets` */

/*Table structure for table `pay` */

DROP TABLE IF EXISTS `pay`;

CREATE TABLE `pay` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pro_id` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `report_date` date DEFAULT NULL,
  `note` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `pay` */

insert  into `pay`(`id`,`pro_id`,`price`,`total`,`report_date`,`note`,`created_by`,`type_id`,`created_at`,`updated_at`) values 
(1,2,440000,12,'2022-08-22','',2,1,'2022-08-22 10:20:31','2022-08-22 10:20:31'),
(2,2,640000,2,'2022-08-24','',2,1,'2022-08-22 10:21:49','2022-08-22 10:21:49');

/*Table structure for table `permission_role` */

DROP TABLE IF EXISTS `permission_role`;

CREATE TABLE `permission_role` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `permission_role_permission_id_index` (`permission_id`),
  KEY `permission_role_role_id_index` (`role_id`),
  CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `permission_role` */

insert  into `permission_role`(`permission_id`,`role_id`) values 
(1,1),
(2,1),
(3,1),
(4,1),
(5,1),
(6,1),
(7,1),
(8,1),
(9,1),
(10,1),
(11,1),
(12,1),
(13,1),
(14,1),
(15,1),
(16,1),
(17,1),
(18,1),
(19,1),
(20,1),
(21,1),
(22,1),
(23,1),
(24,1),
(25,1),
(26,1),
(27,1),
(28,1),
(29,1),
(30,1),
(31,1),
(32,1),
(33,1),
(34,1),
(35,1),
(36,1),
(37,1),
(38,1),
(39,1),
(40,1),
(41,1),
(42,1),
(43,1),
(44,1),
(45,1),
(66,1),
(67,1),
(68,1),
(69,1),
(70,1);

/*Table structure for table `permissions` */

DROP TABLE IF EXISTS `permissions`;

CREATE TABLE `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `table_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `permissions_key_index` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `permissions` */

insert  into `permissions`(`id`,`key`,`table_name`,`created_at`,`updated_at`) values 
(1,'browse_admin',NULL,'2022-08-20 03:05:03','2022-08-20 03:05:03'),
(2,'browse_bread',NULL,'2022-08-20 03:05:03','2022-08-20 03:05:03'),
(3,'browse_database',NULL,'2022-08-20 03:05:03','2022-08-20 03:05:03'),
(4,'browse_media',NULL,'2022-08-20 03:05:03','2022-08-20 03:05:03'),
(5,'browse_compass',NULL,'2022-08-20 03:05:03','2022-08-20 03:05:03'),
(6,'browse_menus','menus','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(7,'read_menus','menus','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(8,'edit_menus','menus','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(9,'add_menus','menus','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(10,'delete_menus','menus','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(11,'browse_roles','roles','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(12,'read_roles','roles','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(13,'edit_roles','roles','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(14,'add_roles','roles','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(15,'delete_roles','roles','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(16,'browse_users','users','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(17,'read_users','users','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(18,'edit_users','users','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(19,'add_users','users','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(20,'delete_users','users','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(21,'browse_settings','settings','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(22,'read_settings','settings','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(23,'edit_settings','settings','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(24,'add_settings','settings','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(25,'delete_settings','settings','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(26,'browse_categories','categories','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(27,'read_categories','categories','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(28,'edit_categories','categories','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(29,'add_categories','categories','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(30,'delete_categories','categories','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(31,'browse_posts','posts','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(32,'read_posts','posts','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(33,'edit_posts','posts','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(34,'add_posts','posts','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(35,'delete_posts','posts','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(36,'browse_pages','pages','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(37,'read_pages','pages','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(38,'edit_pages','pages','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(39,'add_pages','pages','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(40,'delete_pages','pages','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(41,'browse_products','products','2022-08-20 03:10:16','2022-08-20 03:10:16'),
(42,'read_products','products','2022-08-20 03:10:16','2022-08-20 03:10:16'),
(43,'edit_products','products','2022-08-20 03:10:16','2022-08-20 03:10:16'),
(44,'add_products','products','2022-08-20 03:10:16','2022-08-20 03:10:16'),
(45,'delete_products','products','2022-08-20 03:10:16','2022-08-20 03:10:16'),
(66,'browse_type_product','type_product','2022-08-20 11:31:40','2022-08-20 11:31:40'),
(67,'read_type_product','type_product','2022-08-20 11:31:40','2022-08-20 11:31:40'),
(68,'edit_type_product','type_product','2022-08-20 11:31:40','2022-08-20 11:31:40'),
(69,'add_type_product','type_product','2022-08-20 11:31:40','2022-08-20 11:31:40'),
(70,'delete_type_product','type_product','2022-08-20 11:31:40','2022-08-20 11:31:40');

/*Table structure for table `personal_access_tokens` */

DROP TABLE IF EXISTS `personal_access_tokens`;

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `personal_access_tokens` */

/*Table structure for table `posts` */

DROP TABLE IF EXISTS `posts`;

CREATE TABLE `posts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `author_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `seo_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `excerpt` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_keywords` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('PUBLISHED','DRAFT','PENDING') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DRAFT',
  `featured` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `posts_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `posts` */

insert  into `posts`(`id`,`author_id`,`category_id`,`title`,`seo_title`,`excerpt`,`body`,`image`,`slug`,`meta_description`,`meta_keywords`,`status`,`featured`,`created_at`,`updated_at`) values 
(1,0,NULL,'Lorem Ipsum Post',NULL,'This is the excerpt for the Lorem Ipsum Post','<p>This is the body of the lorem ipsum post</p>','posts/post1.jpg','lorem-ipsum-post','This is the meta description','keyword1, keyword2, keyword3','PUBLISHED',0,'2022-08-20 03:05:03','2022-08-20 03:05:03'),
(2,0,NULL,'My Sample Post',NULL,'This is the excerpt for the sample Post','<p>This is the body for the sample post, which includes the body.</p>\n                <h2>We can use all kinds of format!</h2>\n                <p>And include a bunch of other stuff.</p>','posts/post2.jpg','my-sample-post','Meta Description for sample post','keyword1, keyword2, keyword3','PUBLISHED',0,'2022-08-20 03:05:03','2022-08-20 03:05:03'),
(3,0,NULL,'Latest Post',NULL,'This is the excerpt for the latest post','<p>This is the body for the latest post</p>','posts/post3.jpg','latest-post','This is the meta description','keyword1, keyword2, keyword3','PUBLISHED',0,'2022-08-20 03:05:03','2022-08-20 03:05:03'),
(4,0,NULL,'Yarr Post',NULL,'Reef sails nipperkin bring a spring upon her cable coffer jury mast spike marooned Pieces of Eight poop deck pillage. Clipper driver coxswain galleon hempen halter come about pressgang gangplank boatswain swing the lead. Nipperkin yard skysail swab lanyard Blimey bilge water ho quarter Buccaneer.','<p>Swab deadlights Buccaneer fire ship square-rigged dance the hempen jig weigh anchor cackle fruit grog furl. Crack Jennys tea cup chase guns pressgang hearties spirits hogshead Gold Road six pounders fathom measured fer yer chains. Main sheet provost come about trysail barkadeer crimp scuttle mizzenmast brig plunder.</p>\n<p>Mizzen league keelhaul galleon tender cog chase Barbary Coast doubloon crack Jennys tea cup. Blow the man down lugsail fire ship pinnace cackle fruit line warp Admiral of the Black strike colors doubloon. Tackle Jack Ketch come about crimp rum draft scuppers run a shot across the bow haul wind maroon.</p>\n<p>Interloper heave down list driver pressgang holystone scuppers tackle scallywag bilged on her anchor. Jack Tar interloper draught grapple mizzenmast hulk knave cable transom hogshead. Gaff pillage to go on account grog aft chase guns piracy yardarm knave clap of thunder.</p>','posts/post4.jpg','yarr-post','this be a meta descript','keyword1, keyword2, keyword3','PUBLISHED',0,'2022-08-20 03:05:03','2022-08-20 03:05:03');

/*Table structure for table `prb_log_activity` */

DROP TABLE IF EXISTS `prb_log_activity`;

CREATE TABLE `prb_log_activity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT 0,
  `name` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `method` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `form_data` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `agent` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `prb_log_activity` */

/*Table structure for table `products` */

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price_export` int(11) DEFAULT NULL,
  `price_import` int(11) DEFAULT NULL,
  `image` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `products` */

insert  into `products`(`id`,`name`,`price_export`,`price_import`,`image`,`type_id`,`total`,`created_at`,`updated_at`) values 
(2,'Lean Max Hope 900g',NULL,440000,NULL,1,9,'2022-08-20 15:47:08','2022-08-22 10:21:49'),
(3,'leankid 14',NULL,170000,NULL,1,0,'2022-08-20 16:08:00','2022-08-20 16:09:47'),
(4,'leankid 19',NULL,340000,NULL,1,3,'2022-08-20 16:09:35','2022-08-22 04:54:28'),
(5,'Leankid 24',NULL,170000,NULL,1,4,'2022-08-20 16:10:03','2022-08-22 04:54:28'),
(6,'Leankid 29',NULL,340000,NULL,1,0,'2022-08-20 16:10:20','2022-08-20 16:10:20'),
(7,'Kid BA4',NULL,170000,NULL,1,0,'2022-08-20 16:10:42','2022-08-20 16:10:42'),
(8,'Kid BA9',NULL,340000,NULL,1,0,'2022-08-20 16:10:55','2022-08-20 16:10:55'),
(9,'Colostrum 4',NULL,210000,NULL,1,0,'2022-08-20 16:11:17','2022-08-20 16:11:17'),
(10,'colostrum 9',NULL,420000,NULL,1,0,'2022-08-20 16:11:33','2022-08-20 16:11:33'),
(11,'Bone 4',NULL,215000,NULL,1,0,'2022-08-20 16:11:54','2022-08-20 16:11:54'),
(12,'Bone 9',NULL,430000,NULL,1,0,'2022-08-20 16:12:12','2022-08-20 16:12:12'),
(13,'Leanmax adult hộp (Le)',NULL,230000,NULL,1,0,'2022-08-20 16:12:00','2022-08-20 16:12:55'),
(14,'Leanmax adult 4 (Le)',NULL,220000,NULL,1,0,'2022-08-20 16:13:17','2022-08-20 16:13:17'),
(15,'Leanmax adult 9 (le)',NULL,440000,NULL,1,0,'2022-08-20 16:13:36','2022-08-20 16:13:36'),
(16,'Hope hộp',NULL,230000,NULL,1,0,'2022-08-20 16:14:14','2022-08-20 16:14:14'),
(17,'Hope 4',NULL,220000,NULL,1,0,'2022-08-20 16:14:29','2022-08-20 16:14:29'),
(18,'hope 9',NULL,440000,NULL,1,0,'2022-08-20 16:15:10','2022-08-20 16:15:10'),
(19,'pro hope 4',NULL,270000,NULL,1,0,'2022-08-20 16:15:34','2022-08-20 16:15:34'),
(20,'pro hope 9',NULL,560000,NULL,1,0,'2022-08-20 16:15:48','2022-08-20 16:15:48'),
(21,'Ligos hộp',NULL,230000,NULL,1,0,'2022-08-20 16:16:10','2022-08-20 16:16:10'),
(22,'Ligos 4',NULL,220000,NULL,1,0,'2022-08-20 16:16:25','2022-08-20 16:16:25'),
(23,'Ligos 9',NULL,440000,NULL,1,0,'2022-08-20 16:16:40','2022-08-20 16:16:40'),
(24,'mom 4',NULL,210000,NULL,1,0,'2022-08-20 16:17:14','2022-08-20 16:17:14'),
(25,'mom 9',NULL,420000,NULL,1,0,'2022-08-20 16:17:27','2022-08-20 16:17:27'),
(26,'Rena 1 gold 4',NULL,210000,NULL,1,0,'2022-08-20 16:17:47','2022-08-20 16:17:47'),
(27,'Rena 1 gold 9',NULL,420000,NULL,1,0,'2022-08-20 16:18:02','2022-08-20 16:18:02'),
(28,'Rena 1 hộp',NULL,230000,NULL,1,0,'2022-08-20 16:18:22','2022-08-20 16:18:22'),
(29,'rena 2 gold 4',NULL,210000,NULL,1,0,'2022-08-20 16:18:42','2022-08-20 16:18:42'),
(30,'peptizer',NULL,320000,NULL,1,0,'2022-08-20 16:19:06','2022-08-20 16:19:06'),
(31,'pro 10+ 4',NULL,260000,NULL,1,0,'2022-08-20 16:20:05','2022-08-20 16:20:05'),
(32,'pro 10+ 9',NULL,520000,NULL,1,0,'2022-08-20 16:20:20','2022-08-20 16:20:20'),
(33,'thyro  hộp',NULL,220000,NULL,1,0,'2022-08-20 16:20:50','2022-08-20 16:20:50'),
(34,'thyro 4',NULL,250000,NULL,1,0,'2022-08-20 16:21:07','2022-08-20 16:21:07'),
(35,'thyro 9',NULL,500000,NULL,1,0,'2022-08-20 16:21:19','2022-08-20 16:21:19'),
(36,'thyro lid hộp',NULL,220000,NULL,1,0,'2022-08-20 16:21:00','2022-08-20 16:22:16'),
(37,'thyro lid 4',NULL,280000,NULL,1,0,'2022-08-20 16:22:07','2022-08-20 16:22:07'),
(38,'thyro lid 9',NULL,560000,NULL,1,0,'2022-08-20 16:22:44','2022-08-20 16:22:44'),
(39,'metamax adult 4 (MTMA4)',NULL,210000,NULL,1,0,'2022-08-20 16:23:16','2022-08-20 16:23:16'),
(40,'Metamax adult 9 (MTMA9)',NULL,420000,NULL,1,0,'2022-08-20 16:23:40','2022-08-20 16:23:40'),
(41,'Metamax hộp',NULL,160000,NULL,1,0,'2022-08-20 16:24:00','2022-08-20 16:24:00'),
(42,'cerna hộp',NULL,220000,NULL,1,0,'2022-08-20 16:24:17','2022-08-20 16:24:17'),
(43,'cerna 4',NULL,220000,NULL,1,0,'2022-08-20 16:24:30','2022-08-20 16:24:30'),
(44,'cerna 9',NULL,440000,NULL,1,0,'2022-08-20 16:24:46','2022-08-20 16:24:46');

/*Table structure for table `roles` */

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `roles` */

insert  into `roles`(`id`,`name`,`display_name`,`created_at`,`updated_at`) values 
(1,'admin','Administrator','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(2,'user','Normal User','2022-08-20 03:05:03','2022-08-20 03:05:03');

/*Table structure for table `settings` */

DROP TABLE IF EXISTS `settings`;

CREATE TABLE `settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `details` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  `group` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_key_unique` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `settings` */

insert  into `settings`(`id`,`key`,`display_name`,`value`,`details`,`type`,`order`,`group`) values 
(1,'site.title','Site Title','Site Title','','text',1,'Site'),
(2,'site.description','Site Description','Site Description','','text',2,'Site'),
(3,'site.logo','Site Logo','','','image',3,'Site'),
(4,'site.google_analytics_tracking_id','Google Analytics Tracking ID','','','text',4,'Site'),
(5,'admin.bg_image','Admin Background Image','','','image',5,'Admin'),
(6,'admin.title','Admin Title','Voyager','','text',1,'Admin'),
(7,'admin.description','Admin Description','Welcome to Voyager. The Missing Admin for Laravel','','text',2,'Admin'),
(8,'admin.loader','Admin Loader','','','image',3,'Admin'),
(9,'admin.icon_image','Admin Icon Image','','','image',4,'Admin'),
(10,'admin.google_analytics_client_id','Google Analytics Client ID (used for admin dashboard)','','','text',1,'Admin');

/*Table structure for table `translations` */

DROP TABLE IF EXISTS `translations`;

CREATE TABLE `translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `table_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `column_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `foreign_key` int(10) unsigned NOT NULL,
  `locale` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `translations_table_name_column_name_foreign_key_locale_unique` (`table_name`,`column_name`,`foreign_key`,`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `translations` */

insert  into `translations`(`id`,`table_name`,`column_name`,`foreign_key`,`locale`,`value`,`created_at`,`updated_at`) values 
(1,'data_types','display_name_singular',5,'pt','Post','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(2,'data_types','display_name_singular',6,'pt','Página','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(3,'data_types','display_name_singular',1,'pt','Utilizador','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(4,'data_types','display_name_singular',4,'pt','Categoria','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(5,'data_types','display_name_singular',2,'pt','Menu','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(6,'data_types','display_name_singular',3,'pt','Função','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(7,'data_types','display_name_plural',5,'pt','Posts','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(8,'data_types','display_name_plural',6,'pt','Páginas','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(9,'data_types','display_name_plural',1,'pt','Utilizadores','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(10,'data_types','display_name_plural',4,'pt','Categorias','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(11,'data_types','display_name_plural',2,'pt','Menus','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(12,'data_types','display_name_plural',3,'pt','Funções','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(13,'categories','slug',1,'pt','categoria-1','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(14,'categories','name',1,'pt','Categoria 1','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(15,'categories','slug',2,'pt','categoria-2','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(16,'categories','name',2,'pt','Categoria 2','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(17,'pages','title',1,'pt','Olá Mundo','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(18,'pages','slug',1,'pt','ola-mundo','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(19,'pages','body',1,'pt','<p>Olá Mundo. Scallywag grog swab Cat o\'nine tails scuttle rigging hardtack cable nipper Yellow Jack. Handsomely spirits knave lad killick landlubber or just lubber deadlights chantey pinnace crack Jennys tea cup. Provost long clothes black spot Yellow Jack bilged on her anchor league lateen sail case shot lee tackle.</p>\r\n<p>Ballast spirits fluke topmast me quarterdeck schooner landlubber or just lubber gabion belaying pin. Pinnace stern galleon starboard warp carouser to go on account dance the hempen jig jolly boat measured fer yer chains. Man-of-war fire in the hole nipperkin handsomely doubloon barkadeer Brethren of the Coast gibbet driver squiffy.</p>','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(20,'menu_items','title',1,'pt','Painel de Controle','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(21,'menu_items','title',2,'pt','Media','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(22,'menu_items','title',12,'pt','Publicações','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(23,'menu_items','title',3,'pt','Utilizadores','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(24,'menu_items','title',11,'pt','Categorias','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(25,'menu_items','title',13,'pt','Páginas','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(26,'menu_items','title',4,'pt','Funções','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(27,'menu_items','title',5,'pt','Ferramentas','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(28,'menu_items','title',6,'pt','Menus','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(29,'menu_items','title',7,'pt','Base de dados','2022-08-20 03:05:03','2022-08-20 03:05:03'),
(30,'menu_items','title',10,'pt','Configurações','2022-08-20 03:05:03','2022-08-20 03:05:03');

/*Table structure for table `type_export` */

DROP TABLE IF EXISTS `type_export`;

CREATE TABLE `type_export` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` int(11) DEFAULT NULL,
  `discount_percent` int(11) DEFAULT NULL,
  `discount` int(11) DEFAULT NULL,
  `ship` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `type_export` */

/*Table structure for table `type_product` */

DROP TABLE IF EXISTS `type_product`;

CREATE TABLE `type_product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `type_product` */

insert  into `type_product`(`id`,`name`,`created_at`,`updated_at`) values 
(1,'Nutricare','2022-08-20 11:32:53','2022-08-20 11:32:53');

/*Table structure for table `user_roles` */

DROP TABLE IF EXISTS `user_roles`;

CREATE TABLE `user_roles` (
  `user_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `user_roles_user_id_index` (`user_id`),
  KEY `user_roles_role_id_index` (`role_id`),
  CONSTRAINT `user_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_roles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `user_roles` */

insert  into `user_roles`(`user_id`,`role_id`) values 
(2,1);

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'users/default.png',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `settings` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_role_id_foreign` (`role_id`),
  CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `users` */

insert  into `users`(`id`,`role_id`,`name`,`email`,`avatar`,`email_verified_at`,`password`,`remember_token`,`settings`,`created_at`,`updated_at`) values 
(1,1,'Admin','admin@admin.com','users/default.png',NULL,'$2y$10$L1rN6drLFrtoH8DPWc3r/.fmRvHkGNuxv63r0TKgbfmYhB04Voc/S','46m45EZuG0Jrk88F4vsA09lNT8e6hB5EfOSHrlZctbpUrJtxeIHM2g0dSHWZ',NULL,'2022-08-20 03:05:03','2022-08-20 03:05:03'),
(2,1,'Quốc Đạt','qdatvirgo@gmail.com','users\\August2022\\g7hG4wjMxQhoDGrtZN2A.jpg',NULL,'$2y$10$U0YhtTn/L50UZr15qxJuX.59Wtv5qrJsAo3H3miEhfOZwol8UZ36.',NULL,'{\"locale\":\"en\"}','2022-08-20 14:22:48','2022-08-22 03:11:42');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
