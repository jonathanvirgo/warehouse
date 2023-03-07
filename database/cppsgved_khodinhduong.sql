-- phpMyAdmin SQL Dump
-- version 4.9.11
-- https://www.phpmyadmin.net/
--
-- Máy chủ: localhost:3306
-- Thời gian đã tạo: Th3 07, 2023 lúc 09:46 AM
-- Phiên bản máy phục vụ: 10.3.38-MariaDB
-- Phiên bản PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `cppsgved_khodinhduong`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `brands`
--

CREATE TABLE `brands` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(1024) NOT NULL,
  `campain_id` int(10) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `brands`
--

INSERT INTO `brands` (`id`, `name`, `campain_id`, `created_at`, `updated_at`) VALUES
(1, 'Nutricare', 1, '2022-08-20 04:32:53', '2022-08-20 04:32:53'),
(2, 'nestle', 1, '2022-08-27 10:04:43', '2022-08-27 10:04:43'),
(3, 'vitadaily', 1, '2022-08-27 10:04:51', '2022-08-27 10:04:51'),
(4, 'abbott', 1, '2022-08-27 10:04:59', '2022-08-27 10:04:59'),
(5, 'otsuka', 1, '2022-08-27 10:08:34', '2022-08-27 10:08:34'),
(6, 'orgalife', 1, '2022-09-02 01:14:20', '2022-09-02 01:14:20'),
(7, 'vietcom', 1, '2022-10-26 01:35:23', '2022-10-26 01:35:23');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `campain`
--

CREATE TABLE `campain` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(1024) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `campain`
--

INSERT INTO `campain` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Thơm', '2022-08-30 01:05:44', '2022-08-30 01:05:44');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `categories`
--

INSERT INTO `categories` (`id`, `parent_id`, `order`, `name`, `slug`, `created_at`, `updated_at`) VALUES
(1, NULL, 1, 'Category 1', 'category-1', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(2, NULL, 1, 'Category 2', 'category-2', '2022-08-19 20:05:03', '2022-08-19 20:05:03');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `data_rows`
--

CREATE TABLE `data_rows` (
  `id` int(10) UNSIGNED NOT NULL,
  `data_type_id` int(10) UNSIGNED NOT NULL,
  `field` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `browse` tinyint(1) NOT NULL DEFAULT 1,
  `read` tinyint(1) NOT NULL DEFAULT 1,
  `edit` tinyint(1) NOT NULL DEFAULT 1,
  `add` tinyint(1) NOT NULL DEFAULT 1,
  `delete` tinyint(1) NOT NULL DEFAULT 1,
  `details` text DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `data_rows`
--

INSERT INTO `data_rows` (`id`, `data_type_id`, `field`, `type`, `display_name`, `required`, `browse`, `read`, `edit`, `add`, `delete`, `details`, `order`) VALUES
(1, 1, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
(2, 1, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 2),
(3, 1, 'email', 'text', 'Email', 1, 1, 1, 1, 1, 1, NULL, 3),
(4, 1, 'password', 'password', 'Password', 1, 0, 0, 1, 1, 0, NULL, 4),
(5, 1, 'remember_token', 'text', 'Remember Token', 0, 0, 0, 0, 0, 0, NULL, 5),
(6, 1, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 0, 0, 0, NULL, 6),
(7, 1, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 7),
(8, 1, 'avatar', 'image', 'Avatar', 0, 1, 1, 1, 1, 1, NULL, 8),
(9, 1, 'user_belongsto_role_relationship', 'relationship', 'Role', 0, 1, 1, 1, 1, 0, '{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsTo\",\"column\":\"role_id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"roles\",\"pivot\":0}', 10),
(10, 1, 'user_belongstomany_role_relationship', 'relationship', 'voyager::seeders.data_rows.roles', 0, 1, 1, 1, 1, 0, '{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsToMany\",\"column\":\"id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"user_roles\",\"pivot\":\"1\",\"taggable\":\"0\"}', 11),
(11, 1, 'settings', 'hidden', 'Settings', 0, 0, 0, 0, 0, 0, NULL, 12),
(12, 2, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
(13, 2, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 2),
(14, 2, 'created_at', 'timestamp', 'Created At', 0, 0, 0, 0, 0, 0, NULL, 3),
(15, 2, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 4),
(16, 3, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
(17, 3, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 2),
(18, 3, 'created_at', 'timestamp', 'Created At', 0, 0, 0, 0, 0, 0, NULL, 3),
(19, 3, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 4),
(20, 3, 'display_name', 'text', 'Display Name', 1, 1, 1, 1, 1, 1, NULL, 5),
(21, 1, 'role_id', 'text', 'Role', 1, 1, 1, 1, 1, 1, NULL, 9),
(22, 4, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
(23, 4, 'parent_id', 'select_dropdown', 'Parent', 0, 0, 1, 1, 1, 1, '{\"default\":\"\",\"null\":\"\",\"options\":{\"\":\"-- None --\"},\"relationship\":{\"key\":\"id\",\"label\":\"name\"}}', 2),
(24, 4, 'order', 'text', 'Order', 1, 1, 1, 1, 1, 1, '{\"default\":1}', 3),
(25, 4, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 4),
(26, 4, 'slug', 'text', 'Slug', 1, 1, 1, 1, 1, 1, '{\"slugify\":{\"origin\":\"name\"}}', 5),
(27, 4, 'created_at', 'timestamp', 'Created At', 0, 0, 1, 0, 0, 0, NULL, 6),
(28, 4, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 7),
(29, 5, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
(30, 5, 'author_id', 'text', 'Author', 1, 0, 1, 1, 0, 1, NULL, 2),
(31, 5, 'category_id', 'text', 'Category', 1, 0, 1, 1, 1, 0, NULL, 3),
(32, 5, 'title', 'text', 'Title', 1, 1, 1, 1, 1, 1, NULL, 4),
(33, 5, 'excerpt', 'text_area', 'Excerpt', 1, 0, 1, 1, 1, 1, NULL, 5),
(34, 5, 'body', 'rich_text_box', 'Body', 1, 0, 1, 1, 1, 1, NULL, 6),
(35, 5, 'image', 'image', 'Post Image', 0, 1, 1, 1, 1, 1, '{\"resize\":{\"width\":\"1000\",\"height\":\"null\"},\"quality\":\"70%\",\"upsize\":true,\"thumbnails\":[{\"name\":\"medium\",\"scale\":\"50%\"},{\"name\":\"small\",\"scale\":\"25%\"},{\"name\":\"cropped\",\"crop\":{\"width\":\"300\",\"height\":\"250\"}}]}', 7),
(36, 5, 'slug', 'text', 'Slug', 1, 0, 1, 1, 1, 1, '{\"slugify\":{\"origin\":\"title\",\"forceUpdate\":true},\"validation\":{\"rule\":\"unique:posts,slug\"}}', 8),
(37, 5, 'meta_description', 'text_area', 'Meta Description', 1, 0, 1, 1, 1, 1, NULL, 9),
(38, 5, 'meta_keywords', 'text_area', 'Meta Keywords', 1, 0, 1, 1, 1, 1, NULL, 10),
(39, 5, 'status', 'select_dropdown', 'Status', 1, 1, 1, 1, 1, 1, '{\"default\":\"DRAFT\",\"options\":{\"PUBLISHED\":\"published\",\"DRAFT\":\"draft\",\"PENDING\":\"pending\"}}', 11),
(40, 5, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 0, 0, 0, NULL, 12),
(41, 5, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 13),
(42, 5, 'seo_title', 'text', 'SEO Title', 0, 1, 1, 1, 1, 1, NULL, 14),
(43, 5, 'featured', 'checkbox', 'Featured', 1, 1, 1, 1, 1, 1, NULL, 15),
(44, 6, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
(45, 6, 'author_id', 'text', 'Author', 1, 0, 0, 0, 0, 0, NULL, 2),
(46, 6, 'title', 'text', 'Title', 1, 1, 1, 1, 1, 1, NULL, 3),
(47, 6, 'excerpt', 'text_area', 'Excerpt', 1, 0, 1, 1, 1, 1, NULL, 4),
(48, 6, 'body', 'rich_text_box', 'Body', 1, 0, 1, 1, 1, 1, NULL, 5),
(49, 6, 'slug', 'text', 'Slug', 1, 0, 1, 1, 1, 1, '{\"slugify\":{\"origin\":\"title\"},\"validation\":{\"rule\":\"unique:pages,slug\"}}', 6),
(50, 6, 'meta_description', 'text', 'Meta Description', 1, 0, 1, 1, 1, 1, NULL, 7),
(51, 6, 'meta_keywords', 'text', 'Meta Keywords', 1, 0, 1, 1, 1, 1, NULL, 8),
(52, 6, 'status', 'select_dropdown', 'Status', 1, 1, 1, 1, 1, 1, '{\"default\":\"INACTIVE\",\"options\":{\"INACTIVE\":\"INACTIVE\",\"ACTIVE\":\"ACTIVE\"}}', 9),
(53, 6, 'created_at', 'timestamp', 'Created At', 1, 1, 1, 0, 0, 0, NULL, 10),
(54, 6, 'updated_at', 'timestamp', 'Updated At', 1, 0, 0, 0, 0, 0, NULL, 11),
(55, 6, 'image', 'image', 'Page Image', 0, 1, 1, 1, 1, 1, NULL, 12),
(56, 8, 'id', 'text', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(57, 8, 'name', 'text', 'Tên', 1, 1, 1, 1, 1, 1, '{}', 2),
(60, 8, 'image', 'image', 'Image', 0, 1, 1, 1, 1, 1, '{}', 7),
(62, 8, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 1, 0, 1, '{}', 8),
(63, 8, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 9),
(91, 13, 'id', 'text', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(92, 13, 'name', 'text', 'Name', 0, 1, 1, 1, 1, 1, '{}', 2),
(93, 13, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 1, 0, 1, '{}', 3),
(94, 13, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 4),
(95, 8, 'product_hasone_type_product_relationship', 'relationship', 'Hãng', 1, 1, 1, 1, 1, 1, '{\"display\":{\"width\":\"6\"},\"model\":\"App\\\\Models\\\\Brand\",\"table\":\"brands\",\"type\":\"belongsTo\",\"column\":\"brand_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"categories\",\"pivot\":\"0\",\"taggable\":\"0\"}', 4),
(98, 14, 'id', 'text', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(99, 14, 'name', 'text', 'Name', 0, 1, 1, 1, 1, 1, '{}', 2),
(100, 14, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 1, 0, 1, '{}', 3),
(101, 14, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 4),
(102, 15, 'id', 'text', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(103, 15, 'name', 'text', 'Name', 0, 1, 1, 1, 1, 1, '{}', 2),
(104, 15, 'discount_percent', 'text', 'Discount Percent', 0, 1, 1, 1, 1, 1, '{\"display\":{\"width\":\"6\"},\"default\":0}', 3),
(105, 15, 'discount', 'text', 'Discount', 0, 1, 1, 1, 1, 1, '{\"display\":{\"width\":\"6\"},\"default\":0}', 4),
(106, 15, 'ship', 'text', 'Ship', 0, 1, 1, 1, 1, 1, '{\"display\":{\"width\":\"6\"},\"default\":0}', 5),
(107, 15, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 1, 0, 1, '{\"display\":{\"width\":\"6\"}}', 6),
(108, 15, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 7),
(109, 16, 'id', 'text', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(110, 16, 'pro_id', 'number', 'Pro Id', 1, 1, 1, 1, 1, 1, '{}', 8),
(112, 16, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 1, 0, 1, '{\"display\":{\"width\":\"6\"}}', 10),
(113, 16, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 11),
(116, 16, 'price', 'number', 'Giá', 1, 1, 1, 1, 1, 1, '{\"display\":{\"width\":\"6\"}}', 7),
(117, 16, 'warehouse_id', 'number', 'Warehouse Id', 1, 1, 1, 1, 1, 1, '{}', 9),
(118, 17, 'id', 'text', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(119, 17, 'name', 'text', 'Name', 0, 1, 1, 1, 1, 1, '{}', 2),
(120, 17, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 1, 0, 1, '{}', 3),
(121, 17, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 4),
(122, 16, 'price_belongsto_product_relationship', 'relationship', 'Sản phẩm', 1, 1, 1, 1, 1, 1, '{\"display\":{\"width\":\"6\"},\"model\":\"App\\\\Models\\\\Product\",\"table\":\"products\",\"type\":\"belongsTo\",\"column\":\"pro_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"categories\",\"pivot\":\"0\",\"taggable\":\"0\"}', 2),
(124, 16, 'price_belongsto_type_warehouse_relationship', 'relationship', 'Kho', 1, 1, 1, 1, 1, 1, '{\"display\":{\"width\":\"6\"},\"model\":\"App\\\\Models\\\\Warehouse\",\"table\":\"brands\",\"type\":\"belongsTo\",\"column\":\"warehouse_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"categories\",\"pivot\":\"0\",\"taggable\":\"0\"}', 3),
(125, 8, 'brand_id', 'text', 'Brand Id', 0, 1, 1, 1, 1, 1, '{}', 3),
(126, 16, 'im_export', 'select_dropdown', 'Nhập - Xuất', 1, 1, 1, 1, 1, 1, '{\"display\":{\"width\":\"6\"},\"default\":\"option1\",\"options\":{\"nhap\":\"Nh\\u1eadp\",\"xuat\":\"Xu\\u1ea5t\"}}', 4),
(127, 18, 'id', 'text', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(128, 18, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, '{\"display\":{\"width\":\"6\"}}', 2),
(129, 18, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 1, 0, 1, '{}', 4),
(130, 18, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 6),
(131, 19, 'id', 'text', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(132, 19, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, '{\"display\":{\"width\":\"6\"}}', 2),
(133, 19, 'discount_percent', 'number', 'Discount Percent', 0, 1, 1, 1, 1, 1, '{\"display\":{\"width\":\"6\"}}', 4),
(134, 19, 'discount_number', 'number', 'Discount Number', 0, 1, 1, 1, 1, 1, '{\"display\":{\"width\":\"6\"}}', 5),
(136, 19, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 1, 0, 1, '{\"display\":{\"width\":\"6\"}}', 7),
(137, 19, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 8),
(138, 20, 'id', 'text', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(139, 20, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, '{\"display\":{\"width\":\"6\"}}', 2),
(140, 20, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 1, 0, 1, '{}', 4),
(141, 20, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 6),
(142, 21, 'id', 'text', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(143, 21, 'name', 'text', 'Name', 0, 1, 1, 1, 1, 1, '{}', 2),
(144, 21, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 1, 0, 1, '{}', 3),
(145, 21, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 4),
(146, 18, 'brand_belongsto_campain_relationship', 'relationship', 'Campain', 0, 0, 0, 0, 0, 0, '{\"display\":{\"width\":\"6\"},\"model\":\"App\\\\Models\\\\Campain\",\"table\":\"campain\",\"type\":\"belongsTo\",\"column\":\"campain_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"brands\",\"pivot\":\"0\",\"taggable\":\"0\"}', 3),
(147, 18, 'campain_id', 'text', 'Campain Id', 0, 0, 0, 0, 0, 0, '{}', 5),
(148, 19, 'discount_belongsto_campain_relationship', 'relationship', 'Campain', 0, 0, 0, 0, 0, 0, '{\"display\":{\"width\":\"6\"},\"model\":\"App\\\\Models\\\\Campain\",\"table\":\"campain\",\"type\":\"belongsTo\",\"column\":\"campain_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"brands\",\"pivot\":\"0\",\"taggable\":\"0\"}', 3),
(149, 19, 'campain_id', 'text', 'Campain Id', 0, 0, 0, 0, 0, 0, '{}', 6),
(150, 16, 'price_belongsto_campain_relationship', 'relationship', 'Campain', 0, 0, 0, 0, 0, 0, '{\"display\":{\"width\":\"6\"},\"model\":\"App\\\\Models\\\\Campain\",\"table\":\"campain\",\"type\":\"belongsTo\",\"column\":\"campain_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"brands\",\"pivot\":\"0\",\"taggable\":\"0\"}', 6),
(151, 16, 'campain_id', 'text', 'Campain Id', 0, 0, 0, 0, 0, 0, '{}', 5),
(152, 8, 'product_belongsto_campain_relationship', 'relationship', 'Campain', 0, 0, 0, 0, 0, 0, '{\"display\":{\"width\":\"6\"},\"model\":\"App\\\\Models\\\\Campain\",\"table\":\"campain\",\"type\":\"belongsTo\",\"column\":\"campain_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"brands\",\"pivot\":\"0\",\"taggable\":\"0\"}', 6),
(153, 8, 'campain_id', 'text', 'Campain Id', 0, 0, 0, 0, 0, 0, '{}', 5),
(154, 20, 'warehouse_belongsto_campain_relationship', 'relationship', 'Campain', 0, 0, 0, 0, 0, 0, '{\"display\":{\"width\":\"6\"},\"model\":\"App\\\\Models\\\\Campain\",\"table\":\"campain\",\"type\":\"belongsTo\",\"column\":\"campain_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"brands\",\"pivot\":\"0\",\"taggable\":\"0\"}', 3),
(155, 20, 'campain_id', 'text', 'Campain Id', 0, 0, 0, 0, 0, 0, '{}', 5);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `data_types`
--

CREATE TABLE `data_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `display_name_singular` varchar(255) NOT NULL,
  `display_name_plural` varchar(255) NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `model_name` varchar(255) DEFAULT NULL,
  `policy_name` varchar(255) DEFAULT NULL,
  `controller` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `generate_permissions` tinyint(1) NOT NULL DEFAULT 0,
  `server_side` tinyint(4) NOT NULL DEFAULT 0,
  `details` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `data_types`
--

INSERT INTO `data_types` (`id`, `name`, `slug`, `display_name_singular`, `display_name_plural`, `icon`, `model_name`, `policy_name`, `controller`, `description`, `generate_permissions`, `server_side`, `details`, `created_at`, `updated_at`) VALUES
(1, 'users', 'users', 'User', 'Users', 'voyager-person', 'TCG\\Voyager\\Models\\User', 'TCG\\Voyager\\Policies\\UserPolicy', 'TCG\\Voyager\\Http\\Controllers\\VoyagerUserController', '', 1, 0, NULL, '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(2, 'menus', 'menus', 'Menu', 'Menus', 'voyager-list', 'TCG\\Voyager\\Models\\Menu', NULL, '', '', 1, 0, NULL, '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(3, 'roles', 'roles', 'Role', 'Roles', 'voyager-lock', 'TCG\\Voyager\\Models\\Role', NULL, 'TCG\\Voyager\\Http\\Controllers\\VoyagerRoleController', '', 1, 0, NULL, '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(4, 'categories', 'categories', 'Category', 'Categories', 'voyager-categories', 'TCG\\Voyager\\Models\\Category', NULL, '', '', 1, 0, NULL, '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(5, 'posts', 'posts', 'Post', 'Posts', 'voyager-news', 'TCG\\Voyager\\Models\\Post', 'TCG\\Voyager\\Policies\\PostPolicy', '', '', 1, 0, NULL, '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(6, 'pages', 'pages', 'Page', 'Pages', 'voyager-file-text', 'TCG\\Voyager\\Models\\Page', NULL, '', '', 1, 0, NULL, '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(8, 'products', 'products', 'Sản phẩm', 'Sản phẩm', NULL, 'App\\Models\\Product', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2022-08-19 20:10:16', '2022-09-04 20:42:24'),
(13, 'type_product', 'type-product', 'Loại sản phẩm', 'Loại sản phẩm', 'voyager-categories', 'App\\Models\\TypeProduct', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null}', '2022-08-20 04:31:40', '2022-08-20 04:31:40'),
(14, 'type_warehouse', 'type-warehouse', 'Loại Kho', 'Loại Kho', 'voyager-categories', 'App\\Models\\TypeWarehouse', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null}', '2022-08-25 02:29:54', '2022-08-25 02:29:54'),
(15, 'type_export', 'type-export', 'Loại Export', 'Loại Export', 'voyager-categories', 'App\\Models\\TypeExport', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2022-08-26 01:16:40', '2022-08-26 01:23:27'),
(16, 'price', 'price', 'Price', 'Prices', NULL, 'App\\Models\\Price', NULL, '\\App\\Http\\Controllers\\Voyager\\PriceController', NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2022-08-26 02:36:28', '2022-09-04 20:43:03'),
(17, 'type_brand', 'type-brand', 'Hãng', 'Hãng', NULL, 'App\\Models\\TypeBrand', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null}', '2022-08-26 18:52:09', '2022-08-26 18:52:09'),
(18, 'brands', 'brands', 'Nhãn hàng', 'Nhãn hàng', NULL, 'App\\Models\\Brand', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2022-08-27 06:54:21', '2022-09-04 20:42:38'),
(19, 'discount', 'discount', 'Chiết khấu', 'Chiết khấu', NULL, 'App\\Models\\Discount', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2022-08-27 06:58:04', '2022-09-04 20:44:03'),
(20, 'warehouse', 'warehouse', 'Warehouse', 'Warehouses', 'voyager-home', 'App\\Models\\Warehouse', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2022-08-27 07:01:27', '2022-09-04 20:44:28'),
(21, 'campain', 'campain', 'Campain', 'Campains', 'voyager-group', 'App\\Models\\Campain', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null}', '2022-08-30 01:05:01', '2022-08-30 01:05:01');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `debts`
--

CREATE TABLE `debts` (
  `id` int(10) UNSIGNED NOT NULL,
  `pro_id` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `report_date` date DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `campain_id` int(10) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `debts`
--

INSERT INTO `debts` (`id`, `pro_id`, `price`, `total`, `report_date`, `created_by`, `brand_id`, `warehouse_id`, `campain_id`, `created_at`, `updated_at`) VALUES
(5, 42, 220000, 0, '2022-06-29', 2, NULL, 1, 1, '2022-08-22 09:12:58', '2022-08-22 09:38:39'),
(6, 4, 340000, 3, '2022-06-29', 2, NULL, 1, 1, '2022-08-22 09:12:58', '2023-02-20 20:42:46'),
(7, 6, 340000, 3, '2022-06-29', 2, NULL, 1, 1, '2022-08-22 09:12:58', '2023-02-20 20:31:50'),
(8, 8, 340000, 12, '2022-06-29', 2, 1, 1, 1, '2022-08-22 09:12:58', '2023-03-06 01:47:36'),
(9, 9, 210000, 2, '2022-06-29', 2, NULL, 1, 1, '2022-08-22 09:12:58', '2022-12-07 07:01:13'),
(10, 10, 420000, 0, '2022-06-29', 2, NULL, 1, 1, '2022-08-22 09:12:58', '2022-12-07 06:57:12'),
(11, 11, 215000, 3, '2022-06-29', 2, NULL, 1, 1, '2022-08-22 09:12:58', '2023-02-27 07:14:55'),
(12, 13, 230000, 3, '2022-06-29', 2, NULL, 1, 1, '2022-08-22 09:12:58', '2022-08-22 09:12:58'),
(13, 15, 440000, 0, '2022-06-29', 2, 1, 1, 1, '2022-08-22 09:12:58', '2023-01-19 04:55:08'),
(14, 16, 230000, 0, '2022-06-29', 2, NULL, 1, 1, '2022-08-22 09:12:59', '2022-09-03 07:21:54'),
(15, 17, 220000, 3, '2022-06-29', 2, NULL, 1, 1, '2022-08-22 09:12:59', '2023-01-15 07:34:50'),
(16, 18, 440000, 12, '2022-06-29', 2, 1, 1, 1, '2022-08-22 09:12:59', '2023-03-06 01:48:22'),
(17, 21, 230000, 0, '2022-06-29', 2, 1, 1, 1, '2022-08-22 09:12:59', '2022-09-23 01:50:33'),
(18, 23, 440000, 6, '2022-06-29', 2, 1, 1, 1, '2022-08-22 09:12:59', '2023-01-15 07:31:10'),
(19, 24, 210000, 0, '2022-06-29', 2, NULL, 1, 1, '2022-08-22 09:12:59', '2022-08-22 09:38:39'),
(20, 26, 210000, 4, '2022-06-29', 2, NULL, 1, 1, '2022-08-22 09:12:59', '2023-01-19 04:55:54'),
(21, 27, 420000, 3, '2022-06-29', 2, NULL, 1, 1, '2022-08-22 09:12:59', '2023-03-05 09:44:59'),
(22, 29, 210000, 4, '2022-06-29', 2, NULL, 1, 1, '2022-08-22 09:12:59', '2023-01-29 20:39:32'),
(23, 30, 320000, 0, '2022-06-29', 2, 1, 1, 1, '2022-08-22 09:12:59', '2022-12-07 06:57:12'),
(24, 31, 260000, 2, '2022-06-29', 2, NULL, 1, 1, '2022-08-22 09:12:59', '2023-02-19 19:59:07'),
(25, 32, 520000, 2, '2022-06-29', 2, 1, 1, 1, '2022-08-22 09:12:59', '2023-02-19 19:59:07'),
(26, 35, 500000, 6, '2022-06-29', 2, 1, 1, 1, '2022-08-22 09:12:59', '2023-03-06 01:46:43'),
(27, 38, 560000, 2, '2022-06-29', 2, 1, 1, 1, '2022-08-22 09:12:59', '2023-03-06 01:46:43'),
(28, 41, 160000, 3, '2022-06-29', 2, NULL, 1, 1, '2022-08-22 09:12:59', '2023-01-19 04:55:08'),
(29, 39, 210000, 3, '2022-06-29', 2, 1, 1, 1, '2022-08-22 09:12:59', '2022-09-14 00:53:12'),
(30, 40, 420000, 1, '2022-06-29', 2, 1, 1, 1, '2022-08-22 09:12:59', '2023-01-19 04:55:08'),
(31, 44, 440000, 4, '2022-06-29', 2, 1, 1, 1, '2022-08-22 09:12:59', '2023-02-27 07:14:55'),
(32, 34, 250000, 2, '2022-07-25', 2, 1, 1, 1, '2022-08-22 09:32:30', '2023-01-08 21:19:17'),
(33, 45, 23000, 30, '2022-08-12', 2, NULL, 1, 1, '2022-08-22 09:50:49', '2022-08-22 09:50:49'),
(34, 43, 220000, 3, '2022-08-17', 3, NULL, 1, 1, '2022-08-23 02:39:01', '2023-01-29 20:42:05'),
(35, 22, 220000, 7, '2022-08-17', 3, NULL, 1, 1, '2022-08-23 02:39:01', '2023-01-09 05:28:17'),
(36, 4, 250000, 0, '2022-08-19', 3, NULL, 1, 1, '2022-08-23 02:43:30', '2022-12-07 08:15:13'),
(37, 20, 540000, 0, '2022-08-23', 3, NULL, 1, 1, '2022-08-23 02:46:08', '2022-12-07 06:57:12'),
(38, 14, 220000, 3, '2022-08-24', 3, NULL, 1, 1, '2022-08-23 19:47:25', '2023-01-29 20:39:32'),
(40, 21, 263000, 0, '2022-08-29', 3, NULL, 3, 1, '2022-09-02 02:24:11', '2022-09-14 00:58:04'),
(41, 54, 685000, 1, '2022-08-29', 3, NULL, 3, 1, '2022-09-02 02:24:11', '2022-09-02 02:24:11'),
(42, 17, 240000, 0, '2022-08-29', 3, NULL, 3, 1, '2022-09-02 02:24:11', '2022-09-14 00:58:04'),
(43, 31, 297000, 0, '2022-08-29', 3, NULL, 3, 1, '2022-09-02 02:24:11', '2022-09-14 00:58:04'),
(44, 48, 210000, 0, '2022-08-29', 3, NULL, 3, 1, '2022-09-02 02:24:11', '2022-09-23 22:42:09'),
(45, 46, 405000, 1, '2022-08-29', 3, NULL, 3, 1, '2022-09-02 02:24:11', '2022-09-23 22:39:30'),
(46, 51, 180000, 0, '2022-08-29', 3, NULL, 3, 1, '2022-09-02 02:24:11', '2022-09-23 22:42:09'),
(47, 29, 225000, 0, '2022-08-29', 3, NULL, 3, 1, '2022-09-02 02:24:11', '2022-09-14 00:58:04'),
(48, 55, 61000, 27, '2022-08-29', 3, NULL, 3, 1, '2022-09-02 02:24:11', '2022-09-06 08:33:16'),
(49, 59, 44500, 0, '2022-08-29', 3, NULL, 3, 1, '2022-09-02 02:24:11', '2022-09-23 22:40:09'),
(50, 56, 27000, 0, '2022-08-29', 3, NULL, 3, 1, '2022-09-02 02:24:11', '2022-09-23 22:40:46'),
(51, 57, 35000, 0, '2022-08-29', 3, NULL, 3, 1, '2022-09-02 02:24:11', '2022-09-23 22:40:09'),
(52, 60, 37500, 0, '2022-08-29', 3, NULL, 3, 1, '2022-09-02 02:24:11', '2022-09-23 22:39:30'),
(53, 61, 47500, 0, '2022-08-29', 3, NULL, 3, 1, '2022-09-02 02:24:11', '2022-09-23 22:39:30'),
(54, 58, 36500, 24, '2022-08-29', 3, NULL, 3, 1, '2022-09-02 02:24:11', '2022-09-06 08:33:16'),
(55, 9, 263000, 0, '2022-08-29', 3, NULL, 3, 1, '2022-09-02 02:26:03', '2022-09-14 00:58:04'),
(56, 39, 248000, 0, '2022-08-29', 3, NULL, 3, 1, '2022-09-02 02:26:03', '2022-09-14 00:58:04'),
(57, 21, 256000, 1, '2021-11-20', 3, NULL, 2, 1, '2022-09-02 02:28:41', '2022-09-02 02:28:41'),
(58, 42, 256000, 1, '2021-11-20', 3, NULL, 2, 1, '2022-09-02 02:28:41', '2022-09-02 02:28:41'),
(59, 16, 256000, 1, '2021-11-20', 3, NULL, 2, 1, '2022-09-02 02:29:56', '2022-09-02 02:29:56'),
(60, 5, 200000, 5, '2022-07-27', 3, NULL, 2, 1, '2022-09-02 02:36:16', '2022-10-10 22:44:13'),
(61, 7, 200000, 5, '2022-08-14', 3, NULL, 2, 1, '2022-09-02 02:36:16', '2022-11-04 19:54:16'),
(62, 8, 416000, 5, '2022-08-14', 3, NULL, 2, 1, '2022-09-02 02:36:16', '2022-11-04 19:54:16'),
(63, 6, 416000, 5, '2022-08-14', 3, NULL, 2, 1, '2022-09-02 02:36:16', '2022-10-10 22:44:40'),
(64, 24, 240000, 3, '2022-07-14', 3, NULL, 2, 1, '2022-09-02 02:40:12', '2022-09-02 02:40:12'),
(65, 63, 130000, 8, '2022-07-14', 3, NULL, 2, 1, '2022-09-02 02:40:12', '2022-09-02 02:40:51'),
(66, 64, 15000, 8, '2022-07-14', 3, NULL, 2, 1, '2022-09-02 02:40:12', '2022-09-02 02:40:12'),
(67, 66, 365600, 0, '2022-09-05', 3, NULL, 4, 1, '2022-09-04 19:48:23', '2022-10-29 23:09:05'),
(68, 7, 200000, 0, '2022-09-05', 3, NULL, 4, 1, '2022-09-04 19:48:23', '2022-10-29 23:09:05'),
(69, 8, 400000, 0, '2022-09-05', 3, NULL, 4, 1, '2022-09-04 19:48:23', '2023-01-15 07:44:53'),
(70, 47, 193350, 0, '2022-09-05', 3, NULL, 5, 1, '2022-09-04 19:53:20', '2022-09-14 01:46:46'),
(71, 48, 207225, 0, '2022-09-05', 3, NULL, 5, 1, '2022-09-04 19:53:20', '2022-09-14 01:46:46'),
(72, 51, 181800, 0, '2022-09-05', 3, NULL, 5, 1, '2022-09-04 19:53:20', '2022-09-14 01:46:46'),
(73, 66, 342750, 0, '2022-09-05', 3, NULL, 5, 1, '2022-09-04 19:53:20', '2022-09-14 01:43:51'),
(74, 59, 35600, 15, '2022-08-15', 3, NULL, 7, 1, '2022-09-04 20:02:36', '2022-09-04 20:02:36'),
(75, 56, 21600, 30, '2022-08-18', 3, NULL, 7, 1, '2022-09-04 20:02:36', '2022-09-04 20:02:36'),
(76, 57, 28000, 15, '2022-08-15', 3, NULL, 7, 1, '2022-09-04 20:02:36', '2022-09-04 20:02:36'),
(77, 61, 38000, 30, '2022-08-15', 3, NULL, 7, 1, '2022-09-04 20:02:36', '2022-09-04 20:02:36'),
(78, 58, 29200, 30, '2022-08-15', 3, NULL, 7, 1, '2022-09-04 20:02:36', '2022-09-04 20:02:36'),
(79, 47, 195000, 0, '2022-08-29', 3, NULL, 3, 1, '2022-09-04 21:34:49', '2022-09-23 22:42:09'),
(80, 12, 430000, 4, '2022-09-13', 3, NULL, 1, 1, '2022-09-12 06:45:44', '2022-12-07 08:26:57'),
(81, 71, 1000, 0, '2022-09-26', 3, NULL, 1, 1, '2022-09-23 01:57:22', '2022-09-26 04:26:32'),
(82, 65, 418400, 0, '2022-10-21', 3, NULL, 4, 1, '2022-10-20 22:33:09', '2022-10-21 01:43:48'),
(83, 65, 392250, 0, '2022-10-21', 3, NULL, 5, 1, '2022-10-20 22:33:28', '2022-10-21 01:44:13'),
(84, 25, 450000, 0, '2022-10-21', 3, NULL, 4, 1, '2022-10-21 01:59:51', '2022-10-22 05:54:14'),
(85, 72, 222000, 0, '2022-10-26', 3, NULL, 4, 1, '2022-10-26 02:32:50', '2022-11-27 08:04:48'),
(86, 73, 211500, 0, '2022-10-26', 3, NULL, 4, 1, '2022-10-26 02:32:50', '2022-11-27 08:04:48'),
(87, 74, 330000, 0, '2022-10-26', 3, NULL, 4, 1, '2022-10-26 02:32:50', '2022-11-27 08:04:48'),
(88, 98, 10400, 0, '2022-10-18', 3, NULL, 1, 1, '2022-10-31 23:10:56', '2023-02-27 07:14:55'),
(89, 10, 560000, 0, '2022-11-09', 3, NULL, 4, 1, '2022-11-09 02:19:28', '2022-11-27 08:04:48'),
(90, 78, 207200, 0, '2022-10-21', 3, NULL, 8, 1, '2022-11-18 07:07:23', '2022-11-27 08:05:47'),
(91, 80, 197400, 0, '2022-10-21', 3, NULL, 8, 1, '2022-11-18 07:07:23', '2022-11-27 08:05:47'),
(92, 74, 330000, 0, '2022-10-21', 3, NULL, 8, 1, '2022-11-18 07:08:54', '2022-11-27 08:05:47'),
(93, 90, 154000, 0, '2022-11-18', 3, NULL, 8, 1, '2022-11-18 08:44:07', '2022-11-27 08:05:47'),
(94, 91, 126000, 0, '2022-11-18', 3, NULL, 8, 1, '2022-11-18 08:44:07', '2022-12-20 07:34:36'),
(95, 89, 84000, 0, '2022-11-22', 3, NULL, 8, 1, '2022-11-22 07:25:57', '2023-01-12 19:58:05'),
(96, 7, 170000, 3, '2022-11-28', 3, NULL, 1, 1, '2022-12-02 03:17:51', '2023-02-27 07:14:55'),
(97, 20, 560000, 3, '2022-12-08', 3, NULL, 1, 1, '2022-12-08 08:14:51', '2023-01-29 20:46:06'),
(98, 100, 23000, 0, '2022-11-14', 3, NULL, 1, 1, '2022-12-09 08:28:26', '2022-12-09 08:29:31'),
(99, 101, 23000, 0, '2022-11-21', 3, NULL, 1, 1, '2022-12-09 08:28:26', '2022-12-09 08:29:31'),
(100, 95, 101500, 0, '2022-12-20', 3, NULL, 8, 1, '2022-12-20 07:32:03', '2022-12-20 07:34:36'),
(101, 37, 280000, 4, '2022-12-27', 3, NULL, 1, 1, '2022-12-30 23:16:37', '2023-01-29 20:42:05'),
(102, 5, 200000, 0, '2023-01-16', 3, NULL, 4, 1, '2023-01-15 07:39:59', '2023-01-15 07:44:53'),
(103, 3, 170000, 3, '2023-01-30', 3, NULL, 1, 1, '2023-01-29 20:42:05', '2023-01-29 20:42:05'),
(104, 5, 170000, 2, '2023-01-30', 3, NULL, 1, 1, '2023-01-29 20:42:05', '2023-01-29 20:42:05'),
(105, 19, 270000, 2, '2023-02-14', 3, NULL, 1, 1, '2023-02-14 08:55:12', '2023-02-14 08:55:12'),
(106, 103, 7200, 48, '2023-02-14', 3, NULL, 1, 1, '2023-02-14 10:02:15', '2023-02-27 07:10:48'),
(107, 102, 200000, 0, '2023-02-21', 3, NULL, 1, 1, '2023-02-21 01:53:23', '2023-02-22 07:49:59');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `discount`
--

CREATE TABLE `discount` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(1024) NOT NULL,
  `discount_percent` float DEFAULT NULL,
  `discount_number` int(11) DEFAULT NULL,
  `campain_id` int(10) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `discount`
--

INSERT INTO `discount` (`id`, `name`, `discount_percent`, `discount_number`, `campain_id`, `created_at`, `updated_at`) VALUES
(1, 'Bạch Mai', 20, 0, 1, '2022-08-26 01:24:37', '2022-08-26 01:24:37'),
(2, 'Shopee', 8.5, 0, 1, '2022-08-26 01:28:00', '2022-08-26 01:28:47'),
(3, 'Trực tiếp', 0, 0, 1, '2022-08-27 06:31:21', '2022-08-27 06:31:21'),
(4, 'cháo orgalife', 20, NULL, 1, '2022-09-04 20:00:00', '2022-09-04 20:00:00');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `exports`
--

CREATE TABLE `exports` (
  `id` int(10) UNSIGNED NOT NULL,
  `pro_id` int(11) NOT NULL,
  `price_import` int(11) NOT NULL,
  `price_export` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  `income` int(11) DEFAULT NULL,
  `discount` int(11) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `warehouse_id` int(11) NOT NULL,
  `report_date` date DEFAULT NULL,
  `note` longtext DEFAULT NULL,
  `type_discount` int(11) DEFAULT NULL,
  `discount_number` int(11) DEFAULT NULL,
  `ship` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `campain_id` int(10) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `exports`
--

INSERT INTO `exports` (`id`, `pro_id`, `price_import`, `price_export`, `total`, `income`, `discount`, `brand_id`, `warehouse_id`, `report_date`, `note`, `type_discount`, `discount_number`, `ship`, `created_by`, `campain_id`, `created_at`, `updated_at`) VALUES
(2, 41, 160000, 250000, 1, 40000, 50000, NULL, 1, '2022-08-15', '1. Hảo, dinh dưỡng Hải dương', 1, 0, 0, 3, 1, '2022-09-02 03:11:05', '2022-09-02 03:11:05'),
(3, 17, 220000, 320000, 1, 36000, 64000, NULL, 1, '2022-08-16', '2. vương, 0968555006', 1, 0, 0, 3, 1, '2022-09-02 03:11:05', '2022-09-02 03:11:05'),
(4, 22, 220000, 320000, 1, 36000, 64000, NULL, 1, '2022-08-18', '3', 1, 0, 0, 3, 1, '2022-09-02 03:11:05', '2022-09-02 03:11:05'),
(5, 20, 560000, 800000, 1, 80000, 160000, NULL, 1, '2022-08-22', '4. nv khoa gan mât, 0386665366', 1, 0, 0, 3, 1, '2022-09-02 03:11:05', '2022-09-02 03:11:05'),
(6, 30, 320000, 450000, 1, 40000, 90000, NULL, 1, '2022-08-23', '6. 0366154269', 1, 0, 0, 3, 1, '2022-09-02 03:12:43', '2022-09-02 03:12:43'),
(7, 14, 220000, 320000, 5, 36000, 64000, NULL, 1, '2022-08-23', '7. vương, khoa thần kinh, 096555006', 1, 0, 0, 3, 1, '2022-09-02 03:12:43', '2022-09-02 03:12:43'),
(8, 30, 320000, 450000, 1, 40000, 90000, NULL, 1, '2022-08-22', '5. 0346935089', 1, 0, 0, 3, 1, '2022-09-02 03:16:50', '2022-09-02 03:16:50'),
(9, 30, 320000, 450000, 1, 40000, 90000, NULL, 1, '2022-08-24', '8. tuyết, 0354558444', 1, 0, 0, 3, 1, '2022-09-02 03:16:50', '2022-09-02 03:16:50'),
(10, 30, 320000, 450000, 1, 40000, 90000, NULL, 1, '2022-08-26', '9. gan mật, 0366154269', 1, 0, 0, 3, 1, '2022-09-02 03:16:50', '2022-09-02 03:16:50'),
(11, 23, 440000, 640000, 1, 72000, 128000, NULL, 1, '2022-08-30', '10. lam sơn, thọ sơn, thanh hoá, 0986 405 993', 1, 0, 0, 3, 1, '2022-09-02 03:16:50', '2022-09-02 03:16:50'),
(12, 61, 38000, 47500, 30, 0, 9500, NULL, 7, '2022-06-01', '1. nepro 2: 30 hộp, BÙI MẠNH TƯỜNG số 129, khu 1, thị trấn Chi Nê, huyện Lạc Thủy, tỉnh Hòa Bình. Bệnh nhân thanh toán', 4, 0, 0, 3, 1, '2022-09-04 20:36:24', '2022-09-04 20:36:24'),
(13, 61, 38000, 47500, 30, 0, 9500, NULL, 7, '2022-06-03', '2. nepro 2: 30 hộp, căng tin bệnh viện', 4, 0, 0, 3, 1, '2022-09-04 20:36:24', '2022-09-04 20:36:24'),
(14, 60, 30000, 37500, 30, 0, 7500, NULL, 7, '2022-06-10', '3. căng tin', 4, 0, 0, 3, 1, '2022-09-04 20:36:24', '2022-09-04 20:36:24'),
(15, 61, 38000, 47500, 30, 0, 9500, NULL, 7, '2022-06-10', '3. căng tin', 4, 0, 0, 3, 1, '2022-09-04 20:36:24', '2022-09-04 20:36:24'),
(16, 58, 29200, 36500, 30, 0, 7300, NULL, 7, '2022-06-10', '3. căng tin', 4, 0, 0, 3, 1, '2022-09-04 20:36:24', '2022-09-04 20:36:24'),
(17, 60, 30000, 37500, 30, 0, 7500, NULL, 7, '2022-06-13', '4. căng tin', 4, 0, 0, 3, 1, '2022-09-04 20:36:24', '2022-09-04 20:36:24'),
(18, 57, 28000, 35000, 60, 0, 7000, NULL, 7, '2022-06-13', '4. căng tin', 4, 0, 0, 3, 1, '2022-09-04 20:36:24', '2022-09-04 20:36:24'),
(19, 56, 21600, 27000, 30, 0, 5400, NULL, 7, '2022-06-13', '4. căng tin', 4, 0, 0, 3, 1, '2022-09-04 20:36:24', '2022-09-04 20:36:24'),
(20, 60, 30000, 37500, 30, 0, 7500, NULL, 7, '2022-06-13', '5, Ngô hồng thái, nepro 1: 30 hộp, đưa đến bv nhiệt đới cơ sở giải phóng, xuất hóa đơn, bệnh nhân thanh toán', 4, 0, 0, 3, 1, '2022-09-04 20:36:24', '2022-09-04 20:36:24'),
(21, 60, 30000, 37500, 30, 0, 7500, NULL, 7, '2022-06-15', '6. Ngô hồng thái, nepro 1: 30 hộp, đưa đến bv nhiệt đới cơ sở giải phóng, xuất hóa đơn, bệnh nhân thanh toán. Chiều giao nhé vì chiều bn ra viện', 4, 0, 0, 3, 1, '2022-09-04 20:36:24', '2022-09-04 20:36:24'),
(22, 60, 30000, 37500, 30, 0, 7500, NULL, 7, '2022-06-17', '7. Vũ đình bất, nepro 1: 30 hộp, đưa đến bv nhiệt đới cs giải phóng, xuất hóa đơn, bệnh nhân thanh toán.', 4, 0, 0, 3, 1, '2022-09-04 20:36:24', '2022-09-04 20:36:24'),
(23, 58, 29200, 36500, 30, 0, 7300, NULL, 7, '2022-06-22', '8. fomeal care: 30 hộp, cerna: 30 hộp, nếu có vị gạo bán/tặng bệnh nhân 3 hộp được k, để bệnh nhân thử vị, thay vị vì phải dùng cháo gần như suốt đời. BÙI MẠNH TƯỜNG số 129, khu 1, thị trấn Chi Nê, huyện Lạc Thủy, tỉnh Hòa Bình. Bệnh nhân thanh toán', 4, 0, 0, 3, 1, '2022-09-04 20:36:24', '2022-09-04 20:36:24'),
(24, 59, 35600, 44500, 30, 0, 8900, NULL, 7, '2022-06-22', '8. fomeal care: 30 hộp, cerna: 30 hộp, nếu có vị gạo bán/tặng bệnh nhân 3 hộp được k, để bệnh nhân thử vị, thay vị vì phải dùng cháo gần như suốt đời. BÙI MẠNH TƯỜNG số 129, khu 1, thị trấn Chi Nê, huyện Lạc Thủy, tỉnh Hòa Bình. Bệnh nhân thanh toán', 4, 0, 0, 3, 1, '2022-09-04 20:36:24', '2022-09-04 20:36:24'),
(25, 56, 21600, 27000, 30, 0, 5400, NULL, 7, '2022-06-23', '9. deli soup: 30 hộp, giao căng tin, thanh toán gối mã', 4, 0, 0, 3, 1, '2022-09-04 20:36:24', '2022-09-04 20:36:24'),
(26, 61, 38000, 47500, 30, 0, 9500, NULL, 7, '2022-06-24', '10. Trinh cao biền, nepro 2: 30 hộp, bệnh nhân thanh toán, bệnh viện y học cổ truyền trung ương, 0913323133', 4, 0, 0, 3, 1, '2022-09-04 20:36:24', '2022-09-04 20:36:24'),
(27, 57, 28000, 35000, 30, 0, 7000, NULL, 7, '2022-06-29', '11. Basic soup: 30 hộp, bv bệnh nhiệt đới trung ương, phạm văn thắng, bệnh nhân thanh toán', 4, 0, 0, 3, 1, '2022-09-04 20:36:24', '2022-09-04 20:36:24'),
(28, 56, 21600, 27000, 30, 0, 5400, NULL, 7, '2022-07-01', '1. deli: 30 hộp, giao căng tin, thanh toán gối mã', 4, 0, 0, 3, 1, '2022-09-04 20:47:56', '2022-09-04 20:47:56'),
(29, 56, 21600, 27000, 15, 0, 5400, NULL, 7, '2022-07-07', '2. deli 15 hộp, Dương Minh Toàn, xóm hạ, xã phúc thuận, thị xã phổ yên, thái nguyên', 4, 0, 0, 3, 1, '2022-09-04 20:47:56', '2022-09-04 20:47:56'),
(30, 56, 21600, 27000, 15, 0, 5400, NULL, 7, '2022-07-16', '3. deli 15 hộp, Dương Minh Toàn, xóm hạ, xã phúc thuận, thị xã phổ yên, thái nguyên', 4, 0, 0, 3, 1, '2022-09-04 20:47:56', '2022-09-04 20:47:56'),
(31, 56, 21600, 27000, 15, 0, 5400, NULL, 7, '2022-07-18', '4. BV', 4, 0, 0, 3, 1, '2022-09-04 20:47:56', '2022-09-04 20:47:56'),
(32, 59, 35600, 44500, 30, 0, 8900, NULL, 7, '2022-07-21', '5. cerna: 30 hộp, thanh toán gối mã 2 thùng cerna trước đó', 4, 0, 0, 3, 1, '2022-09-04 20:47:56', '2022-09-04 20:47:56'),
(33, 57, 28000, 35000, 6, 0, 7000, NULL, 7, '2022-07-23', '6. Basic : 6 hộp, nepro 2: 6 hộp, Dương minh toàn, xóm hạ, xã phúc thuận, thị xã phổ yên, thái nguyên. Bệnh nhân thanh toán', 4, 0, 0, 3, 1, '2022-09-04 20:47:56', '2022-09-04 20:47:56'),
(34, 61, 38000, 47500, 6, 0, 9500, NULL, 7, '2022-07-23', '6. Basic : 6 hộp, nepro 2: 6 hộp, Dương minh toàn, xóm hạ, xã phúc thuận, thị xã phổ yên, thái nguyên. Bệnh nhân thanh toán', 4, 0, 0, 3, 1, '2022-09-04 20:47:56', '2022-09-04 20:47:56'),
(35, 59, 35600, 44500, 6, 0, 8900, NULL, 7, '2022-07-25', '7. cerna: 6 hộp, nepro 1: 6 hộp, Số nhà 06 ngõ 230 khu quảng trường 1 phường ninh khánh, Tp Ninh Bình, 091 3108969.', 4, 0, 0, 3, 1, '2022-09-04 20:47:56', '2022-09-04 20:47:56'),
(36, 60, 30000, 37500, 6, 0, 7500, NULL, 7, '2022-07-25', '7. cerna: 6 hộp, nepro 1: 6 hộp, Số nhà 06 ngõ 230 khu quảng trường 1 phường ninh khánh, Tp Ninh Bình, 091 3108969.', 4, 0, 0, 3, 1, '2022-09-04 20:47:56', '2022-09-04 20:48:53'),
(37, 57, 28000, 35000, 30, 0, 7000, NULL, 7, '2022-07-25', '8. basic: 30 hộp (1 thùng), lấy tên e, giao qua viện,', 4, 0, 0, 3, 1, '2022-09-04 20:47:56', '2022-09-04 20:47:56'),
(38, 56, 21600, 27000, 30, 0, 5400, NULL, 7, '2022-07-25', '9. deli: 30 hộp, nguyễn thị liên hà, giao tại viện, bệnh nhân thanh toán', 4, 0, 0, 3, 1, '2022-09-04 20:47:56', '2022-09-04 20:47:56'),
(39, 59, 35600, 44500, 30, 0, 8900, NULL, 7, '2022-07-29', '10. cerna: 30 hộp, nepro 2; 30 hộp, BÙI MẠNH TƯỜNG số 129, khu 1, thị trấn Chi Nê, huyện Lạc Thủy, tỉnh Hòa Bình. Bệnh nhân thanh toán', 4, 0, 0, 3, 1, '2022-09-04 20:47:56', '2022-09-04 20:47:56'),
(40, 61, 38000, 47500, 30, 0, 9500, NULL, 7, '2022-07-29', '10. cerna: 30 hộp, nepro 2; 30 hộp, BÙI MẠNH TƯỜNG số 129, khu 1, thị trấn Chi Nê, huyện Lạc Thủy, tỉnh Hòa Bình. Bệnh nhân thanh toán', 4, 0, 0, 3, 1, '2022-09-04 20:47:56', '2022-09-04 20:47:56'),
(41, 21, 263000, 350000, 1, 87000, 0, NULL, 3, '2022-09-05', '', 3, 0, 0, 3, 1, '2022-09-06 08:19:51', '2022-09-06 08:19:51'),
(42, 55, 61000, 68000, 1, 7000, 0, NULL, 3, '2022-09-05', '', 3, 0, 0, 3, 1, '2022-09-06 08:19:51', '2022-09-06 08:19:51'),
(43, 59, 44500, 43000, 12, 0, 0, NULL, 3, '2022-09-05', '', 3, 0, 0, 3, 1, '2022-09-06 08:19:51', '2022-09-06 08:19:51'),
(44, 58, 36500, 38000, 3, 1500, 0, NULL, 3, '2022-09-05', '', 3, 0, 0, 3, 1, '2022-09-06 08:19:51', '2022-09-06 08:19:51'),
(45, 9, 263000, 330000, 1, 67000, 0, NULL, 3, '2022-09-05', '', 3, 0, 0, 3, 1, '2022-09-06 08:19:51', '2022-09-06 08:19:51'),
(46, 41, 160000, 250000, 1, 40000, 50000, NULL, 1, '2022-09-07', '1. Hảo, bạch mai', 1, 0, 0, 3, 1, '2022-09-30 05:20:47', '2022-09-30 05:20:47'),
(47, 18, 440000, 640000, 5, 72000, 128000, NULL, 1, '2022-09-18', '2. Nguyễn Thị Sen, quốc oai, hà nội', 1, 0, 0, 3, 1, '2022-09-30 05:20:47', '2022-09-30 05:20:47'),
(48, 30, 320000, 450000, 1, 40000, 90000, NULL, 1, '2022-10-18', '1. peptizer, bach mai 0984021029', 1, 0, 0, 3, 1, '2022-11-01 09:44:52', '2022-11-01 09:44:52'),
(49, 30, 320000, 450000, 2, 130000, 0, NULL, 1, '2022-10-21', '2. peptizer, bach mai 0984021029', 3, 0, 0, 3, 1, '2022-11-01 09:44:52', '2022-11-01 09:44:52'),
(50, 30, 320000, 450000, 2, 40000, 90000, NULL, 1, '2022-10-21', '2.peptizer,  bach mai 0984021029', 1, 0, 0, 3, 1, '2022-11-01 09:45:54', '2022-11-01 09:45:54'),
(51, 30, 320000, 450000, 1, 40000, 90000, NULL, 1, '2022-11-05', '1. khoa tiêu hoá', 1, 0, 0, 3, 1, '2022-12-03 05:48:41', '2022-12-03 05:48:41'),
(52, 30, 320000, 450000, 1, 40000, 90000, NULL, 1, '2022-11-07', '2. khoa thần kinh', 1, 0, 0, 3, 1, '2022-12-03 05:48:41', '2022-12-03 05:48:41'),
(53, 30, 320000, 450000, 1, 40000, 90000, NULL, 1, '2022-11-10', '3. khoa thần kinh', 1, 0, 0, 3, 1, '2022-12-03 05:48:41', '2022-12-03 05:48:41');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `imports`
--

CREATE TABLE `imports` (
  `id` int(10) UNSIGNED NOT NULL,
  `pro_id` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `report_date` date DEFAULT NULL,
  `note` text DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `warehouse_id` int(11) DEFAULT 1,
  `campain_id` int(10) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `imports`
--

INSERT INTO `imports` (`id`, `pro_id`, `total`, `price`, `created_by`, `report_date`, `note`, `brand_id`, `warehouse_id`, `campain_id`, `created_at`, `updated_at`) VALUES
(14, 42, 2, 220000, 2, '2022-06-29', '', 1, 1, 1, '2022-08-22 09:12:58', '2022-08-22 09:12:58'),
(15, 4, 3, 340000, 2, '2022-06-29', '', 1, 1, 1, '2022-08-22 09:12:58', '2022-08-22 09:12:58'),
(16, 6, 4, 340000, 2, '2022-06-29', '', 1, 1, 1, '2022-08-22 09:12:58', '2022-08-22 09:12:58'),
(17, 8, 6, 340000, 2, '2022-06-29', '', 1, 1, 1, '2022-08-22 09:12:58', '2022-08-22 09:12:58'),
(18, 9, 6, 210000, 2, '2022-06-29', '', 1, 1, 1, '2022-08-22 09:12:58', '2022-08-22 09:12:58'),
(19, 10, 8, 420000, 2, '2022-06-29', '', 1, 1, 1, '2022-08-22 09:12:58', '2022-08-22 09:12:58'),
(20, 11, 1, 215000, 2, '2022-06-29', '', 1, 1, 1, '2022-08-22 09:12:58', '2022-08-22 09:12:58'),
(21, 13, 3, 230000, 2, '2022-06-29', '', 1, 1, 1, '2022-08-22 09:12:58', '2022-08-22 09:12:58'),
(22, 15, 1, 440000, 2, '2022-06-29', '', 1, 1, 1, '2022-08-22 09:12:58', '2022-08-22 09:12:58'),
(23, 16, 3, 230000, 2, '2022-06-29', '', 1, 1, 1, '2022-08-22 09:12:58', '2022-08-22 09:12:58'),
(24, 17, 7, 220000, 2, '2022-06-29', '', 1, 1, 1, '2022-08-22 09:12:59', '2022-08-22 09:12:59'),
(25, 18, 6, 440000, 2, '2022-06-29', '', 1, 1, 1, '2022-08-22 09:12:59', '2022-08-22 09:12:59'),
(26, 21, 5, 230000, 2, '2022-06-29', '', 1, 1, 1, '2022-08-22 09:12:59', '2022-08-22 09:12:59'),
(27, 23, 2, 440000, 2, '2022-06-29', '', 1, 1, 1, '2022-08-22 09:12:59', '2022-08-22 09:12:59'),
(28, 24, 2, 210000, 2, '2022-06-29', '', 1, 1, 1, '2022-08-22 09:12:59', '2022-08-22 09:12:59'),
(29, 26, 3, 210000, 2, '2022-06-29', '', 1, 1, 1, '2022-08-22 09:12:59', '2022-08-22 09:12:59'),
(30, 27, 3, 420000, 2, '2022-06-29', '', 1, 1, 1, '2022-08-22 09:12:59', '2022-08-22 09:12:59'),
(31, 29, 2, 210000, 2, '2022-06-29', '', 1, 1, 1, '2022-08-22 09:12:59', '2022-08-22 09:12:59'),
(32, 30, 6, 320000, 2, '2022-06-29', '', 1, 1, 1, '2022-08-22 09:12:59', '2022-08-22 09:12:59'),
(33, 31, 4, 260000, 2, '2022-06-29', '', 1, 1, 1, '2022-08-22 09:12:59', '2022-08-22 09:12:59'),
(34, 32, 3, 520000, 2, '2022-06-29', '', 1, 1, 1, '2022-08-22 09:12:59', '2022-08-22 09:12:59'),
(35, 35, 1, 500000, 2, '2022-06-29', '', 1, 1, 1, '2022-08-22 09:12:59', '2022-08-22 09:12:59'),
(36, 38, 2, 560000, 2, '2022-06-29', '', 1, 1, 1, '2022-08-22 09:12:59', '2022-08-22 09:12:59'),
(37, 41, 5, 160000, 2, '2022-06-29', '', 1, 1, 1, '2022-08-22 09:12:59', '2022-08-22 09:12:59'),
(38, 39, 3, 210000, 2, '2022-06-29', '', 1, 1, 1, '2022-08-22 09:12:59', '2022-08-22 09:12:59'),
(39, 40, 6, 420000, 2, '2022-06-29', '', 1, 1, 1, '2022-08-22 09:12:59', '2022-08-22 09:12:59'),
(40, 44, 6, 440000, 2, '2022-06-29', '', 1, 1, 1, '2022-08-22 09:12:59', '2022-08-22 09:12:59'),
(41, 23, 6, 440000, 2, '2022-06-30', '', 1, 1, 1, '2022-08-22 09:13:46', '2022-08-22 09:13:46'),
(42, 35, 3, 500000, 2, '2022-06-30', '', 1, 1, 1, '2022-08-22 09:13:46', '2022-08-22 09:13:46'),
(43, 18, 3, 440000, 2, '2022-06-30', '', 1, 1, 1, '2022-08-22 09:13:46', '2022-08-22 09:13:46'),
(44, 8, 6, 340000, 2, '2022-07-07', '', 1, 1, 1, '2022-08-22 09:15:31', '2022-08-22 09:15:31'),
(45, 40, 6, 420000, 2, '2022-07-07', '', 1, 1, 1, '2022-08-22 09:15:31', '2022-08-22 09:15:31'),
(46, 35, 3, 500000, 2, '2022-07-07', '', 1, 1, 1, '2022-08-22 09:15:31', '2022-08-22 09:15:31'),
(47, 8, 6, 340000, 2, '2022-07-19', '', 1, 1, 1, '2022-08-22 09:29:27', '2022-08-22 09:29:27'),
(48, 35, 5, 500000, 2, '2022-07-19', '', 1, 1, 1, '2022-08-22 09:29:27', '2022-08-22 09:29:27'),
(49, 40, 3, 420000, 2, '2022-07-19', '', 1, 1, 1, '2022-08-22 09:29:27', '2022-08-22 09:29:27'),
(50, 44, 3, 440000, 2, '2022-07-19', '', 1, 1, 1, '2022-08-22 09:29:27', '2022-08-22 09:29:27'),
(51, 38, 3, 560000, 2, '2022-07-19', '', 1, 1, 1, '2022-08-22 09:29:27', '2022-08-22 09:29:27'),
(52, 18, 6, 440000, 2, '2022-07-25', '', 1, 1, 1, '2022-08-22 09:32:30', '2022-08-22 09:32:30'),
(53, 23, 6, 440000, 2, '2022-07-25', '', 1, 1, 1, '2022-08-22 09:32:30', '2022-08-22 09:32:30'),
(54, 40, 6, 420000, 2, '2022-07-25', '', 1, 1, 1, '2022-08-22 09:32:30', '2022-08-22 09:32:30'),
(55, 8, 3, 340000, 2, '2022-07-25', '', 1, 1, 1, '2022-08-22 09:32:30', '2022-08-22 09:32:30'),
(56, 35, 3, 500000, 2, '2022-07-25', '', 1, 1, 1, '2022-08-22 09:32:30', '2022-08-22 09:32:30'),
(57, 34, 2, 250000, 2, '2022-07-25', '', 1, 1, 1, '2022-08-22 09:32:30', '2022-08-22 09:32:30'),
(58, 15, 3, 440000, 2, '2022-07-29', '', 1, 1, 1, '2022-08-22 09:35:16', '2022-08-22 09:35:16'),
(59, 18, 6, 440000, 2, '2022-07-29', '', 1, 1, 1, '2022-08-22 09:35:16', '2022-08-22 09:35:16'),
(60, 35, 3, 500000, 2, '2022-07-29', '', 1, 1, 1, '2022-08-22 09:35:16', '2022-08-22 09:35:16'),
(61, 44, 6, 440000, 2, '2022-08-03', '', 1, 1, 1, '2022-08-22 09:39:41', '2022-08-22 09:39:41'),
(62, 18, 6, 440000, 2, '2022-08-03', '', 1, 1, 1, '2022-08-22 09:39:41', '2022-08-22 09:39:41'),
(63, 8, 5, 340000, 2, '2022-08-03', '', 1, 1, 1, '2022-08-22 09:39:41', '2022-08-22 09:39:41'),
(64, 21, 5, 230000, 2, '2022-08-03', '', 1, 1, 1, '2022-08-22 09:39:41', '2022-08-22 09:39:41'),
(65, 8, 12, 340000, 2, '2022-08-05', '', 1, 1, 1, '2022-08-22 09:42:10', '2022-08-22 09:42:10'),
(66, 32, 4, 520000, 2, '2022-08-08', '', 1, 1, 1, '2022-08-22 09:42:36', '2022-08-22 09:42:36'),
(67, 44, 5, 440000, 2, '2022-08-12', '', 1, 1, 1, '2022-08-22 09:43:54', '2022-08-22 09:43:54'),
(68, 35, 3, 500000, 2, '2022-08-12', '', 1, 1, 1, '2022-08-22 09:43:54', '2022-08-22 09:43:54'),
(69, 45, 30, 23000, 2, '2022-08-12', '', 1, 1, 1, '2022-08-22 09:50:49', '2022-08-22 09:50:49'),
(70, 40, 3, 420000, 2, '2022-08-12', 'báo giao Le 9 nhưng giao nhầm thành MTMA9', 1, 1, 1, '2022-08-22 09:50:49', '2022-08-22 09:50:49'),
(71, 8, 6, 340000, 3, '2022-08-15', '', 1, 1, 1, '2022-08-23 02:26:32', '2022-08-23 02:26:32'),
(72, 30, 3, 320000, 3, '2022-08-15', '', 1, 1, 1, '2022-08-23 02:26:32', '2022-08-23 02:26:32'),
(73, 15, 3, 440000, 3, '2022-08-15', '', 1, 1, 1, '2022-08-23 02:26:32', '2022-08-23 02:26:32'),
(74, 18, 9, 440000, 3, '2022-08-17', '', 1, 1, 1, '2022-08-23 02:39:01', '2022-08-23 02:39:01'),
(75, 23, 5, 440000, 3, '2022-08-17', '', 1, 1, 1, '2022-08-23 02:39:01', '2022-08-23 02:39:01'),
(76, 35, 5, 500000, 3, '2022-08-17', '', 1, 1, 1, '2022-08-23 02:39:01', '2022-08-23 02:39:01'),
(77, 34, 4, 250000, 3, '2022-08-17', '', 1, 1, 1, '2022-08-23 02:39:01', '2022-08-23 02:39:01'),
(78, 43, 3, 220000, 3, '2022-08-17', '', 1, 1, 1, '2022-08-23 02:39:01', '2022-08-23 02:39:01'),
(79, 22, 3, 220000, 3, '2022-08-17', '', 1, 1, 1, '2022-08-23 02:39:01', '2022-08-23 02:39:01'),
(80, 39, 3, 210000, 3, '2022-06-06', '2 chị em đã thống nhất là kho có giao 3 lon MTMA4', 1, 1, 1, '2022-08-23 02:41:48', '2022-08-23 02:41:48'),
(81, 30, 3, 320000, 3, '2022-08-19', '', 1, 1, 1, '2022-08-23 02:43:30', '2022-08-23 02:43:30'),
(82, 4, 3, 250000, 3, '2022-08-19', '3 lon cận date, áp giá 250k', 1, 1, 1, '2022-08-23 02:43:30', '2022-08-23 02:43:30'),
(83, 18, 9, 440000, 3, '2022-08-23', '', 1, 1, 1, '2022-08-23 02:46:08', '2022-08-23 02:46:08'),
(84, 30, 5, 320000, 3, '2022-08-23', '', 1, 1, 1, '2022-08-23 02:46:08', '2022-08-23 02:46:08'),
(85, 20, 3, 540000, 3, '2022-08-23', '', 1, 1, 1, '2022-08-23 02:46:08', '2022-08-23 02:46:08'),
(86, 40, 5, 420000, 3, '2022-08-23', '', 1, 1, 1, '2022-08-23 02:46:08', '2022-08-23 02:46:08'),
(87, 8, 5, 340000, 3, '2022-08-24', '', 1, 1, 1, '2022-08-23 19:47:25', '2022-08-23 19:47:25'),
(88, 14, 5, 220000, 3, '2022-08-24', '', 1, 1, 1, '2022-08-23 19:47:25', '2022-08-23 19:47:25'),
(90, 30, 12, 320000, 3, '2022-08-29', '', NULL, 1, 1, '2022-09-02 00:59:49', '2022-09-02 00:59:49'),
(91, 23, 6, 440000, 3, '2022-08-29', '', NULL, 1, 1, '2022-09-02 00:59:49', '2022-09-02 00:59:49'),
(92, 8, 5, 340000, 3, '2022-08-29', '', NULL, 1, 1, '2022-09-02 00:59:49', '2022-09-02 00:59:49'),
(93, 22, 5, 220000, 3, '2022-08-29', '', NULL, 1, 1, '2022-09-02 00:59:49', '2022-09-02 00:59:49'),
(94, 40, 5, 420000, 3, '2022-08-29', '', NULL, 1, 1, '2022-09-02 00:59:49', '2022-09-02 00:59:49'),
(95, 39, 5, 210000, 3, '2022-08-29', '', NULL, 1, 1, '2022-09-02 00:59:49', '2022-09-02 00:59:49'),
(96, 15, 3, 440000, 3, '2022-08-29', '', NULL, 1, 1, '2022-09-02 00:59:49', '2022-09-02 00:59:49'),
(97, 14, 3, 220000, 3, '2022-08-29', '', NULL, 1, 1, '2022-09-02 00:59:49', '2022-09-02 00:59:49'),
(98, 35, 5, 500000, 3, '2022-08-29', '', NULL, 1, 1, '2022-09-02 00:59:49', '2022-09-02 00:59:49'),
(99, 38, 3, 560000, 3, '2022-08-29', '', NULL, 1, 1, '2022-09-02 00:59:49', '2022-09-02 00:59:49'),
(100, 29, 2, 210000, 3, '2022-08-29', '', NULL, 1, 1, '2022-09-02 00:59:49', '2022-09-02 00:59:49'),
(101, 21, 3, 263000, 3, '2022-08-29', 'giá bán 370k', NULL, 3, 1, '2022-09-02 02:24:11', '2022-09-02 02:24:11'),
(102, 54, 1, 685000, 3, '2022-08-29', 'giá bán 780k', NULL, 3, 1, '2022-09-02 02:24:11', '2022-09-02 02:24:11'),
(103, 17, 2, 240000, 3, '2022-08-29', 'giá bán 340k', NULL, 3, 1, '2022-09-02 02:24:11', '2022-09-02 02:24:11'),
(104, 31, 1, 297000, 3, '2022-08-29', 'giá bán 410k', NULL, 3, 1, '2022-09-02 02:24:11', '2022-09-02 02:24:11'),
(105, 48, 2, 210000, 3, '2022-08-29', 'giá bán 285k', NULL, 3, 1, '2022-09-02 02:24:11', '2022-09-23 22:41:32'),
(106, 46, 6, 405000, 3, '2022-08-29', 'giá bán 470k', NULL, 3, 1, '2022-09-02 02:24:11', '2022-09-02 02:24:11'),
(107, 51, 5, 180000, 3, '2022-08-29', 'giá bán 250k', NULL, 3, 1, '2022-09-02 02:24:11', '2022-09-02 02:24:11'),
(108, 29, 1, 225000, 3, '2022-08-29', 'giá bán 320k', NULL, 3, 1, '2022-09-02 02:24:11', '2022-09-02 02:24:11'),
(109, 55, 28, 61000, 3, '2022-08-29', 'giá bán 70k', NULL, 3, 1, '2022-09-02 02:24:11', '2022-09-02 02:24:11'),
(110, 59, 16, 44500, 3, '2022-08-29', 'giá bán 45k', NULL, 3, 1, '2022-09-02 02:24:11', '2022-09-02 02:24:11'),
(111, 56, 14, 27000, 3, '2022-08-29', 'date 29/7/23', NULL, 3, 1, '2022-09-02 02:24:11', '2022-09-23 22:38:07'),
(112, 57, 27, 35000, 3, '2022-08-29', 'date 5/1/23', NULL, 3, 1, '2022-09-02 02:24:11', '2022-09-14 01:09:04'),
(113, 60, 2, 37500, 3, '2022-08-29', 'date 16/11/22', NULL, 3, 1, '2022-09-02 02:24:11', '2022-09-14 01:09:53'),
(114, 61, 10, 47500, 3, '2022-08-29', 'date 25/12/22', NULL, 3, 1, '2022-09-02 02:24:11', '2022-09-14 01:10:54'),
(115, 58, 27, 36500, 3, '2022-08-29', 'date 13/12/22', NULL, 3, 1, '2022-09-02 02:24:11', '2022-09-14 01:08:14'),
(116, 9, 2, 263000, 3, '2022-08-29', 'giá bán 370k', NULL, 3, 1, '2022-09-02 02:26:03', '2022-09-02 02:26:03'),
(117, 39, 2, 248000, 3, '2022-08-29', 'giá bán 350k', NULL, 3, 1, '2022-09-02 02:26:03', '2022-09-02 02:26:03'),
(118, 21, 1, 256000, 3, '2021-11-20', 'giá 320k', NULL, 2, 1, '2022-09-02 02:28:41', '2022-09-02 02:28:41'),
(119, 42, 1, 256000, 3, '2021-11-20', 'giá 320k', NULL, 2, 1, '2022-09-02 02:28:41', '2022-09-02 02:28:41'),
(120, 16, 1, 256000, 3, '2021-11-20', 'giá 320k', NULL, 2, 1, '2022-09-02 02:29:56', '2022-09-02 02:29:56'),
(121, 5, 6, 200000, 3, '2022-07-27', 'giá 260k', NULL, 2, 1, '2022-09-02 02:36:16', '2022-09-02 02:36:16'),
(122, 7, 5, 200000, 3, '2022-08-14', 'giá 260k', NULL, 2, 1, '2022-09-02 02:36:16', '2022-09-02 02:36:16'),
(123, 8, 4, 416000, 3, '2022-08-14', 'giá 520k', NULL, 2, 1, '2022-09-02 02:36:16', '2022-09-02 02:36:16'),
(124, 6, 7, 416000, 3, '2022-08-14', 'giá 520k', NULL, 2, 1, '2022-09-02 02:36:16', '2022-09-02 02:36:16'),
(125, 24, 3, 240000, 3, '2022-07-14', 'giá 300k', NULL, 2, 1, '2022-09-02 02:40:12', '2022-09-02 02:40:12'),
(126, 63, 4, 130000, 3, '2022-07-14', 'giá 150k', NULL, 2, 1, '2022-09-02 02:40:12', '2022-09-02 02:40:12'),
(127, 64, 8, 15000, 3, '2022-07-14', 'giá 25k', NULL, 2, 1, '2022-09-02 02:40:12', '2022-09-02 02:40:12'),
(128, 63, 4, 130000, 3, '2022-07-27', 'giá 150k', NULL, 2, 1, '2022-09-02 02:40:51', '2022-09-02 02:40:51'),
(129, 66, 5, 365600, 3, '2022-09-05', '', NULL, 4, 1, '2022-09-04 19:48:23', '2022-09-04 19:48:23'),
(130, 7, 5, 200000, 3, '2022-09-05', '', NULL, 4, 1, '2022-09-04 19:48:23', '2022-09-04 19:48:23'),
(131, 8, 5, 400000, 3, '2022-09-05', '', NULL, 4, 1, '2022-09-04 19:48:23', '2022-09-04 19:48:23'),
(132, 47, 10, 193350, 3, '2022-09-05', 'công nợ nhiệt đới', NULL, 5, 1, '2022-09-04 19:53:20', '2022-09-04 19:53:20'),
(133, 48, 5, 207225, 3, '2022-09-05', 'công nợ nhiệt đới', NULL, 5, 1, '2022-09-04 19:53:20', '2022-09-04 19:53:20'),
(134, 51, 8, 181800, 3, '2022-09-05', 'công nợ nhiệt đới', NULL, 5, 1, '2022-09-04 19:53:20', '2022-09-04 19:53:20'),
(135, 66, 5, 342750, 3, '2022-09-05', 'công nợ thanh hoá', NULL, 5, 1, '2022-09-04 19:53:20', '2022-09-04 19:53:20'),
(136, 59, 15, 35600, 3, '2022-08-15', 'căng tin', NULL, 7, 1, '2022-09-04 20:02:36', '2022-09-04 20:02:36'),
(137, 56, 30, 21600, 3, '2022-08-18', 'căng tin', NULL, 7, 1, '2022-09-04 20:02:36', '2022-09-04 20:02:36'),
(138, 57, 15, 28000, 3, '2022-08-15', 'căng tin', NULL, 7, 1, '2022-09-04 20:02:36', '2022-09-04 20:02:36'),
(139, 61, 30, 38000, 3, '2022-08-15', 'căng tin', NULL, 7, 1, '2022-09-04 20:02:36', '2022-09-04 20:02:36'),
(140, 58, 30, 29200, 3, '2022-08-15', 'căng tin', NULL, 7, 1, '2022-09-04 20:02:36', '2022-09-04 20:02:36'),
(141, 18, 5, 440000, 3, '2022-09-07', '', NULL, 1, 1, '2022-09-04 20:22:19', '2022-09-06 08:26:47'),
(142, 8, 10, 340000, 3, '2022-09-07', '', NULL, 1, 1, '2022-09-04 20:22:19', '2022-09-06 08:26:36'),
(143, 40, 5, 420000, 3, '2022-09-07', '', NULL, 1, 1, '2022-09-04 20:22:19', '2022-09-06 08:26:28'),
(144, 38, 7, 560000, 3, '2022-09-06', '', NULL, 1, 1, '2022-09-04 20:22:19', '2022-09-06 08:25:58'),
(145, 35, 5, 500000, 3, '2022-09-07', '', NULL, 1, 1, '2022-09-04 20:22:19', '2022-09-06 08:26:20'),
(146, 30, 5, 320000, 3, '2022-09-07', '', NULL, 1, 1, '2022-09-04 20:22:19', '2022-10-31 23:02:37'),
(147, 47, 8, 195000, 3, '2022-08-29', '', NULL, 3, 1, '2022-09-04 21:34:49', '2022-09-04 21:34:49'),
(148, 38, 5, 560000, 3, '2022-09-14', '', NULL, 1, 1, '2022-09-12 06:45:44', '2022-09-14 00:33:03'),
(149, 8, 5, 340000, 3, '2022-09-14', '', NULL, 1, 1, '2022-09-12 06:45:44', '2022-09-14 00:32:55'),
(150, 12, 5, 430000, 3, '2022-09-14', '', NULL, 1, 1, '2022-09-12 06:45:44', '2022-09-14 00:32:48'),
(151, 35, 5, 500000, 3, '2022-09-14', '', NULL, 1, 1, '2022-09-12 06:45:44', '2022-09-14 00:32:40'),
(152, 40, 5, 420000, 3, '2022-09-14', '', NULL, 1, 1, '2022-09-12 06:45:44', '2022-09-14 00:32:32'),
(153, 18, 5, 440000, 3, '2022-09-14', '', NULL, 1, 1, '2022-09-12 06:45:44', '2022-09-14 00:32:26'),
(154, 27, 2, 420000, 3, '2022-09-14', '', NULL, 1, 1, '2022-09-14 00:33:25', '2022-09-14 00:33:25'),
(155, 15, 3, 440000, 3, '2022-09-19', '', NULL, 1, 1, '2022-09-18 05:53:26', '2022-09-18 05:53:26'),
(156, 18, 10, 440000, 3, '2022-09-19', 'báo nhập thêm 5 lon', NULL, 1, 1, '2022-09-18 05:53:26', '2022-09-19 02:15:00'),
(157, 35, 5, 500000, 3, '2022-09-19', '', NULL, 1, 1, '2022-09-18 05:53:26', '2022-09-18 05:53:26'),
(158, 11, 3, 215000, 3, '2022-09-19', '', NULL, 1, 1, '2022-09-18 05:53:26', '2022-09-18 05:53:26'),
(159, 18, 10, 440000, 3, '2022-09-26', '', NULL, 1, 1, '2022-09-23 01:55:05', '2022-09-23 01:55:05'),
(160, 38, 5, 560000, 3, '2022-09-26', '', NULL, 1, 1, '2022-09-23 01:55:05', '2022-09-25 02:22:52'),
(161, 8, 5, 340000, 3, '2022-09-26', '', NULL, 1, 1, '2022-09-23 01:55:05', '2022-09-23 01:55:05'),
(162, 23, 5, 440000, 3, '2022-09-26', '', NULL, 1, 1, '2022-09-23 01:55:05', '2022-09-23 01:55:05'),
(163, 71, 0, 1000, 3, '2022-09-26', 'chưa có hàng', NULL, 1, 1, '2022-09-23 01:57:22', '2022-09-26 04:26:32'),
(164, 8, 5, 416000, 3, '2022-09-24', '', NULL, 2, 1, '2022-09-23 01:58:06', '2022-09-23 01:58:06'),
(165, 32, 5, 520000, 3, '2022-09-26', '', NULL, 1, 1, '2022-09-25 02:22:27', '2022-09-25 02:22:27'),
(166, 35, 3, 500000, 3, '2022-09-26', '', NULL, 1, 1, '2022-09-25 02:22:27', '2022-09-25 03:35:26'),
(168, 32, 5, 520000, 3, '2022-09-26', '', NULL, 1, 1, '2022-09-26 04:25:52', '2022-09-26 04:25:52'),
(169, 30, 3, 320000, 3, '2022-09-26', '', NULL, 1, 1, '2022-09-26 04:25:52', '2022-09-26 04:25:52'),
(170, 8, 10, 340000, 3, '2022-10-03', '', NULL, 1, 1, '2022-09-30 21:56:52', '2022-09-30 21:56:52'),
(171, 38, 3, 560000, 3, '2022-10-03', '', NULL, 1, 1, '2022-09-30 21:56:52', '2022-09-30 21:56:52'),
(172, 23, 5, 440000, 3, '2022-10-03', '', NULL, 1, 1, '2022-09-30 21:56:52', '2022-09-30 21:56:52'),
(173, 29, 5, 210000, 3, '2022-10-03', '', NULL, 1, 1, '2022-09-30 21:56:52', '2022-09-30 21:56:52'),
(174, 44, 5, 440000, 3, '2022-10-03', '', NULL, 1, 1, '2022-09-30 21:56:52', '2022-09-30 21:56:52'),
(175, 18, 3, 440000, 3, '2022-10-03', '', NULL, 1, 1, '2022-09-30 21:56:52', '2022-09-30 21:56:52'),
(176, 5, 5, 200000, 3, '2022-10-04', '', NULL, 2, 1, '2022-10-10 22:44:13', '2022-10-10 22:44:13'),
(177, 6, 5, 416000, 3, '2022-10-04', '', NULL, 2, 1, '2022-10-10 22:44:13', '2022-10-10 22:44:13'),
(178, 12, 3, 430000, 3, '2022-10-10', '', NULL, 1, 1, '2022-10-10 22:47:24', '2022-10-10 22:47:24'),
(179, 27, 3, 420000, 3, '2022-10-10', '', NULL, 1, 1, '2022-10-10 22:47:24', '2022-10-10 22:47:24'),
(180, 29, 4, 210000, 3, '2022-10-10', '', NULL, 1, 1, '2022-10-10 22:47:24', '2022-10-10 22:47:24'),
(181, 17, 3, 220000, 3, '2022-10-10', '', NULL, 1, 1, '2022-10-10 22:47:24', '2022-10-10 22:47:24'),
(182, 38, 3, 560000, 3, '2022-10-10', '', NULL, 1, 1, '2022-10-10 22:47:24', '2022-10-10 22:47:24'),
(183, 23, 5, 440000, 3, '2022-10-10', '', NULL, 1, 1, '2022-10-10 22:47:24', '2022-10-10 22:47:24'),
(184, 35, 5, 500000, 3, '2022-10-10', '', NULL, 1, 1, '2022-10-10 22:47:24', '2022-10-10 22:47:24'),
(185, 8, 5, 416000, 3, '2022-10-18', '', NULL, 2, 1, '2022-10-17 01:13:01', '2022-10-17 01:13:01'),
(186, 8, 3, 340000, 3, '2022-10-17', '', NULL, 1, 1, '2022-10-17 01:14:51', '2022-10-17 01:14:51'),
(187, 9, 3, 210000, 3, '2022-10-17', '', NULL, 1, 1, '2022-10-17 01:14:51', '2022-10-17 01:14:51'),
(188, 18, 5, 440000, 3, '2022-10-17', '', NULL, 1, 1, '2022-10-17 01:14:51', '2022-10-17 01:14:51'),
(189, 38, 5, 560000, 3, '2022-10-17', '', NULL, 1, 1, '2022-10-17 01:14:51', '2022-10-17 01:14:51'),
(190, 23, 5, 440000, 3, '2022-10-17', '', NULL, 1, 1, '2022-10-17 01:14:51', '2022-10-17 01:14:51'),
(191, 26, 3, 210000, 3, '2022-10-17', '', NULL, 1, 1, '2022-10-19 23:21:05', '2022-10-19 23:21:05'),
(192, 65, 5, 418400, 3, '2022-10-21', '', NULL, 4, 1, '2022-10-20 22:33:09', '2022-10-20 22:33:09'),
(193, 65, 5, 392250, 3, '2022-10-21', '', NULL, 5, 1, '2022-10-20 22:33:28', '2022-10-20 22:33:28'),
(194, 25, 5, 450000, 3, '2022-10-21', '', NULL, 4, 1, '2022-10-21 01:59:51', '2022-10-21 01:59:51'),
(195, 8, 6, 340000, 3, '2022-10-24', '', NULL, 1, 1, '2022-10-23 06:38:02', '2022-10-23 06:38:02'),
(196, 18, 10, 440000, 3, '2022-10-24', '', NULL, 1, 1, '2022-10-23 06:38:02', '2022-10-23 06:38:02'),
(197, 12, 5, 430000, 3, '2022-10-24', '', NULL, 1, 1, '2022-10-23 06:38:02', '2022-10-23 06:38:02'),
(198, 23, 6, 440000, 3, '2022-10-24', '', NULL, 1, 1, '2022-10-23 06:38:02', '2022-10-23 06:38:02'),
(199, 38, 3, 560000, 3, '2022-10-24', '', NULL, 1, 1, '2022-10-23 06:38:02', '2022-10-23 06:38:02'),
(200, 18, 12, 440000, 3, '2022-10-26', '', NULL, 1, 1, '2022-10-25 18:22:01', '2022-10-25 18:22:01'),
(201, 30, 3, 320000, 3, '2022-10-26', '', NULL, 1, 1, '2022-10-25 23:03:02', '2022-10-25 23:03:02'),
(202, 27, 7, 420000, 3, '2022-10-26', '', NULL, 1, 1, '2022-10-25 23:03:02', '2022-10-25 23:03:02'),
(203, 72, 5, 222000, 3, '2022-10-26', '', NULL, 4, 1, '2022-10-26 02:32:50', '2022-10-26 02:32:50'),
(204, 73, 5, 211500, 3, '2022-10-26', '', NULL, 4, 1, '2022-10-26 02:32:50', '2022-10-26 02:32:50'),
(205, 74, 5, 330000, 3, '2022-10-26', '', NULL, 4, 1, '2022-10-26 02:32:50', '2022-10-26 02:32:50'),
(206, 7, 5, 200000, 3, '2022-10-28', '', NULL, 2, 1, '2022-10-29 23:10:55', '2022-10-29 23:10:55'),
(207, 8, 5, 416000, 3, '2022-10-28', '', NULL, 2, 1, '2022-10-29 23:10:55', '2022-10-29 23:10:55'),
(208, 27, 5, 420000, 3, '2022-11-01', '', NULL, 1, 1, '2022-10-31 23:07:03', '2022-10-31 23:07:03'),
(209, 40, 2, 420000, 3, '2022-11-01', '', NULL, 1, 1, '2022-10-31 23:07:03', '2022-10-31 23:07:03'),
(210, 35, 6, 500000, 3, '2022-11-01', '', NULL, 1, 1, '2022-10-31 23:07:03', '2022-10-31 23:07:03'),
(211, 12, 3, 430000, 3, '2022-11-01', '', NULL, 1, 1, '2022-10-31 23:07:03', '2022-10-31 23:07:03'),
(212, 23, 5, 440000, 3, '2022-11-01', '', NULL, 1, 1, '2022-10-31 23:07:03', '2022-10-31 23:07:03'),
(213, 98, 48, 10400, 3, '2022-10-18', '', NULL, 1, 1, '2022-10-31 23:10:56', '2022-10-31 23:10:56'),
(214, 8, 12, 340000, 3, '2022-11-07', '', NULL, 1, 1, '2022-11-06 09:01:59', '2022-11-06 09:01:59'),
(215, 35, 3, 500000, 3, '2022-11-07', '', NULL, 1, 1, '2022-11-06 09:01:59', '2022-11-06 09:01:59'),
(216, 12, 2, 430000, 3, '2022-11-07', '', NULL, 1, 1, '2022-11-06 09:01:59', '2022-11-06 09:01:59'),
(217, 23, 6, 440000, 3, '2022-11-07', '', NULL, 1, 1, '2022-11-06 09:01:59', '2022-11-06 09:01:59'),
(218, 18, 5, 440000, 3, '2022-11-07', '', NULL, 1, 1, '2022-11-06 09:01:59', '2022-11-06 09:01:59'),
(219, 98, 48, 10400, 3, '2022-11-08', '', NULL, 1, 1, '2022-11-09 02:17:33', '2022-11-09 02:17:33'),
(220, 10, 3, 560000, 3, '2022-11-09', '', NULL, 4, 1, '2022-11-09 02:19:28', '2022-11-09 02:19:28'),
(221, 8, 5, 340000, 3, '2022-11-14', '', NULL, 1, 1, '2022-11-13 09:01:53', '2022-11-13 09:01:53'),
(222, 23, 3, 440000, 3, '2022-11-14', '', NULL, 1, 1, '2022-11-13 09:01:53', '2022-11-13 09:01:53'),
(223, 35, 10, 500000, 3, '2022-11-14', '', NULL, 1, 1, '2022-11-13 09:01:53', '2022-11-13 09:01:53'),
(224, 18, 6, 440000, 3, '2022-11-14', '', NULL, 1, 1, '2022-11-13 09:01:53', '2022-11-13 09:01:53'),
(225, 30, 3, 320000, 3, '2022-11-14', '', NULL, 1, 1, '2022-11-13 09:01:53', '2022-11-13 09:01:53'),
(226, 27, 6, 420000, 3, '2022-11-14', '', NULL, 1, 1, '2022-11-13 09:01:53', '2022-11-13 09:01:53'),
(227, 41, 3, 160000, 3, '2022-11-14', '', NULL, 1, 1, '2022-11-13 09:01:53', '2022-11-13 09:01:53'),
(228, 38, 3, 560000, 3, '2022-11-14', '', NULL, 1, 1, '2022-11-13 09:03:32', '2022-11-13 09:03:32'),
(229, 35, 2, 500000, 3, '2022-11-15', '', NULL, 1, 1, '2022-11-15 09:08:00', '2022-11-15 09:08:00'),
(230, 78, 5, 207200, 3, '2022-10-21', 'hằng', NULL, 8, 1, '2022-11-18 07:07:23', '2022-11-18 07:07:23'),
(231, 80, 5, 197400, 3, '2022-10-21', 'hằng', NULL, 8, 1, '2022-11-18 07:07:23', '2022-11-18 07:07:23'),
(232, 74, 5, 330000, 3, '2022-10-21', 'hằng', NULL, 8, 1, '2022-11-18 07:08:54', '2022-11-18 07:08:54'),
(233, 90, 2, 154000, 3, '2022-11-18', 'thơm', NULL, 8, 1, '2022-11-18 08:44:07', '2022-11-18 08:44:07'),
(234, 91, 1, 126000, 3, '2022-11-18', 'thơm', NULL, 8, 1, '2022-11-18 08:44:07', '2022-11-18 08:44:07'),
(235, 40, 2, 420000, 3, '2022-11-22', '', NULL, 1, 1, '2022-11-22 07:24:53', '2022-11-22 07:24:53'),
(236, 29, 6, 210000, 3, '2022-11-22', '', NULL, 1, 1, '2022-11-22 07:24:53', '2022-11-22 07:24:53'),
(237, 18, 5, 440000, 3, '2022-11-22', '', NULL, 1, 1, '2022-11-22 07:24:53', '2022-11-22 07:24:53'),
(238, 8, 3, 340000, 3, '2022-11-22', '', NULL, 1, 1, '2022-11-22 07:24:53', '2022-11-22 07:24:53'),
(239, 12, 3, 430000, 3, '2022-11-22', '', NULL, 1, 1, '2022-11-22 07:24:53', '2022-11-22 07:24:53'),
(240, 35, 3, 500000, 3, '2022-11-22', '', NULL, 1, 1, '2022-11-22 07:24:53', '2022-11-22 07:24:53'),
(241, 98, 48, 10400, 3, '2022-11-22', '', NULL, 1, 1, '2022-11-22 07:24:53', '2022-11-22 07:24:53'),
(242, 23, 5, 440000, 3, '2022-11-22', '', NULL, 1, 1, '2022-11-22 07:24:53', '2022-11-22 07:24:53'),
(243, 89, 2, 84000, 3, '2022-11-22', 'thơm', NULL, 8, 1, '2022-11-22 07:25:57', '2022-11-22 07:25:57'),
(244, 8, 5, 340000, 3, '2022-11-28', '', NULL, 1, 1, '2022-12-02 03:17:51', '2022-12-02 03:17:51'),
(245, 18, 5, 440000, 3, '2022-11-28', '', NULL, 1, 1, '2022-12-02 03:17:51', '2022-12-02 03:17:51'),
(246, 7, 3, 170000, 3, '2022-11-28', '', NULL, 1, 1, '2022-12-02 03:17:51', '2022-12-02 03:17:51'),
(247, 35, 3, 500000, 3, '2022-11-28', '', NULL, 1, 1, '2022-12-02 03:17:51', '2022-12-02 03:17:51'),
(249, 8, 12, 340000, 3, '2022-12-08', '', NULL, 1, 1, '2022-12-07 08:26:57', '2022-12-07 20:41:31'),
(250, 18, 24, 440000, 3, '2022-12-08', '', NULL, 1, 1, '2022-12-07 08:26:57', '2022-12-07 08:26:57'),
(251, 35, 12, 500000, 3, '2022-12-08', '', NULL, 1, 1, '2022-12-07 08:26:57', '2022-12-07 20:40:20'),
(252, 38, 0, 560000, 3, '2022-12-08', '', NULL, 1, 1, '2022-12-07 08:26:57', '2022-12-07 20:40:36'),
(253, 12, 4, 430000, 3, '2022-12-08', '', NULL, 1, 1, '2022-12-07 08:26:57', '2022-12-07 08:26:57'),
(254, 27, 2, 420000, 3, '2022-12-08', '', NULL, 1, 1, '2022-12-07 08:26:57', '2022-12-07 08:26:57'),
(255, 20, 1, 560000, 3, '2022-12-08', 'nhập lại kho ', NULL, 1, 1, '2022-12-08 08:14:51', '2022-12-08 08:14:51'),
(256, 100, 30, 23000, 3, '2022-11-14', '', NULL, 1, 1, '2022-12-09 08:28:26', '2022-12-09 08:28:26'),
(257, 101, 20, 23000, 3, '2022-11-21', '', NULL, 1, 1, '2022-12-09 08:28:26', '2022-12-09 08:28:26'),
(258, 23, 6, 440000, 3, '2022-12-08', '', NULL, 1, 1, '2022-12-10 08:48:18', '2022-12-10 08:48:18'),
(259, 8, 12, 340000, 3, '2022-12-15', '', NULL, 1, 1, '2022-12-15 09:26:26', '2022-12-15 09:26:26'),
(260, 26, 3, 210000, 3, '2022-12-15', '', NULL, 1, 1, '2022-12-15 09:26:26', '2022-12-15 09:26:26'),
(261, 91, 1, 126000, 3, '2022-12-20', '', NULL, 8, 1, '2022-12-20 07:16:14', '2022-12-20 07:16:14'),
(262, 95, 4, 101500, 3, '2022-12-20', '', NULL, 8, 1, '2022-12-20 07:32:03', '2022-12-20 07:32:03'),
(263, 8, 12, 340000, 3, '2022-12-21', '', NULL, 1, 1, '2022-12-26 07:15:44', '2022-12-26 07:15:44'),
(264, 8, 12, 340000, 3, '2022-12-27', '', NULL, 1, 1, '2022-12-30 23:16:37', '2022-12-30 23:16:37'),
(265, 18, 12, 440000, 3, '2022-12-27', '', NULL, 1, 1, '2022-12-30 23:16:37', '2022-12-30 23:16:37'),
(266, 37, 2, 280000, 3, '2022-12-27', '', NULL, 1, 1, '2022-12-30 23:16:37', '2022-12-30 23:16:37'),
(268, 38, 5, 560000, 3, '2022-12-27', '', NULL, 1, 1, '2022-12-30 23:16:37', '2022-12-30 23:16:37'),
(269, 23, 5, 440000, 3, '2022-12-27', '', NULL, 1, 1, '2022-12-30 23:16:37', '2022-12-30 23:16:37'),
(270, 15, 6, 440000, 3, '2022-12-28', '', NULL, 1, 1, '2022-12-30 23:16:52', '2022-12-30 23:16:52'),
(271, 18, 12, 440000, 3, '2023-01-03', '', NULL, 1, 1, '2022-12-30 23:21:50', '2022-12-30 23:21:50'),
(272, 26, 5, 210000, 3, '2023-01-03', '', NULL, 1, 1, '2022-12-30 23:21:50', '2022-12-30 23:21:50'),
(273, 29, 6, 210000, 3, '2023-01-03', '', NULL, 1, 1, '2022-12-30 23:21:50', '2022-12-30 23:21:50'),
(274, 34, 2, 250000, 3, '2022-12-27', '', NULL, 1, 1, '2023-01-08 21:19:17', '2023-01-08 21:25:01'),
(275, 7, 5, 170000, 3, '2023-01-10', '', NULL, 1, 1, '2023-01-09 05:28:17', '2023-01-09 05:28:17'),
(276, 43, 5, 220000, 3, '2023-01-10', '', NULL, 1, 1, '2023-01-09 05:28:17', '2023-01-09 05:28:17'),
(277, 17, 5, 220000, 3, '2023-01-10', '', NULL, 1, 1, '2023-01-09 05:28:17', '2023-01-09 05:28:17'),
(278, 22, 3, 220000, 3, '2023-01-10', '', NULL, 1, 1, '2023-01-09 05:28:17', '2023-01-09 05:28:17'),
(279, 8, 8, 340000, 3, '2023-01-10', '', NULL, 1, 1, '2023-01-09 05:28:17', '2023-01-09 05:28:17'),
(280, 27, 3, 420000, 3, '2023-01-10', '', NULL, 1, 1, '2023-01-09 05:28:17', '2023-01-09 05:28:17'),
(281, 14, 3, 220000, 3, '2023-01-10', '', NULL, 1, 1, '2023-01-09 05:28:17', '2023-01-09 05:28:17'),
(282, 35, 5, 500000, 3, '2023-01-10', '', NULL, 1, 1, '2023-01-09 05:28:17', '2023-01-09 05:28:17'),
(283, 43, 5, 220000, 3, '2023-01-09', '', NULL, 1, 1, '2023-01-09 05:28:45', '2023-01-09 05:28:45'),
(284, 20, 2, 560000, 3, '2023-01-10', '', NULL, 1, 1, '2023-01-10 19:41:51', '2023-01-10 19:41:51'),
(285, 89, 3, 84000, 3, '2023-01-13', '', NULL, 8, 1, '2023-01-12 19:57:51', '2023-01-12 19:57:51'),
(286, 4, 2, 340000, 3, '2023-01-16', '', NULL, 1, 1, '2023-01-15 07:31:10', '2023-01-15 07:31:10'),
(287, 8, 12, 340000, 3, '2023-01-16', '', NULL, 1, 1, '2023-01-15 07:31:10', '2023-01-15 07:31:10'),
(288, 18, 15, 440000, 3, '2023-01-16', '', NULL, 1, 1, '2023-01-15 07:31:10', '2023-01-15 07:32:39'),
(289, 23, 6, 440000, 3, '2023-01-16', '', NULL, 1, 1, '2023-01-15 07:31:10', '2023-01-15 07:31:10'),
(290, 35, 4, 500000, 3, '2023-01-16', '', NULL, 1, 1, '2023-01-15 07:31:10', '2023-01-15 07:31:10'),
(291, 38, 5, 560000, 3, '2023-01-16', '', NULL, 1, 1, '2023-01-15 07:31:10', '2023-01-15 07:31:10'),
(292, 44, 3, 440000, 3, '2023-01-16', '', NULL, 1, 1, '2023-01-15 07:31:10', '2023-01-15 07:31:10'),
(293, 8, 5, 400000, 3, '2023-01-16', '', NULL, 4, 1, '2023-01-15 07:39:59', '2023-01-15 07:39:59'),
(294, 5, 2, 200000, 3, '2023-01-16', '', NULL, 4, 1, '2023-01-15 07:39:59', '2023-01-15 07:39:59'),
(295, 4, 2, 340000, 3, '2023-01-16', '', NULL, 1, 1, '2023-01-16 09:44:32', '2023-01-16 09:44:32'),
(296, 18, 3, 440000, 3, '2023-01-16', '', NULL, 1, 1, '2023-01-16 09:44:32', '2023-01-16 09:44:32'),
(297, 29, 10, 210000, 3, '2023-01-16', '', NULL, 1, 1, '2023-01-16 09:44:32', '2023-01-16 09:44:32'),
(298, 15, 2, 440000, 3, '2023-01-19', '', NULL, 1, 1, '2023-01-19 04:54:22', '2023-01-19 04:54:22'),
(299, 40, 2, 420000, 3, '2023-01-19', '', NULL, 1, 1, '2023-01-19 04:54:22', '2023-01-19 04:54:22'),
(300, 37, 2, 280000, 3, '2023-01-19', '', NULL, 1, 1, '2023-01-19 04:54:22', '2023-01-19 04:54:22'),
(301, 41, 5, 160000, 3, '2023-01-19', '', NULL, 1, 1, '2023-01-19 04:54:22', '2023-01-19 04:54:22'),
(302, 26, 1, 210000, 3, '2023-01-19', 'thương gửi', NULL, 1, 1, '2023-01-19 04:55:54', '2023-01-19 04:55:54'),
(303, 18, 12, 440000, 3, '2023-01-30', '', NULL, 1, 1, '2023-01-29 20:42:05', '2023-01-29 20:42:05'),
(304, 37, 2, 280000, 3, '2023-01-30', '', NULL, 1, 1, '2023-01-29 20:42:05', '2023-01-29 20:42:05'),
(305, 43, 3, 220000, 3, '2023-01-30', '', NULL, 1, 1, '2023-01-29 20:42:05', '2023-01-29 20:42:05'),
(306, 3, 3, 170000, 3, '2023-01-30', '', NULL, 1, 1, '2023-01-29 20:42:05', '2023-01-29 20:42:05'),
(307, 4, 2, 340000, 3, '2023-01-30', '', NULL, 1, 1, '2023-01-29 20:42:05', '2023-01-29 20:42:05'),
(308, 5, 2, 170000, 3, '2023-01-30', '', NULL, 1, 1, '2023-01-29 20:42:05', '2023-01-29 20:42:05'),
(309, 6, 2, 340000, 3, '2023-01-30', '', NULL, 1, 1, '2023-01-29 20:42:05', '2023-01-29 20:42:05'),
(310, 20, 2, 560000, 3, '2023-01-30', '', NULL, 1, 1, '2023-01-29 20:46:06', '2023-01-29 20:46:06'),
(311, 8, 12, 340000, 3, '2023-02-13', '', NULL, 1, 1, '2023-02-12 21:03:44', '2023-02-12 21:03:44'),
(312, 18, 12, 440000, 3, '2023-02-13', '', NULL, 1, 1, '2023-02-12 21:03:44', '2023-02-12 21:03:44'),
(313, 31, 2, 260000, 3, '2023-02-13', '', NULL, 1, 1, '2023-02-12 21:03:44', '2023-02-12 21:03:44'),
(314, 19, 2, 270000, 3, '2023-02-14', 'giao nhầm hàng (đặt pro 10+4)', NULL, 1, 1, '2023-02-14 08:55:12', '2023-02-14 08:55:12'),
(315, 103, 48, 7200, 3, '2023-02-14', '', NULL, 1, 1, '2023-02-14 10:02:15', '2023-02-14 10:02:15'),
(316, 4, 3, 340000, 3, '2023-02-20', '', NULL, 1, 1, '2023-02-19 19:59:07', '2023-02-20 20:42:46'),
(317, 6, 3, 340000, 3, '2023-02-20', '', NULL, 1, 1, '2023-02-19 19:59:07', '2023-02-20 20:31:50'),
(318, 32, 2, 520000, 3, '2023-02-20', '', NULL, 1, 1, '2023-02-19 19:59:07', '2023-02-19 19:59:07'),
(319, 31, 2, 260000, 3, '2023-02-20', '', NULL, 1, 1, '2023-02-19 19:59:07', '2023-02-19 19:59:07'),
(320, 103, 48, 7200, 3, '2023-02-21', '', NULL, 1, 1, '2023-02-20 20:29:55', '2023-02-20 20:29:55'),
(321, 7, 3, 170000, 3, '2023-02-21', '', NULL, 1, 1, '2023-02-20 20:40:44', '2023-02-20 20:40:44'),
(322, 102, 3, 200000, 3, '2023-02-21', '', NULL, 1, 1, '2023-02-21 01:53:23', '2023-02-21 01:53:23'),
(323, 98, 48, 10400, 3, '2023-02-24', '', NULL, 1, 1, '2023-02-26 06:04:46', '2023-02-26 06:04:46'),
(327, 18, 5, 440000, 3, '2023-02-28', '', NULL, 1, 1, '2023-02-27 07:10:48', '2023-02-27 07:10:48'),
(328, 11, 3, 215000, 3, '2023-02-28', '', NULL, 1, 1, '2023-02-27 07:10:48', '2023-02-27 07:10:48'),
(329, 44, 4, 440000, 3, '2023-02-28', '', NULL, 1, 1, '2023-02-27 07:10:48', '2023-02-27 07:10:48'),
(330, 103, 48, 7200, 3, '2023-02-28', '', NULL, 1, 1, '2023-02-27 07:10:48', '2023-02-27 07:10:48'),
(331, 8, 5, 340000, 3, '2023-02-28', '', NULL, 1, 1, '2023-02-27 11:01:57', '2023-02-27 11:01:57'),
(332, 8, 5, 340000, 3, '2023-03-01', '', NULL, 1, 1, '2023-02-28 09:50:42', '2023-02-28 09:50:42'),
(333, 8, 10, 340000, 3, '2023-03-06', '', NULL, 1, 1, '2023-03-05 09:44:59', '2023-03-05 09:44:59'),
(334, 18, 12, 440000, 3, '2023-03-06', '', NULL, 1, 1, '2023-03-05 09:44:59', '2023-03-05 09:44:59'),
(335, 27, 3, 420000, 3, '2023-03-06', '', NULL, 1, 1, '2023-03-05 09:44:59', '2023-03-05 09:44:59'),
(336, 38, 3, 560000, 3, '2023-03-06', '', NULL, 1, 1, '2023-03-05 09:44:59', '2023-03-05 09:44:59');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `menus`
--

CREATE TABLE `menus` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `menus`
--

INSERT INTO `menus` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'admin', '2022-08-19 20:05:03', '2022-08-19 20:05:03');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `menu_items`
--

CREATE TABLE `menu_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `menu_id` int(10) UNSIGNED DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `target` varchar(255) NOT NULL DEFAULT '_self',
  `icon_class` varchar(255) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `order` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `route` varchar(255) DEFAULT NULL,
  `parameters` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `menu_items`
--

INSERT INTO `menu_items` (`id`, `menu_id`, `title`, `url`, `target`, `icon_class`, `color`, `parent_id`, `order`, `created_at`, `updated_at`, `route`, `parameters`) VALUES
(1, 1, 'Dashboard', '', '_self', 'voyager-boat', NULL, NULL, 1, '2022-08-19 20:05:03', '2022-08-19 20:05:03', 'voyager.dashboard', NULL),
(2, 1, 'Media', '', '_self', 'voyager-images', NULL, NULL, 10, '2022-08-19 20:05:03', '2022-08-30 01:05:16', 'voyager.media.index', NULL),
(3, 1, 'Users', '', '_self', 'voyager-person', NULL, NULL, 9, '2022-08-19 20:05:03', '2022-08-30 01:05:16', 'voyager.users.index', NULL),
(4, 1, 'Roles', '', '_self', 'voyager-lock', NULL, NULL, 8, '2022-08-19 20:05:03', '2022-09-04 19:55:11', 'voyager.roles.index', NULL),
(5, 1, 'Tools', '', '_self', 'voyager-tools', NULL, NULL, 14, '2022-08-19 20:05:03', '2022-08-30 01:05:12', NULL, NULL),
(6, 1, 'Menu Builder', '', '_self', 'voyager-list', NULL, 5, 1, '2022-08-19 20:05:03', '2022-08-19 20:27:07', 'voyager.menus.index', NULL),
(7, 1, 'Database', '', '_self', 'voyager-data', NULL, 5, 2, '2022-08-19 20:05:03', '2022-08-19 20:27:07', 'voyager.database.index', NULL),
(8, 1, 'Compass', '', '_self', 'voyager-compass', NULL, 5, 3, '2022-08-19 20:05:03', '2022-08-19 20:27:07', 'voyager.compass.index', NULL),
(9, 1, 'BREAD', '', '_self', 'voyager-bread', NULL, 5, 4, '2022-08-19 20:05:03', '2022-08-19 20:27:07', 'voyager.bread.index', NULL),
(10, 1, 'Settings', '', '_self', 'voyager-settings', NULL, NULL, 15, '2022-08-19 20:05:03', '2022-08-30 01:05:12', 'voyager.settings.index', NULL),
(11, 1, 'Categories', '', '_self', 'voyager-categories', NULL, NULL, 13, '2022-08-19 20:05:03', '2022-08-30 01:05:16', 'voyager.categories.index', NULL),
(12, 1, 'Posts', '', '_self', 'voyager-news', NULL, NULL, 11, '2022-08-19 20:05:03', '2022-08-30 01:05:16', 'voyager.posts.index', NULL),
(13, 1, 'Pages', '', '_self', 'voyager-file-text', NULL, NULL, 12, '2022-08-19 20:05:03', '2022-08-30 01:05:16', 'voyager.pages.index', NULL),
(14, 1, 'Sản phẩm', '', '_self', 'voyager-bag', '#000000', NULL, 2, '2022-08-19 20:10:16', '2022-08-20 20:52:18', 'voyager.products.index', 'null'),
(22, 1, 'Giá', '', '_self', 'voyager-dollar', '#000000', NULL, 3, '2022-08-26 02:36:29', '2022-08-27 06:55:40', 'voyager.price.index', 'null'),
(24, 1, 'Nhãn hàng', '', '_self', 'voyager-shop', '#000000', NULL, 5, '2022-08-27 06:54:21', '2022-08-27 06:59:28', 'voyager.brands.index', 'null'),
(25, 1, 'Chiết khấu', '', '_self', 'voyager-scissors', '#000000', NULL, 4, '2022-08-27 06:58:04', '2022-08-27 06:59:28', 'voyager.discount.index', 'null'),
(26, 1, 'Kho', '', '_self', 'voyager-home', '#000000', NULL, 6, '2022-08-27 07:01:27', '2022-08-27 07:02:04', 'voyager.warehouse.index', 'null'),
(27, 1, 'Campains', '', '_self', 'voyager-group', NULL, NULL, 7, '2022-08-30 01:05:01', '2022-09-04 19:55:11', 'voyager.campain.index', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2016_01_01_000000_add_voyager_user_fields', 1),
(4, '2016_01_01_000000_create_data_types_table', 1),
(5, '2016_05_19_173453_create_menu_table', 1),
(6, '2016_10_21_190000_create_roles_table', 1),
(7, '2016_10_21_190000_create_settings_table', 1),
(8, '2016_11_30_135954_create_permission_table', 1),
(9, '2016_11_30_141208_create_permission_role_table', 1),
(10, '2016_12_26_201236_data_types__add__server_side', 1),
(11, '2017_01_13_000000_add_route_to_menu_items_table', 1),
(12, '2017_01_14_005015_create_translations_table', 1),
(13, '2017_01_15_000000_make_table_name_nullable_in_permissions_table', 1),
(14, '2017_03_06_000000_add_controller_to_data_types_table', 1),
(15, '2017_04_21_000000_add_order_to_data_rows_table', 1),
(16, '2017_07_05_210000_add_policyname_to_data_types_table', 1),
(17, '2017_08_05_000000_add_group_to_settings_table', 1),
(18, '2017_11_26_013050_add_user_role_relationship', 1),
(19, '2017_11_26_015000_create_user_roles_table', 1),
(20, '2018_03_11_000000_add_user_settings', 1),
(21, '2018_03_14_000000_add_details_to_data_types_table', 1),
(22, '2018_03_16_000000_make_settings_value_nullable', 1),
(23, '2019_08_19_000000_create_failed_jobs_table', 1),
(24, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(25, '2016_01_01_000000_create_pages_table', 2),
(26, '2016_01_01_000000_create_posts_table', 2),
(27, '2016_02_15_204651_create_categories_table', 2),
(28, '2017_04_11_000000_alter_post_nullable_fields_table', 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `pages`
--

CREATE TABLE `pages` (
  `id` int(10) UNSIGNED NOT NULL,
  `author_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `excerpt` text DEFAULT NULL,
  `body` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
  `meta_description` text DEFAULT NULL,
  `meta_keywords` text DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') NOT NULL DEFAULT 'INACTIVE',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `pages`
--

INSERT INTO `pages` (`id`, `author_id`, `title`, `excerpt`, `body`, `image`, `slug`, `meta_description`, `meta_keywords`, `status`, `created_at`, `updated_at`) VALUES
(1, 0, 'Hello World', 'Hang the jib grog grog blossom grapple dance the hempen jig gangway pressgang bilge rat to go on account lugger. Nelsons folly gabion line draught scallywag fire ship gaff fluke fathom case shot. Sea Legs bilge rat sloop matey gabion long clothes run a shot across the bow Gold Road cog league.', '<p>Hello World. Scallywag grog swab Cat o\'nine tails scuttle rigging hardtack cable nipper Yellow Jack. Handsomely spirits knave lad killick landlubber or just lubber deadlights chantey pinnace crack Jennys tea cup. Provost long clothes black spot Yellow Jack bilged on her anchor league lateen sail case shot lee tackle.</p>\n<p>Ballast spirits fluke topmast me quarterdeck schooner landlubber or just lubber gabion belaying pin. Pinnace stern galleon starboard warp carouser to go on account dance the hempen jig jolly boat measured fer yer chains. Man-of-war fire in the hole nipperkin handsomely doubloon barkadeer Brethren of the Coast gibbet driver squiffy.</p>', 'pages/page1.jpg', 'hello-world', 'Yar Meta Description', 'Keyword1, Keyword2', 'ACTIVE', '2022-08-19 20:05:03', '2022-08-19 20:05:03');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `pay`
--

CREATE TABLE `pay` (
  `id` int(10) UNSIGNED NOT NULL,
  `pro_id` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `report_date` date DEFAULT NULL,
  `note` longtext DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `warehouse_id` int(11) DEFAULT 1,
  `campain_id` int(10) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `pay`
--

INSERT INTO `pay` (`id`, `pro_id`, `price`, `total`, `report_date`, `note`, `created_by`, `brand_id`, `warehouse_id`, `campain_id`, `created_at`, `updated_at`) VALUES
(3, 8, 340000, 8, '2022-07-08', '', 2, 1, 1, 1, '2022-08-22 09:23:05', '2022-08-22 09:23:05'),
(4, 18, 440000, 3, '2022-07-08', '', 2, 1, 1, 1, '2022-08-22 09:25:51', '2022-08-22 09:25:51'),
(5, 21, 230000, 2, '2022-07-08', '', 2, 1, 1, 1, '2022-08-22 09:25:52', '2022-08-22 09:25:52'),
(6, 23, 440000, 2, '2022-07-08', '', 2, 1, 1, 1, '2022-08-22 09:25:52', '2022-08-22 09:25:52'),
(7, 27, 420000, 1, '2022-07-08', '', 2, 1, 1, 1, '2022-08-22 09:25:52', '2022-08-22 09:25:52'),
(8, 35, 500000, 6, '2022-07-08', '', 2, 1, 1, 1, '2022-08-22 09:25:52', '2022-08-22 09:25:52'),
(9, 40, 420000, 5, '2022-07-08', '', 2, 1, 1, 1, '2022-08-22 09:25:52', '2022-08-22 09:25:52'),
(10, 17, 220000, 3, '2022-07-19', '', 2, 1, 1, 1, '2022-08-22 09:31:02', '2022-08-22 09:31:02'),
(11, 18, 440000, 2, '2022-07-19', '', 2, 1, 1, 1, '2022-08-22 09:31:02', '2022-08-22 09:31:02'),
(12, 38, 560000, 1, '2022-07-19', '', 2, 1, 1, 1, '2022-08-22 09:31:02', '2022-08-22 09:31:02'),
(13, 40, 420000, 3, '2022-07-19', '', 2, 1, 1, 1, '2022-08-22 09:31:02', '2022-08-22 09:31:02'),
(14, 44, 440000, 3, '2022-07-19', '', 2, 1, 1, 1, '2022-08-22 09:31:02', '2022-08-22 09:31:02'),
(15, 8, 340000, 4, '2022-07-19', '', 2, 1, 1, 1, '2022-08-22 09:31:02', '2022-08-22 09:31:02'),
(16, 35, 500000, 1, '2022-07-19', '', 2, 1, 1, 1, '2022-08-22 09:31:02', '2022-08-22 09:31:02'),
(17, 23, 440000, 5, '2022-07-25', '', 2, 1, 1, 1, '2022-08-22 09:34:15', '2022-08-22 09:34:15'),
(18, 18, 440000, 3, '2022-07-25', '', 2, 1, 1, 1, '2022-08-22 09:34:15', '2022-08-22 09:34:15'),
(19, 40, 420000, 8, '2022-07-25', '', 2, 1, 1, 1, '2022-08-22 09:34:15', '2022-08-22 09:34:15'),
(20, 8, 340000, 2, '2022-07-25', '', 2, 1, 1, 1, '2022-08-22 09:34:15', '2022-08-22 09:34:15'),
(21, 35, 500000, 2, '2022-07-25', '', 2, 1, 1, 1, '2022-08-22 09:34:15', '2022-08-22 09:34:15'),
(22, 15, 440000, 1, '2022-07-25', '', 2, 1, 1, 1, '2022-08-22 09:34:15', '2022-08-22 09:34:15'),
(23, 32, 520000, 2, '2022-07-28', '', 2, 1, 1, 1, '2022-08-22 09:36:30', '2022-08-22 09:36:30'),
(24, 44, 440000, 2, '2022-07-28', '', 2, 1, 1, 1, '2022-08-22 09:36:30', '2022-08-22 09:36:30'),
(25, 8, 340000, 4, '2022-07-28', '', 2, 1, 1, 1, '2022-08-22 09:36:30', '2022-08-22 09:36:30'),
(26, 18, 440000, 4, '2022-07-28', '', 2, 1, 1, 1, '2022-08-22 09:36:30', '2022-08-22 09:36:30'),
(27, 34, 250000, 2, '2022-07-28', '', 2, 1, 1, 1, '2022-08-22 09:36:30', '2022-08-22 09:36:30'),
(28, 42, 220000, 2, '2022-07-29', '', 2, 1, 1, 1, '2022-08-22 09:38:39', '2022-08-22 09:38:39'),
(29, 6, 340000, 4, '2022-07-29', '', 2, 1, 1, 1, '2022-08-22 09:38:39', '2022-08-22 09:38:39'),
(30, 11, 215000, 1, '2022-07-29', '', 2, 1, 1, 1, '2022-08-22 09:38:39', '2022-08-22 09:38:39'),
(31, 18, 440000, 5, '2022-07-29', '', 2, 1, 1, 1, '2022-08-22 09:38:39', '2022-08-22 09:38:39'),
(32, 8, 340000, 1, '2022-07-29', '', 2, 1, 1, 1, '2022-08-22 09:38:39', '2022-08-22 09:38:39'),
(33, 15, 440000, 1, '2022-07-29', '', 2, 1, 1, 1, '2022-08-22 09:38:39', '2022-08-22 09:38:39'),
(34, 30, 320000, 3, '2022-07-29', 'trả hàng', 2, 1, 1, 1, '2022-08-22 09:38:39', '2022-08-22 09:38:39'),
(35, 26, 210000, 3, '2022-07-29', 'trả hàng', 2, 1, 1, 1, '2022-08-22 09:38:39', '2022-08-22 09:38:39'),
(36, 24, 210000, 2, '2022-07-29', 'trả hàng', 2, 1, 1, 1, '2022-08-22 09:38:39', '2022-08-22 09:38:39'),
(37, 18, 440000, 1, '2022-08-05', '', 2, 1, 1, 1, '2022-08-22 09:41:48', '2022-08-22 09:41:48'),
(38, 44, 440000, 2, '2022-08-05', '', 2, 1, 1, 1, '2022-08-22 09:41:48', '2022-08-22 09:41:48'),
(39, 35, 500000, 3, '2022-08-05', '', 2, 1, 1, 1, '2022-08-22 09:41:48', '2022-08-22 09:41:48'),
(40, 21, 230000, 3, '2022-08-05', '', 2, 1, 1, 1, '2022-08-22 09:41:48', '2022-08-22 09:41:48'),
(41, 23, 440000, 1, '2022-08-05', '', 2, 1, 1, 1, '2022-08-22 09:41:48', '2022-08-22 09:41:48'),
(42, 15, 440000, 1, '2022-08-05', '', 2, 1, 1, 1, '2022-08-22 09:41:48', '2022-08-22 09:41:48'),
(43, 38, 560000, 2, '2022-08-05', '', 2, 1, 1, 1, '2022-08-22 09:41:48', '2022-08-22 09:41:48'),
(44, 8, 340000, 7, '2022-08-05', '', 2, 1, 1, 1, '2022-08-22 09:41:48', '2022-08-22 09:41:48'),
(45, 9, 210000, 2, '2022-08-12', '', 2, 1, 1, 1, '2022-08-22 09:52:52', '2022-08-22 09:52:52'),
(46, 17, 220000, 1, '2022-08-12', '', 2, 1, 1, 1, '2022-08-22 09:52:52', '2022-08-22 09:52:52'),
(47, 30, 320000, 2, '2022-08-12', '', 2, 1, 1, 1, '2022-08-22 09:52:52', '2022-08-22 09:52:52'),
(48, 32, 520000, 2, '2022-08-12', '', 2, 1, 1, 1, '2022-08-22 09:52:52', '2022-08-22 09:52:52'),
(49, 40, 420000, 1, '2022-08-12', '', 2, 1, 1, 1, '2022-08-22 09:52:52', '2022-08-22 09:52:52'),
(50, 44, 440000, 5, '2022-08-12', '', 2, 1, 1, 1, '2022-08-22 09:52:52', '2022-08-22 09:52:52'),
(51, 23, 440000, 1, '2022-08-12', '', 2, 1, 1, 1, '2022-08-22 09:52:52', '2022-08-22 09:52:52'),
(52, 15, 440000, 1, '2022-08-12', '', 2, 1, 1, 1, '2022-08-22 09:52:52', '2022-08-22 09:52:52'),
(53, 18, 440000, 2, '2022-08-12', '', 2, 1, 1, 1, '2022-08-22 09:52:52', '2022-08-22 09:52:52'),
(54, 8, 340000, 4, '2022-08-12', '', 2, 1, 1, 1, '2022-08-22 09:52:52', '2022-08-22 09:52:52'),
(55, 4, 340000, 3, '2022-06-29', 'trả hàng', 2, 1, 1, 1, '2022-08-22 10:02:06', '2022-08-22 10:02:06'),
(56, 10, 420000, 1, '2022-08-17', '', 3, 1, 1, 1, '2022-08-23 02:36:55', '2022-08-23 02:36:55'),
(57, 18, 440000, 7, '2022-08-17', 'Thực tế thanh toán 8, vì công nợ trước đó có 7 nên chỉ nhập được 7 (1 sẽ cộng vào lần thanh toán tiếp theo)', 3, 1, 1, 1, '2022-08-23 02:36:55', '2022-08-23 02:36:55'),
(58, 39, 210000, 3, '2022-08-17', '', 3, 1, 1, 1, '2022-08-23 02:36:55', '2022-08-23 02:36:55'),
(59, 30, 320000, 2, '2022-08-17', '', 3, 1, 1, 1, '2022-08-23 02:36:55', '2022-08-23 02:36:55'),
(60, 35, 500000, 8, '2022-08-17', '', 3, 1, 1, 1, '2022-08-23 02:36:55', '2022-08-23 02:36:55'),
(61, 38, 560000, 2, '2022-08-17', '', 3, 1, 1, 1, '2022-08-23 02:36:55', '2022-08-23 02:36:55'),
(62, 23, 440000, 1, '2022-08-17', '', 3, 1, 1, 1, '2022-08-23 02:36:55', '2022-08-23 02:36:55'),
(63, 8, 340000, 6, '2022-08-17', '', 3, 1, 1, 1, '2022-08-23 02:36:55', '2022-08-23 02:36:55'),
(64, 10, 420000, 1, '2022-08-19', '', 3, 1, 1, 1, '2022-08-23 02:40:52', '2022-08-23 02:40:52'),
(65, 17, 220000, 1, '2022-08-19', '', 3, 1, 1, 1, '2022-08-23 02:40:52', '2022-08-23 02:40:52'),
(66, 41, 160000, 1, '2022-08-19', '', 3, 1, 1, 1, '2022-08-23 02:40:52', '2022-08-23 02:40:52'),
(67, 23, 440000, 3, '2022-08-19', '', 3, 1, 1, 1, '2022-08-23 02:40:52', '2022-08-23 02:40:52'),
(68, 30, 320000, 2, '2022-08-19', '', 3, 1, 1, 1, '2022-08-23 02:40:52', '2022-08-23 02:40:52'),
(69, 18, 440000, 4, '2022-08-19', '', 3, 1, 1, 1, '2022-08-23 02:40:52', '2022-08-23 02:40:52'),
(70, 34, 250000, 4, '2022-08-19', '', 3, 1, 1, 1, '2022-08-23 02:40:52', '2022-08-23 02:40:52'),
(71, 39, 210000, 3, '2022-08-19', 'thanh toán bù cho 3 lon ngày 6/6 do đã đạt được sự thỏa thuận giữa 2 bên', 3, 1, 1, 1, '2022-08-23 02:42:23', '2022-08-23 02:42:23'),
(72, 40, 420000, 5, '2022-08-23', '', 3, 1, 1, 1, '2022-08-23 03:34:22', '2022-08-23 03:34:22'),
(73, 23, 440000, 3, '2022-08-23', '', 3, 1, 1, 1, '2022-08-23 03:34:22', '2022-08-23 03:34:22'),
(74, 8, 340000, 5, '2022-08-23', '', 3, 1, 1, 1, '2022-08-23 03:34:22', '2022-08-23 03:34:22'),
(75, 15, 440000, 1, '2022-08-23', '', 3, 1, 1, 1, '2022-08-23 03:34:22', '2022-08-23 03:34:22'),
(76, 35, 500000, 2, '2022-08-23', '', 3, 1, 1, 1, '2022-08-23 03:34:22', '2022-08-23 03:34:22'),
(77, 30, 320000, 3, '2022-08-23', '', 3, 1, 1, 1, '2022-08-23 03:34:22', '2022-08-23 03:34:22'),
(78, 20, 540000, 1, '2022-08-23', '', 3, 1, 1, 1, '2022-08-23 03:34:22', '2022-08-23 03:34:22'),
(79, 29, 210000, 2, '2022-08-26', '', 3, 1, 1, 1, '2022-08-26 01:40:47', '2022-08-26 01:40:47'),
(80, 40, 420000, 2, '2022-08-26', '', 3, 1, 1, 1, '2022-08-26 01:40:47', '2022-08-26 01:40:47'),
(81, 44, 440000, 2, '2022-08-26', '', 3, 1, 1, 1, '2022-08-26 01:40:47', '2022-08-26 01:40:47'),
(82, 8, 340000, 3, '2022-08-26', '', 3, 1, 1, 1, '2022-08-26 01:40:47', '2022-08-26 01:40:47'),
(83, 23, 440000, 2, '2022-08-26', '', 3, 1, 1, 1, '2022-08-26 01:40:47', '2022-08-26 01:40:47'),
(84, 22, 220000, 2, '2022-08-26', '', 3, 1, 1, 1, '2022-08-26 01:40:47', '2022-08-26 01:40:47'),
(85, 30, 320000, 5, '2022-08-26', '', 3, 1, 1, 1, '2022-08-26 01:40:47', '2022-08-26 01:40:47'),
(86, 14, 220000, 5, '2022-08-26', '', 3, 1, 1, 1, '2022-08-26 01:40:47', '2022-08-26 01:40:47'),
(87, 16, 230000, 2, '2022-08-29', 'trả hàng', 3, NULL, 1, 1, '2022-09-02 01:07:39', '2022-09-02 01:07:39'),
(88, 16, 230000, 1, '2022-09-05', '', 3, NULL, 1, 1, '2022-09-03 07:21:54', '2022-09-03 07:21:54'),
(89, 21, 230000, 2, '2022-09-05', '', 3, NULL, 1, 1, '2022-09-03 07:21:54', '2022-09-03 07:21:54'),
(90, 27, 420000, 1, '2022-09-05', '', 3, NULL, 1, 1, '2022-09-03 07:21:54', '2022-09-03 07:21:54'),
(91, 15, 440000, 2, '2022-09-05', '', 3, NULL, 1, 1, '2022-09-03 07:21:54', '2022-09-03 07:21:54'),
(92, 23, 440000, 3, '2022-09-05', '', 3, NULL, 1, 1, '2022-09-03 07:21:54', '2022-09-03 07:21:54'),
(93, 35, 500000, 5, '2022-09-05', '', 3, NULL, 1, 1, '2022-09-03 07:21:54', '2022-09-03 07:21:54'),
(94, 40, 420000, 5, '2022-09-05', '', 3, NULL, 1, 1, '2022-09-03 07:21:54', '2022-09-03 07:21:54'),
(95, 8, 340000, 6, '2022-09-05', '', 3, NULL, 1, 1, '2022-09-03 07:21:54', '2022-09-03 07:21:54'),
(96, 18, 440000, 9, '2022-09-05', 'thực tế thanh toán 8 nhưng vì 19/8 thanh toán thừa 1 hope nên cộng vào thành 9. ', 3, NULL, 1, 1, '2022-09-03 07:21:54', '2022-09-03 08:39:17'),
(97, 30, 320000, 5, '2022-09-05', '', 3, NULL, 1, 1, '2022-09-03 07:21:54', '2022-09-03 07:21:54'),
(98, 38, 560000, 3, '2022-09-05', '', 3, NULL, 1, 1, '2022-09-03 07:21:54', '2022-09-03 07:21:54'),
(99, 21, 263000, 1, '2022-09-05', '', 3, NULL, 3, 1, '2022-09-06 08:33:16', '2022-09-06 08:33:16'),
(100, 55, 61000, 1, '2022-09-05', '', 3, NULL, 3, 1, '2022-09-06 08:33:16', '2022-09-06 08:33:16'),
(101, 9, 263000, 1, '2022-09-05', '', 3, NULL, 3, 1, '2022-09-06 08:33:16', '2022-09-06 08:33:16'),
(102, 58, 36500, 3, '2022-09-05', '', 3, NULL, 3, 1, '2022-09-06 08:33:16', '2022-09-06 08:33:16'),
(103, 59, 44500, 12, '2022-09-05', '', 3, NULL, 3, 1, '2022-09-06 08:33:16', '2022-09-06 08:33:16'),
(104, 10, 420000, 1, '2022-09-12', '', 3, NULL, 1, 1, '2022-09-12 06:43:07', '2022-09-12 06:43:07'),
(105, 32, 520000, 1, '2022-09-12', '', 3, NULL, 1, 1, '2022-09-12 06:43:07', '2022-09-12 06:43:07'),
(106, 41, 160000, 1, '2022-09-12', '', 3, NULL, 1, 1, '2022-09-12 06:43:07', '2022-09-12 06:43:07'),
(107, 18, 440000, 5, '2022-09-12', '', 3, NULL, 1, 1, '2022-09-12 06:43:07', '2022-09-12 06:43:07'),
(108, 30, 320000, 5, '2022-09-12', '', 3, NULL, 1, 1, '2022-09-12 06:43:07', '2022-09-12 06:43:07'),
(109, 40, 420000, 5, '2022-09-12', '', 3, NULL, 1, 1, '2022-09-12 06:43:07', '2022-09-12 06:43:07'),
(110, 8, 340000, 5, '2022-09-12', '', 3, NULL, 1, 1, '2022-09-12 06:43:07', '2022-09-12 06:43:07'),
(111, 35, 500000, 4, '2022-09-12', '', 3, NULL, 1, 1, '2022-09-12 06:43:07', '2022-09-12 06:43:07'),
(112, 38, 560000, 7, '2022-09-12', '', 3, NULL, 1, 1, '2022-09-12 06:43:07', '2022-09-12 06:43:07'),
(113, 9, 210000, 1, '2022-09-14', 'trả hàng căng tin', 3, NULL, 1, 1, '2022-09-14 00:53:12', '2022-09-14 00:53:12'),
(114, 17, 220000, 2, '2022-09-14', 'trả hàng căng tin', 3, NULL, 1, 1, '2022-09-14 00:53:12', '2022-09-14 00:53:12'),
(115, 39, 210000, 2, '2022-09-14', 'trả hàng căng tin', 3, NULL, 1, 1, '2022-09-14 00:53:12', '2022-09-14 00:53:12'),
(116, 31, 260000, 1, '2022-09-14', 'trả hàng căng tin', 3, NULL, 1, 1, '2022-09-14 00:53:12', '2022-09-14 00:53:12'),
(117, 29, 210000, 1, '2022-09-14', 'trả hàng căng tin', 3, NULL, 1, 1, '2022-09-14 00:53:12', '2022-09-14 00:53:12'),
(118, 21, 230000, 2, '2022-09-14', 'trả hàng căng tin', 3, NULL, 1, 1, '2022-09-14 00:53:12', '2022-09-14 00:53:12'),
(119, 21, 263000, 2, '2022-09-14', '', 3, NULL, 3, 1, '2022-09-14 00:58:04', '2022-09-14 00:58:04'),
(120, 9, 263000, 1, '2022-09-14', 'trả hàng', 3, NULL, 3, 1, '2022-09-14 00:58:04', '2022-09-14 00:58:04'),
(121, 39, 248000, 2, '2022-09-14', 'trả hàng', 3, NULL, 3, 1, '2022-09-14 00:58:04', '2022-09-14 00:58:04'),
(122, 17, 240000, 2, '2022-09-14', 'trả hàng', 3, NULL, 3, 1, '2022-09-14 00:58:04', '2022-09-14 00:58:04'),
(123, 31, 297000, 1, '2022-09-14', 'trả hàng', 3, NULL, 3, 1, '2022-09-14 00:58:04', '2022-09-14 00:58:04'),
(124, 29, 225000, 1, '2022-09-14', 'trả hàng', 3, NULL, 3, 1, '2022-09-14 00:58:04', '2022-09-14 00:58:04'),
(125, 47, 193350, 2, '2022-09-14', '', 3, NULL, 5, 1, '2022-09-14 01:24:47', '2022-09-14 01:24:47'),
(126, 48, 207225, 3, '2022-09-14', '', 3, NULL, 5, 1, '2022-09-14 01:24:47', '2022-09-14 01:24:47'),
(127, 51, 181800, 3, '2022-09-14', '', 3, NULL, 5, 1, '2022-09-14 01:24:47', '2022-09-14 01:24:47'),
(128, 66, 342750, 5, '2022-09-14', '', 3, NULL, 5, 1, '2022-09-14 01:43:51', '2022-09-14 01:43:51'),
(129, 47, 193350, 8, '2022-09-14', 'trả hàng> bàn giao Thu', 3, NULL, 5, 1, '2022-09-14 01:46:46', '2022-09-14 01:46:46'),
(130, 48, 207225, 2, '2022-09-14', 'trả hàng> bàn giao Thu', 3, NULL, 5, 1, '2022-09-14 01:46:46', '2022-09-14 01:46:46'),
(131, 51, 181800, 5, '2022-09-14', 'trả hàng> bàn giao Thu', 3, NULL, 5, 1, '2022-09-14 01:46:46', '2022-09-14 01:46:46'),
(132, 15, 440000, 3, '2022-09-19', '', 3, NULL, 1, 1, '2022-09-17 03:23:36', '2022-09-17 03:23:36'),
(133, 18, 440000, 5, '2022-09-19', '', 3, NULL, 1, 1, '2022-09-17 03:23:36', '2022-09-17 03:23:36'),
(134, 8, 340000, 3, '2022-09-19', '', 3, NULL, 1, 1, '2022-09-17 03:23:36', '2022-09-17 03:23:36'),
(135, 35, 500000, 5, '2022-09-19', '', 3, NULL, 1, 1, '2022-09-17 03:23:36', '2022-09-17 03:23:36'),
(136, 38, 560000, 1, '2022-09-19', '', 3, NULL, 1, 1, '2022-09-17 03:23:36', '2022-09-17 03:23:36'),
(137, 12, 430000, 1, '2022-09-19', '', 3, NULL, 1, 1, '2022-09-17 03:23:36', '2022-09-17 03:23:36'),
(138, 10, 420000, 2, '2022-09-19', '', 3, NULL, 1, 1, '2022-09-18 05:51:32', '2022-09-18 05:51:32'),
(139, 21, 230000, 1, '2022-09-26', '', 3, NULL, 1, 1, '2022-09-23 01:50:33', '2022-09-23 01:50:33'),
(140, 44, 440000, 2, '2022-09-26', '', 3, NULL, 1, 1, '2022-09-23 01:50:33', '2022-09-23 01:50:33'),
(141, 23, 440000, 4, '2022-09-26', '', 3, NULL, 1, 1, '2022-09-23 01:50:33', '2022-09-23 01:50:33'),
(142, 8, 340000, 4, '2022-09-26', '', 3, NULL, 1, 1, '2022-09-23 01:50:33', '2022-09-23 01:50:33'),
(143, 40, 420000, 1, '2022-09-26', '', 3, NULL, 1, 1, '2022-09-23 01:50:33', '2022-09-23 01:50:33'),
(144, 38, 560000, 2, '2022-09-26', '', 3, NULL, 1, 1, '2022-09-23 01:50:33', '2022-09-23 01:50:33'),
(145, 11, 215000, 1, '2022-09-26', '', 3, NULL, 1, 1, '2022-09-23 01:50:33', '2022-09-23 01:50:33'),
(146, 12, 430000, 1, '2022-09-26', '', 3, NULL, 1, 1, '2022-09-23 01:50:33', '2022-09-23 01:50:33'),
(147, 18, 440000, 12, '2022-09-26', '', 3, NULL, 1, 1, '2022-09-23 01:50:33', '2022-09-25 02:19:06'),
(150, 46, 405000, 5, '2022-09-24', 'thu hồi hàng (c thương)', 3, NULL, 3, 1, '2022-09-23 22:39:30', '2022-09-23 22:39:30'),
(151, 60, 37500, 2, '2022-09-24', 'thu hồi hàng (c thương)', 3, NULL, 3, 1, '2022-09-23 22:39:30', '2022-09-23 22:39:30'),
(152, 61, 47500, 10, '2022-09-24', 'thu hồi hàng (c thương)', 3, NULL, 3, 1, '2022-09-23 22:39:30', '2022-09-23 22:39:30'),
(153, 57, 35000, 24, '2022-09-24', 'thu hồi hàng (c thương)', 3, NULL, 3, 1, '2022-09-23 22:39:30', '2022-09-23 22:39:30'),
(154, 59, 44500, 3, '2022-09-24', 'thu hồi hàng (c thương)', 3, NULL, 3, 1, '2022-09-23 22:39:30', '2022-09-23 22:39:30'),
(155, 57, 35000, 3, '2022-09-24', '', 3, NULL, 3, 1, '2022-09-23 22:40:09', '2022-09-23 22:40:09'),
(156, 59, 44500, 1, '2022-09-24', 'kiểm hàng bị nhầm, thực tế hộp này k tồn tại', 3, NULL, 3, 1, '2022-09-23 22:40:09', '2022-09-23 22:40:09'),
(157, 56, 27000, 14, '2022-09-24', 'thu hồi hàng (c thương)', 3, NULL, 3, 1, '2022-09-23 22:40:46', '2022-09-23 22:40:46'),
(158, 51, 180000, 5, '2022-09-24', 'trả hãng', 3, NULL, 3, 1, '2022-09-23 22:42:09', '2022-09-23 22:42:09'),
(159, 47, 195000, 8, '2022-09-24', 'trả hãng', 3, NULL, 3, 1, '2022-09-23 22:42:09', '2022-09-23 22:42:09'),
(160, 48, 210000, 2, '2022-09-24', 'trả hãng', 3, NULL, 3, 1, '2022-09-23 22:42:09', '2022-09-23 22:42:09'),
(161, 32, 520000, 2, '2022-09-26', '', 3, NULL, 1, 1, '2022-09-25 02:18:15', '2022-09-25 02:18:15'),
(162, 35, 500000, 2, '2022-09-26', '', 3, NULL, 1, 1, '2022-09-25 02:18:15', '2022-09-25 02:18:45'),
(163, 8, 416000, 4, '2022-09-27', '', 3, NULL, 2, 1, '2022-09-27 00:53:07', '2022-09-27 00:53:07'),
(164, 5, 200000, 6, '2022-09-27', '', 3, NULL, 2, 1, '2022-09-27 00:53:07', '2022-09-27 00:53:07'),
(165, 8, 340000, 7, '2022-10-03', '', 3, NULL, 1, 1, '2022-09-30 21:40:00', '2022-09-30 21:49:32'),
(166, 18, 440000, 3, '2022-10-03', '', 3, NULL, 1, 1, '2022-09-30 21:40:00', '2022-09-30 21:40:00'),
(167, 23, 440000, 2, '2022-10-03', '', 3, NULL, 1, 1, '2022-09-30 21:40:00', '2022-09-30 21:40:00'),
(168, 27, 420000, 1, '2022-10-03', '', 3, NULL, 1, 1, '2022-09-30 21:40:00', '2022-09-30 21:40:00'),
(169, 29, 210000, 1, '2022-10-03', '', 3, NULL, 1, 1, '2022-09-30 21:40:00', '2022-09-30 21:40:00'),
(170, 30, 320000, 4, '2022-10-03', '', 3, NULL, 1, 1, '2022-09-30 21:40:00', '2022-09-30 21:40:00'),
(171, 32, 520000, 3, '2022-10-03', '', 3, NULL, 1, 1, '2022-09-30 21:40:00', '2022-09-30 21:40:00'),
(172, 38, 560000, 3, '2022-10-03', '', 3, NULL, 1, 1, '2022-09-30 21:40:00', '2022-09-30 21:40:00'),
(173, 40, 420000, 2, '2022-10-03', '', 3, NULL, 1, 1, '2022-09-30 21:40:00', '2022-09-30 21:40:00'),
(174, 44, 440000, 2, '2022-10-03', '', 3, NULL, 1, 1, '2022-09-30 21:40:00', '2022-09-30 21:40:00'),
(175, 10, 420000, 1, '2022-10-10', '', 3, NULL, 1, 1, '2022-10-06 02:43:27', '2022-10-06 02:43:27'),
(176, 29, 210000, 3, '2022-10-10', '', 3, NULL, 1, 1, '2022-10-06 02:43:27', '2022-10-06 02:43:27'),
(177, 27, 420000, 2, '2022-10-10', '', 3, NULL, 1, 1, '2022-10-06 02:43:27', '2022-10-06 02:43:27'),
(178, 38, 560000, 3, '2022-10-10', '', 3, NULL, 1, 1, '2022-10-06 02:43:27', '2022-10-08 07:32:19'),
(179, 35, 500000, 3, '2022-10-10', '', 3, NULL, 1, 1, '2022-10-06 02:43:27', '2022-10-10 00:51:28'),
(181, 12, 430000, 3, '2022-10-10', '', 3, NULL, 1, 1, '2022-10-08 07:35:31', '2022-10-10 00:51:43'),
(182, 8, 340000, 3, '2022-10-10', '', 3, NULL, 1, 1, '2022-10-10 00:51:10', '2022-10-10 00:51:10'),
(183, 23, 440000, 4, '2022-10-10', '', 3, NULL, 1, 1, '2022-10-10 00:51:10', '2022-10-10 00:51:10'),
(184, 6, 416000, 7, '2022-10-03', '', 3, NULL, 2, 1, '2022-10-10 22:44:40', '2022-10-10 22:44:40'),
(185, 8, 340000, 2, '2022-10-17', '', 3, NULL, 1, 1, '2022-10-16 09:12:33', '2022-10-16 09:12:33'),
(186, 9, 210000, 2, '2022-10-17', '', 3, NULL, 1, 1, '2022-10-16 09:12:33', '2022-10-16 09:12:33'),
(187, 18, 440000, 6, '2022-10-17', '', 3, NULL, 1, 1, '2022-10-16 09:12:33', '2022-10-16 09:12:33'),
(188, 23, 440000, 7, '2022-10-17', '', 3, NULL, 1, 1, '2022-10-16 09:12:33', '2022-10-16 09:12:33'),
(189, 27, 420000, 1, '2022-10-17', '', 3, NULL, 1, 1, '2022-10-16 09:12:33', '2022-10-16 09:12:33'),
(190, 35, 500000, 3, '2022-10-17', '', 3, NULL, 1, 1, '2022-10-16 09:12:33', '2022-10-16 09:12:33'),
(191, 38, 560000, 3, '2022-10-17', '', 3, NULL, 1, 1, '2022-10-16 09:12:33', '2022-10-16 09:12:33'),
(192, 44, 440000, 1, '2022-10-17', '', 3, NULL, 1, 1, '2022-10-16 09:12:33', '2022-10-16 09:12:33'),
(193, 12, 430000, 1, '2022-10-17', '', 3, NULL, 1, 1, '2022-10-16 09:12:33', '2022-10-16 09:12:33'),
(194, 40, 420000, 5, '2022-10-17', 'trả lại hàng do bán chậm', 3, NULL, 1, 1, '2022-10-17 01:23:07', '2022-10-17 01:23:07'),
(195, 65, 418400, 5, '2022-10-21', 'huỷ do công ty k còn hàng', 3, NULL, 4, 1, '2022-10-21 01:43:48', '2022-10-21 01:43:48'),
(196, 65, 392250, 5, '2022-10-21', 'huỷ do công ty không có hàng', 3, NULL, 5, 1, '2022-10-21 01:44:13', '2022-10-21 01:44:13'),
(197, 8, 416000, 5, '2022-10-21', '', 3, NULL, 2, 1, '2022-10-21 02:34:33', '2022-10-21 02:34:33'),
(198, 25, 450000, 5, '2022-10-22', '', 3, NULL, 4, 1, '2022-10-22 05:54:14', '2022-10-22 05:54:14'),
(199, 18, 440000, 9, '2022-10-24', '', 3, NULL, 1, 1, '2022-10-23 06:23:44', '2022-10-23 06:23:44'),
(200, 23, 440000, 6, '2022-10-24', '', 3, NULL, 1, 1, '2022-10-23 06:23:44', '2022-10-23 06:23:44'),
(201, 26, 210000, 3, '2022-10-24', '', 3, NULL, 1, 1, '2022-10-23 06:23:44', '2022-10-23 06:23:44'),
(202, 29, 210000, 2, '2022-10-24', '', 3, NULL, 1, 1, '2022-10-23 06:23:44', '2022-10-23 06:23:44'),
(203, 30, 320000, 1, '2022-10-24', '', 3, NULL, 1, 1, '2022-10-23 06:23:44', '2022-10-23 06:23:44'),
(204, 35, 500000, 1, '2022-10-24', '', 3, NULL, 1, 1, '2022-10-23 06:23:44', '2022-10-23 06:23:44'),
(205, 38, 560000, 2, '2022-10-24', '', 3, NULL, 1, 1, '2022-10-23 06:23:44', '2022-10-23 06:23:44'),
(206, 12, 430000, 2, '2022-10-24', '', 3, NULL, 1, 1, '2022-10-23 06:23:44', '2022-10-23 06:23:44'),
(207, 8, 340000, 7, '2022-10-24', '', 3, NULL, 1, 1, '2022-10-23 06:39:16', '2022-10-23 06:39:16'),
(208, 18, 440000, 12, '2022-10-26', '', 3, NULL, 1, 1, '2022-10-25 18:22:13', '2022-10-25 18:22:13'),
(209, 66, 365600, 5, '2022-10-27', '', 3, NULL, 4, 1, '2022-10-29 23:09:05', '2022-10-29 23:09:05'),
(210, 8, 400000, 5, '2022-10-27', '', 3, NULL, 4, 1, '2022-10-29 23:09:05', '2022-10-29 23:09:05'),
(211, 7, 200000, 5, '2022-10-27', '', 3, NULL, 4, 1, '2022-10-29 23:09:05', '2022-10-29 23:09:05'),
(212, 8, 340000, 2, '2022-10-31', '', 3, NULL, 1, 1, '2022-10-30 03:42:35', '2022-10-30 03:42:35'),
(213, 23, 440000, 4, '2022-10-31', '', 3, NULL, 1, 1, '2022-10-30 03:42:35', '2022-10-30 03:42:35'),
(214, 27, 420000, 8, '2022-10-31', '', 3, NULL, 1, 1, '2022-10-30 03:42:35', '2022-10-30 03:42:35'),
(215, 35, 500000, 7, '2022-10-31', '', 3, NULL, 1, 1, '2022-10-30 03:42:35', '2022-10-30 03:42:35'),
(216, 38, 560000, 2, '2022-10-31', '', 3, NULL, 1, 1, '2022-10-30 03:42:35', '2022-10-30 03:42:35'),
(217, 40, 420000, 1, '2022-10-31', '', 3, NULL, 1, 1, '2022-10-30 03:42:35', '2022-10-30 03:42:35'),
(218, 12, 430000, 2, '2022-10-31', '', 3, NULL, 1, 1, '2022-10-30 03:42:35', '2022-10-30 03:42:35'),
(219, 98, 10400, 48, '2022-11-01', '', 3, NULL, 1, 1, '2022-10-31 23:11:08', '2022-10-31 23:11:08'),
(220, 7, 200000, 5, '2022-11-03', '', 3, NULL, 2, 1, '2022-11-04 19:54:16', '2022-11-04 19:54:16'),
(221, 8, 416000, 5, '2022-11-03', '', 3, NULL, 2, 1, '2022-11-04 19:54:16', '2022-11-04 19:54:16'),
(222, 8, 340000, 10, '2022-11-07', '', 3, NULL, 1, 1, '2022-11-06 08:55:21', '2022-11-06 08:55:21'),
(223, 18, 440000, 5, '2022-11-07', '', 3, NULL, 1, 1, '2022-11-06 08:55:21', '2022-11-06 08:55:21'),
(224, 23, 440000, 6, '2022-11-07', '', 3, NULL, 1, 1, '2022-11-06 08:55:21', '2022-11-06 08:55:21'),
(225, 27, 420000, 2, '2022-11-07', '', 3, NULL, 1, 1, '2022-11-06 08:55:21', '2022-11-06 08:55:21'),
(226, 30, 320000, 1, '2022-11-07', '', 3, NULL, 1, 1, '2022-11-06 08:55:21', '2022-11-06 08:55:21'),
(227, 35, 500000, 1, '2022-11-07', '', 3, NULL, 1, 1, '2022-11-06 08:55:21', '2022-11-06 08:55:21'),
(228, 38, 560000, 1, '2022-11-07', '', 3, NULL, 1, 1, '2022-11-06 08:55:21', '2022-11-06 08:55:21'),
(229, 40, 420000, 1, '2022-11-07', '', 3, NULL, 1, 1, '2022-11-06 08:55:21', '2022-11-06 08:55:21'),
(230, 8, 340000, 5, '2022-11-14', '', 3, NULL, 1, 1, '2022-11-13 08:52:21', '2022-11-13 08:52:21'),
(231, 18, 440000, 9, '2022-11-14', '', 3, NULL, 1, 1, '2022-11-13 08:52:21', '2022-11-13 08:52:21'),
(232, 27, 420000, 4, '2022-11-14', '', 3, NULL, 1, 1, '2022-11-13 08:52:21', '2022-11-13 08:52:21'),
(233, 30, 320000, 4, '2022-11-14', '', 3, NULL, 1, 1, '2022-11-13 08:52:21', '2022-11-13 08:52:21'),
(234, 35, 500000, 10, '2022-11-14', '', 3, NULL, 1, 1, '2022-11-13 08:52:21', '2022-11-13 08:52:21'),
(235, 38, 560000, 1, '2022-11-14', '', 3, NULL, 1, 1, '2022-11-13 08:52:21', '2022-11-13 08:52:21'),
(236, 41, 160000, 2, '2022-11-14', '', 3, NULL, 1, 1, '2022-11-13 08:52:21', '2022-11-13 08:52:21'),
(237, 40, 420000, 1, '2022-11-14', '', 3, NULL, 1, 1, '2022-11-13 08:52:21', '2022-11-13 08:52:21'),
(238, 22, 220000, 1, '2022-11-14', '', 3, NULL, 1, 1, '2022-11-13 08:52:21', '2022-11-13 08:52:21'),
(239, 14, 220000, 1, '2022-11-14', '', 3, NULL, 1, 1, '2022-11-13 08:52:21', '2022-11-13 08:52:21'),
(240, 12, 430000, 2, '2022-11-14', '', 3, NULL, 1, 1, '2022-11-13 08:52:21', '2022-11-13 08:52:21'),
(241, 98, 10400, 48, '2022-11-14', '', 3, NULL, 1, 1, '2022-11-13 08:52:21', '2022-11-13 08:52:21'),
(242, 8, 340000, 2, '2022-11-21', '', 3, NULL, 1, 1, '2022-11-20 10:01:22', '2022-11-20 10:01:22'),
(243, 12, 430000, 3, '2022-11-21', '', 3, NULL, 1, 1, '2022-11-20 10:01:22', '2022-11-20 10:01:22'),
(244, 18, 440000, 5, '2022-11-21', '', 3, NULL, 1, 1, '2022-11-20 10:01:22', '2022-11-20 10:01:22'),
(245, 23, 440000, 2, '2022-11-21', '', 3, NULL, 1, 1, '2022-11-20 10:01:22', '2022-11-20 10:01:22'),
(246, 29, 210000, 2, '2022-11-21', '', 3, NULL, 1, 1, '2022-11-20 10:01:22', '2022-11-20 10:01:22'),
(247, 35, 500000, 4, '2022-11-21', '', 3, NULL, 1, 1, '2022-11-20 10:01:22', '2022-11-20 10:01:22'),
(248, 31, 260000, 2, '2022-11-21', '', 3, NULL, 1, 1, '2022-11-20 10:01:22', '2022-11-20 10:01:22'),
(249, 43, 220000, 1, '2022-11-21', '', 3, NULL, 1, 1, '2022-11-20 10:01:22', '2022-11-20 10:01:22'),
(250, 29, 210000, 2, '2022-11-22', 'trả hàng do xuất nhầm hàng tặng', 3, NULL, 1, 1, '2022-11-22 07:25:17', '2022-11-22 07:25:17'),
(251, 8, 340000, 6, '2022-11-28', '', 3, NULL, 1, 1, '2022-11-27 07:49:42', '2022-11-27 07:49:42'),
(252, 18, 440000, 3, '2022-11-28', '', 3, NULL, 1, 1, '2022-11-27 07:49:42', '2022-11-27 07:49:42'),
(253, 23, 440000, 5, '2022-11-28', '', 3, NULL, 1, 1, '2022-11-27 07:49:42', '2022-11-27 07:49:42'),
(254, 35, 500000, 2, '2022-11-28', '', 3, NULL, 1, 1, '2022-11-27 07:49:42', '2022-11-27 07:49:42'),
(255, 40, 420000, 2, '2022-11-28', '', 3, NULL, 1, 1, '2022-11-27 07:49:42', '2022-11-27 07:50:43'),
(256, 72, 222000, 5, '2022-11-25', '', 3, NULL, 4, 1, '2022-11-27 08:04:48', '2022-11-27 08:04:48'),
(257, 73, 211500, 5, '2022-11-25', '', 3, NULL, 4, 1, '2022-11-27 08:04:48', '2022-11-27 08:04:48'),
(258, 74, 330000, 5, '2022-11-25', '', 3, NULL, 4, 1, '2022-11-27 08:04:48', '2022-11-27 08:04:48'),
(259, 10, 560000, 3, '2022-11-25', '', 3, NULL, 4, 1, '2022-11-27 08:04:48', '2022-11-27 08:04:48'),
(260, 80, 197400, 5, '2022-11-25', '', 3, NULL, 8, 1, '2022-11-27 08:05:47', '2022-11-27 08:05:47'),
(261, 74, 330000, 5, '2022-11-25', '', 3, NULL, 8, 1, '2022-11-27 08:05:47', '2022-11-27 08:05:47'),
(262, 90, 154000, 2, '2022-11-25', '', 3, NULL, 8, 1, '2022-11-27 08:05:47', '2022-11-27 08:05:47'),
(263, 91, 126000, 1, '2022-11-25', '', 3, NULL, 8, 1, '2022-11-27 08:05:47', '2022-11-27 08:05:47'),
(264, 89, 84000, 2, '2022-11-25', '', 3, NULL, 8, 1, '2022-11-27 08:05:47', '2022-11-27 08:05:47'),
(265, 78, 207200, 5, '2022-11-25', '', 3, NULL, 8, 1, '2022-11-27 08:05:47', '2022-11-27 08:05:47'),
(266, 8, 340000, 9, '2022-12-05', '', 3, NULL, 1, 1, '2022-12-03 06:55:57', '2022-12-03 06:55:57'),
(267, 18, 440000, 4, '2022-12-05', '', 3, NULL, 1, 1, '2022-12-03 06:55:57', '2022-12-03 06:55:57'),
(268, 23, 440000, 1, '2022-12-05', '', 3, NULL, 1, 1, '2022-12-03 06:55:57', '2022-12-03 06:55:57'),
(269, 35, 500000, 3, '2022-12-05', '', 3, NULL, 1, 1, '2022-12-03 06:55:57', '2022-12-03 06:55:57'),
(270, 38, 560000, 1, '2022-12-05', '', 3, NULL, 1, 1, '2022-12-03 06:55:57', '2022-12-03 06:55:57'),
(271, 12, 430000, 2, '2022-12-05', '', 3, NULL, 1, 1, '2022-12-03 06:55:57', '2022-12-03 06:55:57'),
(272, 8, 340000, 3, '2022-12-08', '', 3, NULL, 1, 1, '2022-12-07 06:57:12', '2022-12-07 06:57:12'),
(273, 15, 440000, 3, '2022-12-08', '', 3, NULL, 1, 1, '2022-12-07 06:57:12', '2022-12-07 06:57:12'),
(274, 10, 420000, 2, '2022-12-08', '', 3, NULL, 1, 1, '2022-12-07 06:57:12', '2022-12-07 06:57:12'),
(275, 18, 440000, 8, '2022-12-08', '', 3, NULL, 1, 1, '2022-12-07 06:57:12', '2022-12-07 06:57:12'),
(276, 23, 440000, 8, '2022-12-08', '', 3, NULL, 1, 1, '2022-12-07 06:57:12', '2022-12-07 06:57:12'),
(277, 27, 420000, 6, '2022-12-08', '', 3, NULL, 1, 1, '2022-12-07 06:57:12', '2022-12-07 06:57:12'),
(278, 30, 320000, 6, '2022-12-08', '', 3, NULL, 1, 1, '2022-12-07 06:57:12', '2022-12-07 06:57:12'),
(279, 32, 520000, 5, '2022-12-08', 'trả hàng ', 3, NULL, 1, 1, '2022-12-07 06:57:12', '2022-12-07 06:57:12'),
(280, 32, 520000, 2, '2022-12-08', '', 3, NULL, 1, 1, '2022-12-07 06:57:12', '2022-12-07 06:57:12'),
(281, 35, 500000, 9, '2022-12-08', '', 3, NULL, 1, 1, '2022-12-07 06:57:12', '2022-12-07 06:57:12'),
(282, 38, 560000, 8, '2022-12-08', '', 3, NULL, 1, 1, '2022-12-07 06:57:12', '2022-12-07 06:57:12'),
(283, 44, 440000, 6, '2022-12-08', '', 3, NULL, 1, 1, '2022-12-07 06:57:12', '2022-12-07 06:57:12'),
(284, 20, 540000, 2, '2022-12-08', 'trả hàng', 3, NULL, 1, 1, '2022-12-07 06:57:12', '2022-12-07 06:57:12'),
(285, 98, 10400, 48, '2022-12-08', '', 3, NULL, 1, 1, '2022-12-07 06:57:12', '2022-12-07 06:57:41'),
(286, 9, 210000, 2, '2022-12-08', 'trả hàng', 3, NULL, 1, 1, '2022-12-07 07:01:13', '2022-12-07 07:01:13'),
(287, 29, 210000, 6, '2022-12-08', '', 3, NULL, 1, 1, '2022-12-07 07:01:13', '2022-12-07 07:01:13'),
(288, 12, 430000, 4, '2022-12-08', '', 3, NULL, 1, 1, '2022-12-07 07:01:13', '2022-12-07 07:01:13'),
(289, 7, 170000, 3, '2022-12-08', '', 3, NULL, 1, 1, '2022-12-07 07:01:13', '2022-12-07 07:01:13'),
(290, 4, 250000, 3, '2022-12-08', 'trả hàng', 3, NULL, 1, 1, '2022-12-07 08:15:13', '2022-12-07 08:15:13'),
(291, 100, 23000, 30, '2022-12-09', '', 3, NULL, 1, 1, '2022-12-09 08:29:31', '2022-12-09 08:29:31'),
(292, 101, 23000, 20, '2022-12-09', '', 3, NULL, 1, 1, '2022-12-09 08:29:31', '2022-12-09 08:29:31'),
(293, 8, 340000, 12, '2022-12-13', '', 3, NULL, 1, 1, '2022-12-13 09:00:18', '2022-12-13 09:00:18'),
(294, 18, 440000, 12, '2022-12-13', '', 3, NULL, 1, 1, '2022-12-13 09:00:18', '2022-12-13 09:00:18'),
(295, 91, 126000, 1, '2022-12-20', '', 3, NULL, 8, 1, '2022-12-20 07:34:36', '2022-12-20 07:34:36'),
(296, 95, 101500, 4, '2022-12-20', '', 3, NULL, 8, 1, '2022-12-20 07:34:36', '2022-12-20 07:34:36'),
(297, 8, 340000, 12, '2022-12-21', '', 3, NULL, 1, 1, '2022-12-21 02:35:41', '2022-12-21 02:35:41'),
(298, 18, 440000, 12, '2022-12-26', '', 3, NULL, 1, 1, '2022-12-26 07:18:24', '2022-12-26 07:22:40'),
(299, 8, 340000, 12, '2022-12-26', '', 3, NULL, 1, 1, '2022-12-26 07:18:58', '2022-12-26 07:18:58'),
(300, 15, 440000, 6, '2022-12-28', '', 3, NULL, 1, 1, '2022-12-30 23:17:09', '2022-12-30 23:17:09'),
(301, 18, 440000, 12, '2023-01-03', '', 3, NULL, 1, 1, '2022-12-30 23:22:26', '2022-12-30 23:22:26'),
(302, 26, 210000, 5, '2023-01-03', '', 3, NULL, 1, 1, '2022-12-31 17:33:19', '2023-01-01 02:00:49'),
(303, 8, 340000, 8, '2023-01-09', '', 3, NULL, 1, 1, '2023-01-09 05:25:18', '2023-01-09 05:25:18'),
(304, 18, 440000, 5, '2023-01-09', '', 3, NULL, 1, 1, '2023-01-09 05:25:18', '2023-01-09 05:25:18'),
(305, 23, 440000, 6, '2023-01-09', '', 3, NULL, 1, 1, '2023-01-09 05:25:18', '2023-01-09 05:25:18'),
(306, 27, 420000, 1, '2023-01-09', '', 3, NULL, 1, 1, '2023-01-09 05:25:18', '2023-01-09 05:25:18'),
(307, 35, 500000, 7, '2023-01-09', '', 3, NULL, 1, 1, '2023-01-09 05:25:18', '2023-01-09 05:25:18'),
(308, 38, 560000, 2, '2023-01-09', '', 3, NULL, 1, 1, '2023-01-09 05:25:18', '2023-01-09 05:25:18'),
(309, 43, 220000, 2, '2023-01-09', '', 3, NULL, 1, 1, '2023-01-09 05:25:18', '2023-01-09 05:25:18'),
(310, 22, 220000, 1, '2023-01-09', '', 3, NULL, 1, 1, '2023-01-09 05:25:18', '2023-01-09 05:25:18'),
(311, 43, 220000, 5, '2023-01-09', '', 3, NULL, 1, 1, '2023-01-09 05:28:57', '2023-01-09 05:28:57'),
(312, 89, 84000, 3, '2023-01-13', '', 3, NULL, 8, 1, '2023-01-12 19:58:05', '2023-01-12 19:58:05'),
(313, 8, 340000, 12, '2023-01-16', '', 3, NULL, 1, 1, '2023-01-15 07:27:44', '2023-01-15 07:27:44'),
(314, 18, 440000, 7, '2023-01-16', '', 3, NULL, 1, 1, '2023-01-15 07:27:44', '2023-01-15 07:27:44'),
(315, 23, 440000, 5, '2023-01-16', '', 3, NULL, 1, 1, '2023-01-15 07:27:44', '2023-01-15 07:27:44'),
(316, 35, 500000, 6, '2023-01-16', '', 3, NULL, 1, 1, '2023-01-15 07:27:44', '2023-01-15 07:27:44'),
(317, 38, 560000, 3, '2023-01-16', '', 3, NULL, 1, 1, '2023-01-15 07:27:44', '2023-01-15 07:27:44'),
(318, 41, 160000, 1, '2023-01-16', '', 3, NULL, 1, 1, '2023-01-15 07:27:44', '2023-01-15 07:27:44'),
(319, 20, 560000, 1, '2023-01-16', '', 3, NULL, 1, 1, '2023-01-15 07:27:44', '2023-01-15 07:27:44'),
(320, 43, 220000, 5, '2023-01-16', '', 3, NULL, 1, 1, '2023-01-15 07:34:50', '2023-01-15 07:34:50'),
(321, 17, 220000, 5, '2023-01-16', '', 3, NULL, 1, 1, '2023-01-15 07:34:50', '2023-01-15 07:34:50'),
(322, 27, 420000, 4, '2023-01-16', '', 3, NULL, 1, 1, '2023-01-15 07:34:50', '2023-01-15 07:34:50'),
(323, 8, 400000, 5, '2023-01-15', '', 3, NULL, 4, 1, '2023-01-15 07:44:53', '2023-01-15 07:44:53'),
(324, 5, 200000, 2, '2023-01-15', '', 3, NULL, 4, 1, '2023-01-15 07:44:53', '2023-01-15 07:44:53'),
(325, 29, 210000, 10, '2023-01-16', '', 3, NULL, 1, 1, '2023-01-16 09:44:46', '2023-01-16 09:44:46'),
(326, 15, 440000, 2, '2023-01-19', '', 3, NULL, 1, 1, '2023-01-19 04:55:08', '2023-01-19 04:55:08'),
(327, 40, 420000, 2, '2023-01-19', '', 3, NULL, 1, 1, '2023-01-19 04:55:08', '2023-01-19 04:55:08'),
(328, 37, 280000, 2, '2023-01-19', '', 3, NULL, 1, 1, '2023-01-19 04:55:08', '2023-01-19 04:55:08'),
(329, 41, 160000, 5, '2023-01-19', '', 3, NULL, 1, 1, '2023-01-19 04:55:08', '2023-01-19 04:55:08'),
(330, 4, 340000, 4, '2023-01-30', '', 3, NULL, 1, 1, '2023-01-29 20:39:32', '2023-01-29 20:39:32'),
(331, 18, 440000, 17, '2023-01-30', '', 3, NULL, 1, 1, '2023-01-29 20:39:32', '2023-01-29 20:39:32'),
(332, 29, 210000, 2, '2023-01-30', '', 3, NULL, 1, 1, '2023-01-29 20:39:32', '2023-01-29 20:39:32'),
(333, 14, 220000, 2, '2023-01-30', '', 3, NULL, 1, 1, '2023-01-29 20:39:32', '2023-01-29 20:39:32'),
(334, 20, 560000, 1, '2023-01-30', '', 3, NULL, 1, 1, '2023-01-29 20:39:32', '2023-01-29 20:39:32'),
(335, 8, 340000, 12, '2023-02-13', '', 3, NULL, 1, 1, '2023-02-12 21:03:14', '2023-02-12 21:03:14'),
(336, 18, 440000, 12, '2023-02-13', '', 3, NULL, 1, 1, '2023-02-12 21:03:14', '2023-02-12 21:03:14'),
(337, 31, 260000, 1, '2023-02-13', '', 3, NULL, 1, 1, '2023-02-12 21:03:14', '2023-02-12 21:03:14'),
(338, 6, 340000, 2, '2023-02-20', '', 3, NULL, 1, 1, '2023-02-19 19:56:23', '2023-02-19 19:56:23'),
(339, 18, 440000, 3, '2023-02-20', '', 3, NULL, 1, 1, '2023-02-19 19:56:23', '2023-02-19 19:56:23'),
(340, 31, 260000, 2, '2023-02-20', '', 3, NULL, 1, 1, '2023-02-19 19:56:23', '2023-02-19 19:56:23'),
(341, 7, 170000, 3, '2023-02-20', '', 3, NULL, 1, 1, '2023-02-19 19:56:23', '2023-02-19 19:56:23'),
(342, 103, 7200, 48, '2023-02-20', '', 3, NULL, 1, 1, '2023-02-19 19:56:23', '2023-02-19 19:56:23'),
(343, 103, 7200, 48, '2023-02-21', '', 3, NULL, 1, 1, '2023-02-20 20:30:59', '2023-02-20 20:30:59'),
(344, 4, 340000, 2, '2023-02-21', '', 3, NULL, 1, 1, '2023-02-20 20:41:57', '2023-02-20 20:41:57'),
(345, 102, 200000, 3, '2023-02-22', 'hãng quên k giao hàng', 3, NULL, 1, 1, '2023-02-22 07:49:59', '2023-02-22 07:49:59'),
(346, 11, 215000, 2, '2023-02-28', '', 3, NULL, 1, 1, '2023-02-27 07:14:55', '2023-02-27 07:14:55'),
(348, 44, 440000, 3, '2023-02-28', '', 3, NULL, 1, 1, '2023-02-27 07:14:55', '2023-02-27 07:14:55'),
(349, 18, 440000, 5, '2023-02-28', '', 3, NULL, 1, 1, '2023-02-27 07:14:55', '2023-02-27 07:14:55'),
(350, 7, 170000, 2, '2023-02-28', '', 3, NULL, 1, 1, '2023-02-27 07:14:55', '2023-02-27 07:14:55'),
(351, 98, 10400, 48, '2023-02-28', '', 3, NULL, 1, 1, '2023-02-27 07:14:55', '2023-02-27 07:14:55'),
(352, 8, 340000, 5, '2023-02-28', '', 3, NULL, 1, 1, '2023-02-27 11:02:39', '2023-02-27 11:02:39'),
(353, 8, 340000, 5, '2023-03-01', '', 3, NULL, 1, 1, '2023-02-28 09:51:15', '2023-02-28 09:51:15'),
(354, 8, 340000, 10, '2023-03-06', '', 3, NULL, 1, 1, '2023-03-06 01:46:43', '2023-03-06 01:47:36'),
(355, 18, 440000, 9, '2023-03-06', '', 3, NULL, 1, 1, '2023-03-06 01:46:43', '2023-03-06 01:48:22'),
(356, 35, 500000, 2, '2023-03-06', '', 3, NULL, 1, 1, '2023-03-06 01:46:43', '2023-03-06 01:46:43'),
(357, 38, 560000, 7, '2023-03-06', '', 3, NULL, 1, 1, '2023-03-06 01:46:43', '2023-03-06 01:46:43');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `table_name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `permissions`
--

INSERT INTO `permissions` (`id`, `key`, `table_name`, `created_at`, `updated_at`) VALUES
(1, 'browse_admin', NULL, '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(2, 'browse_bread', NULL, '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(3, 'browse_database', NULL, '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(4, 'browse_media', NULL, '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(5, 'browse_compass', NULL, '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(6, 'browse_menus', 'menus', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(7, 'read_menus', 'menus', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(8, 'edit_menus', 'menus', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(9, 'add_menus', 'menus', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(10, 'delete_menus', 'menus', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(11, 'browse_roles', 'roles', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(12, 'read_roles', 'roles', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(13, 'edit_roles', 'roles', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(14, 'add_roles', 'roles', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(15, 'delete_roles', 'roles', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(16, 'browse_users', 'users', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(17, 'read_users', 'users', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(18, 'edit_users', 'users', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(19, 'add_users', 'users', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(20, 'delete_users', 'users', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(21, 'browse_settings', 'settings', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(22, 'read_settings', 'settings', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(23, 'edit_settings', 'settings', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(24, 'add_settings', 'settings', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(25, 'delete_settings', 'settings', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(26, 'browse_categories', 'categories', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(27, 'read_categories', 'categories', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(28, 'edit_categories', 'categories', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(29, 'add_categories', 'categories', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(30, 'delete_categories', 'categories', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(31, 'browse_posts', 'posts', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(32, 'read_posts', 'posts', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(33, 'edit_posts', 'posts', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(34, 'add_posts', 'posts', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(35, 'delete_posts', 'posts', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(36, 'browse_pages', 'pages', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(37, 'read_pages', 'pages', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(38, 'edit_pages', 'pages', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(39, 'add_pages', 'pages', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(40, 'delete_pages', 'pages', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(41, 'browse_products', 'products', '2022-08-19 20:10:16', '2022-08-19 20:10:16'),
(42, 'read_products', 'products', '2022-08-19 20:10:16', '2022-08-19 20:10:16'),
(43, 'edit_products', 'products', '2022-08-19 20:10:16', '2022-08-19 20:10:16'),
(44, 'add_products', 'products', '2022-08-19 20:10:16', '2022-08-19 20:10:16'),
(45, 'delete_products', 'products', '2022-08-19 20:10:16', '2022-08-19 20:10:16'),
(81, 'browse_price', 'price', '2022-08-26 02:36:29', '2022-08-26 02:36:29'),
(82, 'read_price', 'price', '2022-08-26 02:36:29', '2022-08-26 02:36:29'),
(83, 'edit_price', 'price', '2022-08-26 02:36:29', '2022-08-26 02:36:29'),
(84, 'add_price', 'price', '2022-08-26 02:36:29', '2022-08-26 02:36:29'),
(85, 'delete_price', 'price', '2022-08-26 02:36:29', '2022-08-26 02:36:29'),
(91, 'browse_brands', 'brands', '2022-08-27 06:54:21', '2022-08-27 06:54:21'),
(92, 'read_brands', 'brands', '2022-08-27 06:54:21', '2022-08-27 06:54:21'),
(93, 'edit_brands', 'brands', '2022-08-27 06:54:21', '2022-08-27 06:54:21'),
(94, 'add_brands', 'brands', '2022-08-27 06:54:21', '2022-08-27 06:54:21'),
(95, 'delete_brands', 'brands', '2022-08-27 06:54:21', '2022-08-27 06:54:21'),
(96, 'browse_discount', 'discount', '2022-08-27 06:58:04', '2022-08-27 06:58:04'),
(97, 'read_discount', 'discount', '2022-08-27 06:58:04', '2022-08-27 06:58:04'),
(98, 'edit_discount', 'discount', '2022-08-27 06:58:04', '2022-08-27 06:58:04'),
(99, 'add_discount', 'discount', '2022-08-27 06:58:04', '2022-08-27 06:58:04'),
(100, 'delete_discount', 'discount', '2022-08-27 06:58:04', '2022-08-27 06:58:04'),
(101, 'browse_warehouse', 'warehouse', '2022-08-27 07:01:27', '2022-08-27 07:01:27'),
(102, 'read_warehouse', 'warehouse', '2022-08-27 07:01:27', '2022-08-27 07:01:27'),
(103, 'edit_warehouse', 'warehouse', '2022-08-27 07:01:27', '2022-08-27 07:01:27'),
(104, 'add_warehouse', 'warehouse', '2022-08-27 07:01:27', '2022-08-27 07:01:27'),
(105, 'delete_warehouse', 'warehouse', '2022-08-27 07:01:27', '2022-08-27 07:01:27'),
(106, 'browse_campain', 'campain', '2022-08-30 01:05:01', '2022-08-30 01:05:01'),
(107, 'read_campain', 'campain', '2022-08-30 01:05:01', '2022-08-30 01:05:01'),
(108, 'edit_campain', 'campain', '2022-08-30 01:05:01', '2022-08-30 01:05:01'),
(109, 'add_campain', 'campain', '2022-08-30 01:05:01', '2022-08-30 01:05:01'),
(110, 'delete_campain', 'campain', '2022-08-30 01:05:01', '2022-08-30 01:05:01');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `permission_role`
--

CREATE TABLE `permission_role` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `permission_role`
--

INSERT INTO `permission_role` (`permission_id`, `role_id`) VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(30, 1),
(31, 1),
(32, 1),
(33, 1),
(34, 1),
(35, 1),
(36, 1),
(37, 1),
(38, 1),
(39, 1),
(40, 1),
(41, 1),
(41, 2),
(42, 1),
(42, 2),
(43, 1),
(43, 2),
(44, 1),
(44, 2),
(45, 1),
(45, 2),
(81, 1),
(81, 2),
(82, 1),
(82, 2),
(83, 1),
(83, 2),
(84, 1),
(84, 2),
(85, 1),
(85, 2),
(91, 1),
(91, 2),
(92, 1),
(92, 2),
(93, 1),
(93, 2),
(94, 1),
(94, 2),
(95, 1),
(95, 2),
(96, 1),
(96, 2),
(97, 1),
(97, 2),
(98, 1),
(98, 2),
(99, 1),
(99, 2),
(100, 1),
(101, 1),
(101, 2),
(102, 1),
(102, 2),
(103, 1),
(103, 2),
(104, 1),
(104, 2),
(105, 1),
(105, 2),
(106, 1),
(107, 1),
(108, 1),
(109, 1),
(110, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `posts`
--

CREATE TABLE `posts` (
  `id` int(10) UNSIGNED NOT NULL,
  `author_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `seo_title` varchar(255) DEFAULT NULL,
  `excerpt` text DEFAULT NULL,
  `body` text NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
  `meta_description` text DEFAULT NULL,
  `meta_keywords` text DEFAULT NULL,
  `status` enum('PUBLISHED','DRAFT','PENDING') NOT NULL DEFAULT 'DRAFT',
  `featured` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `posts`
--

INSERT INTO `posts` (`id`, `author_id`, `category_id`, `title`, `seo_title`, `excerpt`, `body`, `image`, `slug`, `meta_description`, `meta_keywords`, `status`, `featured`, `created_at`, `updated_at`) VALUES
(1, 0, NULL, 'Lorem Ipsum Post', NULL, 'This is the excerpt for the Lorem Ipsum Post', '<p>This is the body of the lorem ipsum post</p>', 'posts/post1.jpg', 'lorem-ipsum-post', 'This is the meta description', 'keyword1, keyword2, keyword3', 'PUBLISHED', 0, '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(2, 0, NULL, 'My Sample Post', NULL, 'This is the excerpt for the sample Post', '<p>This is the body for the sample post, which includes the body.</p>\n                <h2>We can use all kinds of format!</h2>\n                <p>And include a bunch of other stuff.</p>', 'posts/post2.jpg', 'my-sample-post', 'Meta Description for sample post', 'keyword1, keyword2, keyword3', 'PUBLISHED', 0, '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(3, 0, NULL, 'Latest Post', NULL, 'This is the excerpt for the latest post', '<p>This is the body for the latest post</p>', 'posts/post3.jpg', 'latest-post', 'This is the meta description', 'keyword1, keyword2, keyword3', 'PUBLISHED', 0, '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(4, 0, NULL, 'Yarr Post', NULL, 'Reef sails nipperkin bring a spring upon her cable coffer jury mast spike marooned Pieces of Eight poop deck pillage. Clipper driver coxswain galleon hempen halter come about pressgang gangplank boatswain swing the lead. Nipperkin yard skysail swab lanyard Blimey bilge water ho quarter Buccaneer.', '<p>Swab deadlights Buccaneer fire ship square-rigged dance the hempen jig weigh anchor cackle fruit grog furl. Crack Jennys tea cup chase guns pressgang hearties spirits hogshead Gold Road six pounders fathom measured fer yer chains. Main sheet provost come about trysail barkadeer crimp scuttle mizzenmast brig plunder.</p>\n<p>Mizzen league keelhaul galleon tender cog chase Barbary Coast doubloon crack Jennys tea cup. Blow the man down lugsail fire ship pinnace cackle fruit line warp Admiral of the Black strike colors doubloon. Tackle Jack Ketch come about crimp rum draft scuppers run a shot across the bow haul wind maroon.</p>\n<p>Interloper heave down list driver pressgang holystone scuppers tackle scallywag bilged on her anchor. Jack Tar interloper draught grapple mizzenmast hulk knave cable transom hogshead. Gaff pillage to go on account grog aft chase guns piracy yardarm knave clap of thunder.</p>', 'posts/post4.jpg', 'yarr-post', 'this be a meta descript', 'keyword1, keyword2, keyword3', 'PUBLISHED', 0, '2022-08-19 20:05:03', '2022-08-19 20:05:03');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `prb_log_activity`
--

CREATE TABLE `prb_log_activity` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT 0,
  `name` varchar(250) DEFAULT NULL,
  `message` longtext DEFAULT NULL,
  `url` varchar(250) DEFAULT NULL,
  `method` varchar(250) DEFAULT NULL,
  `form_data` longtext DEFAULT NULL,
  `agent` varchar(250) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `price`
--

CREATE TABLE `price` (
  `id` int(10) UNSIGNED NOT NULL,
  `pro_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `im_export` varchar(255) NOT NULL DEFAULT 'nhap',
  `price` int(11) NOT NULL,
  `campain_id` int(10) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `price`
--

INSERT INTO `price` (`id`, `pro_id`, `warehouse_id`, `im_export`, `price`, `campain_id`, `created_at`, `updated_at`) VALUES
(2, 3, 1, 'nhap', 170000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(3, 4, 1, 'nhap', 340000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(4, 5, 1, 'nhap', 170000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(5, 6, 1, 'nhap', 340000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(6, 7, 1, 'nhap', 170000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(7, 8, 1, 'nhap', 340000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(8, 9, 1, 'nhap', 210000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(9, 10, 1, 'nhap', 420000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(10, 11, 1, 'nhap', 215000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(11, 12, 1, 'nhap', 430000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(12, 13, 1, 'nhap', 230000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(13, 14, 1, 'nhap', 220000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(14, 15, 1, 'nhap', 440000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(15, 16, 1, 'nhap', 230000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(16, 17, 1, 'nhap', 220000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(17, 18, 1, 'nhap', 440000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(18, 19, 1, 'nhap', 270000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(19, 20, 1, 'nhap', 560000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(20, 21, 1, 'nhap', 230000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(21, 22, 1, 'nhap', 220000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(22, 23, 1, 'nhap', 440000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(23, 24, 1, 'nhap', 210000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(24, 25, 1, 'nhap', 420000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(25, 26, 1, 'nhap', 210000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(26, 27, 1, 'nhap', 420000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(27, 28, 1, 'nhap', 230000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(28, 29, 1, 'nhap', 210000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(29, 30, 1, 'nhap', 320000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(30, 31, 1, 'nhap', 260000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(31, 32, 1, 'nhap', 520000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(32, 33, 1, 'nhap', 220000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(33, 34, 1, 'nhap', 250000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(34, 35, 1, 'nhap', 500000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(35, 36, 1, 'nhap', 220000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(36, 37, 1, 'nhap', 280000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(37, 38, 1, 'nhap', 560000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(38, 39, 1, 'nhap', 210000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(39, 40, 1, 'nhap', 420000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(40, 41, 1, 'nhap', 160000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(41, 42, 1, 'nhap', 220000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(42, 43, 1, 'nhap', 220000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(43, 44, 1, 'nhap', 440000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(44, 45, 1, 'nhap', 230000, 1, '2022-08-26 19:26:20', '2022-08-26 19:26:20'),
(45, 3, 1, 'xuat', 520000, 1, '2022-08-27 07:24:36', '2022-08-27 07:24:36'),
(46, 8, 1, 'xuat', 520000, 1, '2022-08-27 07:25:09', '2022-08-27 07:25:09'),
(47, 16, 3, 'nhap', 263000, 1, '2022-08-27 09:56:59', '2022-09-02 02:08:27'),
(48, 21, 3, 'nhap', 263000, 1, '2022-08-27 09:57:32', '2022-09-02 02:08:08'),
(49, 30, 3, 'nhap', 338000, 1, '2022-08-27 09:58:00', '2022-09-02 02:12:14'),
(50, 31, 3, 'nhap', 297000, 1, '2022-08-27 10:01:00', '2022-09-02 02:10:50'),
(51, 32, 3, 'nhap', 593000, 1, '2022-08-27 10:01:20', '2022-09-02 02:11:31'),
(52, 26, 3, 'nhap', 225000, 1, '2022-08-27 10:01:52', '2022-09-02 02:12:53'),
(53, 29, 3, 'nhap', 225000, 1, '2022-08-27 10:02:00', '2022-09-02 02:13:09'),
(54, 39, 3, 'nhap', 248000, 1, '2022-08-27 10:03:00', '2022-09-02 02:24:44'),
(60, 47, 3, 'nhap', 195000, 1, '2022-09-02 01:50:00', '2022-09-02 01:58:35'),
(61, 48, 3, 'nhap', 210000, 1, '2022-09-02 01:52:00', '2022-09-02 01:59:06'),
(62, 46, 3, 'nhap', 405000, 1, '2022-09-02 01:53:08', '2022-09-02 01:53:08'),
(63, 49, 2, 'nhap', 220000, 1, '2022-09-02 01:54:23', '2022-09-02 01:57:29'),
(64, 51, 3, 'nhap', 180000, 1, '2022-09-02 01:59:35', '2022-09-02 01:59:35'),
(65, 52, 3, 'nhap', 180000, 1, '2022-09-02 01:59:52', '2022-09-02 01:59:52'),
(66, 53, 2, 'nhap', 212000, 1, '2022-09-02 02:00:27', '2022-09-02 02:00:27'),
(67, 54, 3, 'nhap', 685000, 1, '2022-09-02 02:00:57', '2022-09-02 02:00:57'),
(68, 55, 3, 'nhap', 61000, 1, '2022-09-02 02:02:18', '2022-09-02 02:02:18'),
(69, 56, 3, 'nhap', 27000, 1, '2022-09-02 02:03:20', '2022-09-02 02:03:20'),
(70, 57, 3, 'nhap', 35000, 1, '2022-09-02 02:04:14', '2022-09-02 02:04:14'),
(71, 58, 3, 'nhap', 36500, 1, '2022-09-02 02:04:44', '2022-09-02 02:04:44'),
(72, 59, 3, 'nhap', 44500, 1, '2022-09-02 02:05:00', '2022-09-02 02:05:00'),
(73, 60, 3, 'nhap', 37500, 1, '2022-09-02 02:05:38', '2022-09-02 02:05:38'),
(74, 61, 3, 'nhap', 47500, 1, '2022-09-02 02:05:54', '2022-09-02 02:05:54'),
(75, 62, 3, 'nhap', 69000, 1, '2022-09-02 02:06:07', '2022-09-02 02:06:07'),
(76, 17, 3, 'nhap', 240000, 1, '2022-09-02 02:08:52', '2022-09-02 02:08:52'),
(77, 18, 3, 'nhap', 480000, 1, '2022-09-02 02:09:14', '2022-09-02 02:09:14'),
(78, 42, 3, 'nhap', 263000, 1, '2022-09-02 02:09:37', '2022-09-02 02:09:37'),
(79, 13, 2, 'nhap', 256000, 1, '2022-09-02 02:14:11', '2022-09-02 02:14:11'),
(80, 21, 2, 'nhap', 256000, 1, '2022-09-02 02:14:28', '2022-09-02 02:14:28'),
(81, 42, 2, 'nhap', 256000, 1, '2022-09-02 02:14:54', '2022-09-02 02:14:54'),
(82, 9, 3, 'nhap', 263000, 1, '2022-09-02 02:25:14', '2022-09-02 02:25:14'),
(83, 16, 2, 'nhap', 256000, 1, '2022-09-02 02:29:07', '2022-09-02 02:29:07'),
(84, 5, 2, 'nhap', 200000, 1, '2022-09-02 02:32:23', '2022-09-02 02:32:23'),
(85, 7, 2, 'nhap', 200000, 1, '2022-09-02 02:32:41', '2022-09-02 02:32:41'),
(86, 6, 2, 'nhap', 416000, 1, '2022-09-02 02:33:03', '2022-09-02 02:33:03'),
(87, 3, 2, 'nhap', 200000, 1, '2022-09-02 02:33:15', '2022-09-02 02:33:15'),
(88, 4, 2, 'nhap', 416000, 1, '2022-09-02 02:33:27', '2022-09-02 02:33:27'),
(89, 8, 2, 'nhap', 416000, 1, '2022-09-02 02:33:46', '2022-09-02 02:33:46'),
(90, 63, 2, 'nhap', 130000, 1, '2022-09-02 02:34:26', '2022-09-02 02:34:26'),
(91, 24, 2, 'nhap', 240000, 1, '2022-09-02 02:37:50', '2022-09-02 02:37:50'),
(92, 64, 2, 'nhap', 15000, 1, '2022-09-02 02:38:43', '2022-09-02 02:38:43'),
(93, 63, 1, 'nhap', 100000, 1, '2022-09-02 02:42:22', '2022-09-02 02:42:22'),
(94, 9, 1, 'xuat', 350000, 1, '2022-09-02 02:45:10', '2022-09-02 02:45:10'),
(95, 10, 1, 'xuat', 700000, 1, '2022-09-02 02:45:28', '2022-09-02 02:45:28'),
(96, 11, 1, 'xuat', 315000, 1, '2022-09-02 02:45:56', '2022-09-02 02:45:56'),
(97, 12, 1, 'xuat', 630000, 1, '2022-09-02 02:46:17', '2022-09-02 02:46:17'),
(98, 13, 1, 'xuat', 350000, 1, '2022-09-02 02:46:37', '2022-09-02 02:46:37'),
(99, 14, 1, 'xuat', 320000, 1, '2022-09-02 02:46:57', '2022-09-02 02:46:57'),
(100, 15, 1, 'xuat', 640000, 1, '2022-09-02 02:47:12', '2022-09-02 02:47:12'),
(101, 16, 1, 'xuat', 350000, 1, '2022-09-02 02:47:27', '2022-09-02 02:47:27'),
(102, 17, 1, 'xuat', 320000, 1, '2022-09-02 02:47:00', '2022-09-02 02:47:51'),
(103, 18, 1, 'xuat', 640000, 1, '2022-09-02 02:48:13', '2022-09-02 02:48:13'),
(104, 19, 1, 'xuat', 400000, 1, '2022-09-02 02:48:31', '2022-09-02 02:48:31'),
(105, 20, 1, 'xuat', 800000, 1, '2022-09-02 02:48:46', '2022-09-02 02:48:46'),
(106, 21, 1, 'xuat', 350000, 1, '2022-09-02 02:49:03', '2022-09-02 02:49:03'),
(107, 22, 1, 'xuat', 320000, 1, '2022-09-02 02:49:45', '2022-09-02 02:49:45'),
(108, 23, 1, 'xuat', 640000, 1, '2022-09-02 02:50:08', '2022-09-02 02:50:08'),
(109, 24, 1, 'xuat', 300000, 1, '2022-09-02 02:50:25', '2022-09-02 02:50:25'),
(110, 25, 1, 'xuat', 600000, 1, '2022-09-02 02:50:41', '2022-09-02 02:50:41'),
(111, 26, 1, 'xuat', 300000, 1, '2022-09-02 02:50:57', '2022-09-02 02:50:57'),
(112, 27, 1, 'xuat', 600000, 1, '2022-09-02 02:51:12', '2022-09-02 02:51:12'),
(113, 29, 1, 'xuat', 300000, 1, '2022-09-02 02:51:29', '2022-09-02 02:51:29'),
(114, 30, 1, 'xuat', 450000, 1, '2022-09-02 02:51:44', '2022-09-02 02:51:44'),
(115, 31, 1, 'xuat', 395000, 1, '2022-09-02 02:52:10', '2022-09-02 02:52:10'),
(116, 32, 1, 'xuat', 790000, 1, '2022-09-02 02:52:25', '2022-09-02 02:52:25'),
(117, 34, 1, 'xuat', 340000, 1, '2022-09-02 02:52:00', '2022-09-02 02:53:20'),
(118, 35, 1, 'xuat', 680000, 1, '2022-09-02 02:53:11', '2022-09-02 02:53:11'),
(119, 37, 1, 'xuat', 370000, 1, '2022-09-02 02:53:41', '2022-09-02 02:53:41'),
(120, 38, 1, 'xuat', 740000, 1, '2022-09-02 02:53:57', '2022-09-02 02:53:57'),
(121, 39, 1, 'xuat', 330000, 1, '2022-09-02 02:54:13', '2022-09-02 02:54:13'),
(122, 40, 1, 'xuat', 660000, 1, '2022-09-02 02:54:30', '2022-09-02 02:54:30'),
(123, 41, 1, 'xuat', 250000, 1, '2022-09-02 02:54:44', '2022-09-02 02:54:44'),
(124, 42, 1, 'xuat', 350000, 1, '2022-09-02 02:55:00', '2022-09-02 02:55:00'),
(125, 43, 1, 'xuat', 320000, 1, '2022-09-02 02:55:16', '2022-09-02 02:55:16'),
(126, 44, 1, 'xuat', 640000, 1, '2022-09-02 02:55:36', '2022-09-02 02:55:36'),
(127, 9, 3, 'xuat', 330000, 1, '2022-09-02 02:56:06', '2022-09-02 02:56:06'),
(128, 16, 3, 'xuat', 350000, 1, '2022-09-02 02:57:32', '2022-09-02 02:57:32'),
(129, 21, 3, 'xuat', 350000, 1, '2022-09-02 02:58:02', '2022-09-02 02:58:02'),
(130, 26, 3, 'xuat', 300000, 1, '2022-09-02 02:58:25', '2022-09-02 02:58:25'),
(131, 29, 3, 'xuat', 300000, 1, '2022-09-02 02:58:45', '2022-09-02 02:58:45'),
(132, 30, 3, 'xuat', 450000, 1, '2022-09-02 02:59:11', '2022-09-02 02:59:11'),
(133, 31, 3, 'xuat', 390000, 1, '2022-09-02 02:59:32', '2022-09-02 02:59:32'),
(134, 39, 3, 'xuat', 330000, 1, '2022-09-02 02:59:50', '2022-09-02 02:59:50'),
(135, 42, 3, 'xuat', 350000, 1, '2022-09-02 03:00:11', '2022-09-02 03:00:11'),
(136, 46, 3, 'xuat', 450000, 1, '2022-09-02 03:00:35', '2022-09-02 03:00:35'),
(137, 47, 3, 'xuat', 265000, 1, '2022-09-02 03:00:55', '2022-09-02 03:00:55'),
(138, 48, 3, 'xuat', 265000, 1, '2022-09-02 03:01:17', '2022-09-02 03:01:17'),
(139, 51, 3, 'xuat', 230000, 1, '2022-09-02 03:02:04', '2022-09-02 03:02:04'),
(140, 54, 3, 'xuat', 760000, 1, '2022-09-02 03:02:00', '2022-09-02 03:02:43'),
(141, 55, 3, 'xuat', 68000, 1, '2022-09-02 03:03:08', '2022-09-02 03:03:08'),
(142, 56, 3, 'xuat', 28000, 1, '2022-09-02 03:03:29', '2022-09-02 03:03:29'),
(143, 57, 3, 'xuat', 35000, 1, '2022-09-02 03:03:48', '2022-09-02 03:03:48'),
(144, 58, 3, 'xuat', 38000, 1, '2022-09-02 03:04:07', '2022-09-02 03:04:07'),
(145, 59, 3, 'xuat', 43000, 1, '2022-09-02 03:04:46', '2022-09-02 03:04:46'),
(146, 60, 3, 'xuat', 36000, 1, '2022-09-02 03:05:03', '2022-09-02 03:05:03'),
(147, 61, 3, 'xuat', 48000, 1, '2022-09-02 03:05:21', '2022-09-02 03:05:21'),
(148, 62, 3, 'xuat', 67000, 1, '2022-09-02 03:05:38', '2022-09-02 03:05:38'),
(149, 47, 5, 'nhap', 193350, 1, '2022-09-04 18:50:00', '2022-09-04 18:51:42'),
(150, 47, 5, 'xuat', 257800, 1, '2022-09-04 18:50:53', '2022-09-04 18:50:53'),
(151, 48, 5, 'nhap', 207225, 1, '2022-09-04 18:52:52', '2022-09-04 18:52:52'),
(152, 48, 5, 'xuat', 276300, 1, '2022-09-04 18:53:34', '2022-09-04 18:53:34'),
(153, 51, 5, 'nhap', 181800, 1, '2022-09-04 18:54:22', '2022-09-04 18:54:22'),
(154, 51, 5, 'xuat', 242400, 1, '2022-09-04 18:54:45', '2022-09-04 18:54:45'),
(155, 52, 5, 'nhap', 181800, 1, '2022-09-04 18:55:01', '2022-09-04 18:55:01'),
(156, 52, 5, 'xuat', 242400, 1, '2022-09-04 18:55:20', '2022-09-04 18:55:20'),
(157, 49, 5, 'nhap', 209250, 1, '2022-09-04 18:58:10', '2022-09-04 18:58:10'),
(158, 49, 5, 'xuat', 279000, 1, '2022-09-04 18:58:32', '2022-09-04 18:58:32'),
(159, 50, 5, 'nhap', 181875, 1, '2022-09-04 18:59:12', '2022-09-04 18:59:12'),
(160, 50, 5, 'xuat', 242500, 1, '2022-09-04 18:59:31', '2022-09-04 18:59:31'),
(161, 53, 5, 'nhap', 196875, 1, '2022-09-04 19:00:22', '2022-09-04 19:00:22'),
(162, 53, 5, 'xuat', 262500, 1, '2022-09-04 19:00:39', '2022-09-04 19:00:39'),
(163, 65, 5, 'nhap', 392250, 1, '2022-09-04 19:02:59', '2022-09-04 19:02:59'),
(164, 65, 5, 'xuat', 523000, 1, '2022-09-04 19:03:14', '2022-09-04 19:03:14'),
(165, 66, 5, 'nhap', 342750, 1, '2022-09-04 19:03:54', '2022-09-04 19:03:54'),
(166, 66, 5, 'xuat', 457000, 1, '2022-09-04 19:04:10', '2022-09-04 19:04:10'),
(167, 67, 5, 'nhap', 403125, 1, '2022-09-04 19:04:43', '2022-09-04 19:04:43'),
(168, 67, 5, 'xuat', 537500, 1, '2022-09-04 19:04:59', '2022-09-04 19:04:59'),
(169, 69, 6, 'nhap', 336660, 1, '2022-09-04 19:08:45', '2022-09-04 19:08:45'),
(170, 69, 6, 'xuat', 370000, 1, '2022-09-04 19:08:59', '2022-09-04 19:08:59'),
(171, 70, 6, 'nhap', 344100, 1, '2022-09-04 19:09:24', '2022-09-04 19:09:24'),
(172, 70, 6, 'xuat', 370000, 1, '2022-09-04 19:09:49', '2022-09-04 19:09:49'),
(173, 68, 6, 'nhap', 68820, 1, '2022-09-04 19:10:27', '2022-09-04 19:10:27'),
(174, 68, 6, 'xuat', 74000, 1, '2022-09-04 19:10:48', '2022-09-04 19:10:48'),
(175, 66, 4, 'nhap', 365600, 1, '2022-09-04 19:42:00', '2022-09-04 19:43:37'),
(176, 50, 4, 'nhap', 194000, 1, '2022-09-04 19:43:21', '2022-09-04 19:43:21'),
(177, 7, 4, 'nhap', 200000, 1, '2022-09-04 19:43:58', '2022-09-04 19:43:58'),
(178, 8, 4, 'nhap', 400000, 1, '2022-09-04 19:44:12', '2022-09-04 19:44:12'),
(179, 65, 4, 'nhap', 418400, 1, '2022-09-04 19:45:10', '2022-09-04 19:45:10'),
(180, 24, 4, 'nhap', 240000, 1, '2022-09-04 19:45:39', '2022-09-04 19:45:39'),
(181, 25, 4, 'nhap', 450000, 1, '2022-09-04 19:45:58', '2022-10-21 01:59:28'),
(182, 3, 4, 'nhap', 200000, 1, '2022-09-04 19:46:22', '2022-09-04 19:46:22'),
(183, 4, 4, 'nhap', 400000, 1, '2022-09-04 19:46:36', '2022-09-04 19:46:36'),
(184, 5, 4, 'nhap', 200000, 1, '2022-09-04 19:46:47', '2022-09-04 19:46:47'),
(185, 6, 4, 'nhap', 400000, 1, '2022-09-04 19:47:00', '2022-09-04 19:47:29'),
(186, 63, 4, 'nhap', 130000, 1, '2022-09-04 19:47:19', '2022-09-04 19:47:19'),
(187, 56, 7, 'nhap', 21600, 1, '2022-09-04 19:55:25', '2022-09-04 19:55:25'),
(188, 56, 7, 'xuat', 27000, 1, '2022-09-04 19:55:49', '2022-09-04 19:55:49'),
(189, 57, 7, 'nhap', 28000, 1, '2022-09-04 19:56:12', '2022-09-04 19:56:12'),
(190, 57, 7, 'xuat', 35000, 1, '2022-09-04 19:56:30', '2022-09-04 19:56:30'),
(191, 58, 7, 'nhap', 29200, 1, '2022-09-04 19:56:52', '2022-09-04 19:56:52'),
(192, 58, 7, 'xuat', 36500, 1, '2022-09-04 19:57:12', '2022-09-04 19:57:12'),
(193, 59, 7, 'nhap', 35600, 1, '2022-09-04 19:57:43', '2022-09-04 19:57:43'),
(194, 59, 7, 'xuat', 44500, 1, '2022-09-04 19:58:03', '2022-09-04 19:58:03'),
(195, 60, 7, 'nhap', 30000, 1, '2022-09-04 19:58:30', '2022-09-04 19:58:30'),
(196, 60, 7, 'xuat', 37500, 1, '2022-09-04 19:58:49', '2022-09-04 19:58:49'),
(197, 61, 7, 'nhap', 38000, 1, '2022-09-04 19:59:15', '2022-09-04 19:59:15'),
(198, 61, 7, 'xuat', 47500, 1, '2022-09-04 19:59:31', '2022-09-04 19:59:31'),
(199, 71, 1, 'nhap', 1000, 1, '2022-09-23 01:55:00', '2022-09-23 01:57:00'),
(200, 71, 1, 'xuat', 50000, 1, '2022-09-23 01:55:55', '2022-09-23 01:55:55'),
(201, 72, 4, 'nhap', 222000, 1, '2022-10-26 02:28:48', '2022-10-26 02:28:48'),
(202, 72, 4, 'xuat', 296000, 1, '2022-10-26 02:29:13', '2022-10-26 02:29:13'),
(203, 73, 4, 'nhap', 211500, 1, '2022-10-26 02:29:46', '2022-10-26 02:29:46'),
(204, 73, 4, 'xuat', 282000, 1, '2022-10-26 02:30:05', '2022-10-26 02:30:05'),
(205, 74, 4, 'nhap', 330000, 1, '2022-10-26 02:31:41', '2022-10-26 02:31:41'),
(206, 74, 4, 'xuat', 395000, 1, '2022-10-26 02:31:58', '2022-10-26 02:31:58'),
(207, 75, 8, 'xuat', 295000, 1, '2022-10-28 08:26:34', '2022-10-28 08:26:34'),
(208, 75, 8, 'nhap', 206500, 1, '2022-10-28 08:27:35', '2022-10-28 08:27:35'),
(209, 76, 8, 'nhap', 200200, 1, '2022-10-28 08:28:00', '2022-10-28 08:28:00'),
(210, 76, 8, 'xuat', 286000, 1, '2022-10-28 08:28:23', '2022-10-28 08:28:23'),
(211, 77, 8, 'nhap', 206500, 1, '2022-10-28 08:28:49', '2022-10-28 08:28:49'),
(212, 77, 8, 'xuat', 295000, 1, '2022-10-28 08:29:14', '2022-10-28 08:29:14'),
(213, 78, 8, 'nhap', 207200, 1, '2022-10-28 08:30:09', '2022-10-28 08:30:09'),
(214, 78, 8, 'xuat', 296000, 1, '2022-10-28 08:30:32', '2022-10-28 08:30:32'),
(215, 79, 8, 'nhap', 207200, 1, '2022-10-28 08:30:52', '2022-10-28 08:30:52'),
(216, 79, 8, 'xuat', 296000, 1, '2022-10-28 08:31:12', '2022-10-28 08:31:12'),
(217, 80, 8, 'nhap', 197400, 1, '2022-10-28 09:44:59', '2022-10-28 09:44:59'),
(218, 73, 8, 'xuat', 282000, 1, '2022-10-28 09:45:18', '2022-10-28 09:45:18'),
(219, 81, 8, 'nhap', 200200, 1, '2022-10-28 09:45:37', '2022-10-28 09:45:37'),
(220, 81, 8, 'xuat', 286000, 1, '2022-10-28 09:45:57', '2022-10-28 09:45:57'),
(221, 82, 8, 'nhap', 172200, 1, '2022-10-28 09:51:02', '2022-10-28 09:51:02'),
(222, 82, 8, 'xuat', 246000, 1, '2022-10-28 09:51:21', '2022-10-28 09:51:21'),
(223, 83, 8, 'nhap', 164500, 1, '2022-10-28 22:53:37', '2022-10-28 22:53:37'),
(224, 83, 8, 'xuat', 235000, 1, '2022-10-28 22:53:57', '2022-10-28 22:53:57'),
(225, 84, 8, 'nhap', 199500, 1, '2022-10-28 22:54:35', '2022-10-28 22:54:35'),
(226, 84, 8, 'xuat', 285000, 1, '2022-10-28 22:55:04', '2022-10-28 22:55:04'),
(227, 85, 8, 'nhap', 310000, 1, '2022-10-28 22:56:29', '2022-10-28 22:56:29'),
(228, 85, 8, 'xuat', 370000, 1, '2022-10-28 22:56:47', '2022-10-28 22:56:47'),
(229, 86, 8, 'nhap', 105000, 1, '2022-10-28 22:57:29', '2022-10-28 22:57:29'),
(230, 87, 8, 'nhap', 59500, 1, '2022-10-28 22:58:47', '2022-10-28 22:58:47'),
(231, 87, 8, 'xuat', 85000, 1, '2022-10-28 22:59:09', '2022-10-28 22:59:09'),
(232, 88, 8, 'nhap', 49000, 1, '2022-10-28 23:00:22', '2022-10-28 23:00:22'),
(233, 88, 8, 'xuat', 70000, 1, '2022-10-28 23:00:43', '2022-10-28 23:00:43'),
(234, 89, 8, 'nhap', 84000, 1, '2022-10-28 23:01:43', '2022-10-28 23:01:43'),
(235, 89, 8, 'xuat', 120000, 1, '2022-10-28 23:02:03', '2022-10-28 23:02:03'),
(236, 90, 8, 'nhap', 154000, 1, '2022-10-28 23:02:30', '2022-10-28 23:02:30'),
(237, 90, 8, 'xuat', 220000, 1, '2022-10-28 23:02:49', '2022-10-28 23:02:49'),
(238, 91, 8, 'nhap', 126000, 1, '2022-10-28 23:03:10', '2022-10-28 23:03:10'),
(239, 91, 8, 'xuat', 180000, 1, '2022-10-28 23:03:29', '2022-10-28 23:03:29'),
(240, 92, 8, 'nhap', 54600, 1, '2022-10-28 23:04:30', '2022-10-28 23:04:30'),
(241, 92, 8, 'xuat', 78000, 1, '2022-10-28 23:04:56', '2022-10-28 23:04:56'),
(242, 93, 8, 'nhap', 42000, 1, '2022-10-28 23:05:19', '2022-10-28 23:05:19'),
(243, 93, 8, 'xuat', 60000, 1, '2022-10-28 23:05:38', '2022-10-28 23:05:38'),
(244, 94, 8, 'nhap', 84000, 1, '2022-10-28 23:05:55', '2022-10-28 23:05:55'),
(245, 94, 8, 'xuat', 120000, 1, '2022-10-28 23:06:14', '2022-10-28 23:06:14'),
(246, 95, 8, 'nhap', 101500, 1, '2022-10-28 23:06:00', '2022-12-20 07:31:31'),
(247, 95, 8, 'xuat', 145000, 1, '2022-10-28 23:06:00', '2022-12-20 07:31:13'),
(248, 96, 8, 'nhap', 138600, 1, '2022-10-28 23:08:03', '2022-10-28 23:08:03'),
(249, 96, 8, 'xuat', 198000, 1, '2022-10-28 23:08:19', '2022-10-28 23:08:19'),
(250, 97, 8, 'xuat', 225000, 1, '2022-10-28 23:08:40', '2022-10-28 23:08:40'),
(251, 97, 8, 'nhap', 157500, 1, '2022-10-28 23:09:19', '2022-10-28 23:09:19'),
(252, 98, 1, 'nhap', 10400, 1, '2022-10-31 23:08:53', '2022-10-31 23:08:53'),
(253, 98, 1, 'xuat', 13000, 1, '2022-10-31 23:09:09', '2022-10-31 23:09:09'),
(254, 99, 1, 'nhap', 7200, 1, '2022-10-31 23:09:29', '2022-10-31 23:09:29'),
(255, 99, 1, 'xuat', 9000, 1, '2022-10-31 23:09:44', '2022-10-31 23:09:44'),
(256, 10, 4, 'nhap', 560000, 1, '2022-11-09 02:18:56', '2022-11-09 02:18:56'),
(257, 80, 8, 'xuat', 282000, 1, '2022-11-18 07:05:41', '2022-11-18 07:05:41'),
(258, 74, 8, 'nhap', 330000, 1, '2022-11-18 07:07:54', '2022-11-18 07:07:54'),
(259, 74, 8, 'xuat', 395000, 1, '2022-11-18 07:08:19', '2022-11-18 07:08:19'),
(260, 100, 1, 'nhap', 23000, 1, '2022-12-09 08:26:25', '2022-12-09 08:26:25'),
(261, 100, 1, 'xuat', 40000, 1, '2022-12-09 08:26:55', '2022-12-09 08:26:55'),
(262, 101, 1, 'nhap', 23000, 1, '2022-12-09 08:27:15', '2022-12-09 08:27:15'),
(263, 101, 1, 'xuat', 35000, 1, '2022-12-09 08:27:35', '2022-12-09 08:27:35'),
(264, 102, 1, 'nhap', 200000, 1, '2023-02-09 01:05:06', '2023-02-09 01:05:06'),
(265, 102, 1, 'xuat', 300000, 1, '2023-02-09 01:05:28', '2023-02-09 01:05:28'),
(266, 102, 4, 'nhap', 230000, 1, '2023-02-09 01:08:57', '2023-02-09 01:08:57'),
(267, 102, 4, 'xuat', 300000, 1, '2023-02-09 01:09:20', '2023-02-09 01:09:20'),
(268, 103, 1, 'nhap', 7200, 1, '2023-02-14 10:01:37', '2023-02-14 10:01:37'),
(269, 103, 1, 'xuat', 9000, 1, '2023-02-14 10:01:54', '2023-02-14 10:01:54');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(1024) NOT NULL,
  `image` varchar(1024) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `campain_id` int(10) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`id`, `name`, `image`, `brand_id`, `campain_id`, `created_at`, `updated_at`) VALUES
(3, 'leankid 14', NULL, 1, 1, '2022-08-20 09:08:00', '2022-08-20 09:09:47'),
(4, 'leankid 19', NULL, 1, 1, '2022-08-20 09:09:35', '2022-08-23 02:43:30'),
(5, 'Leankid 24', NULL, 1, 1, '2022-08-20 09:10:03', '2022-08-21 21:54:28'),
(6, 'Leankid 29', NULL, 1, 1, '2022-08-20 09:10:20', '2022-08-22 09:38:39'),
(7, 'Kid BA4', NULL, 1, 1, '2022-08-20 09:10:42', '2022-08-20 09:10:42'),
(8, 'Kid BA9', NULL, 1, 1, '2022-08-20 09:10:55', '2022-08-26 01:40:47'),
(9, 'Colostrum 4', NULL, 1, 1, '2022-08-20 09:11:17', '2022-08-22 09:52:52'),
(10, 'colostrum 9', NULL, 1, 1, '2022-08-20 09:11:33', '2022-08-23 02:40:52'),
(11, 'Bone 4', NULL, 1, 1, '2022-08-20 09:11:54', '2022-08-22 09:38:39'),
(12, 'Bone 9', NULL, 1, 1, '2022-08-20 09:12:12', '2022-08-20 09:12:12'),
(13, 'Leanmax adult hộp (Le)', NULL, 1, 1, '2022-08-20 09:12:00', '2022-08-22 09:12:58'),
(14, 'Leanmax adult 4 (Le)', NULL, 1, 1, '2022-08-20 09:13:17', '2022-08-26 01:40:47'),
(15, 'Leanmax adult 9 (le)', NULL, 1, 1, '2022-08-20 09:13:36', '2022-08-23 03:34:22'),
(16, 'Hope hộp', NULL, 1, 1, '2022-08-20 09:14:14', '2022-08-22 09:12:59'),
(17, 'Hope 4', NULL, 1, 1, '2022-08-20 09:14:29', '2022-08-23 02:40:52'),
(18, 'hope 9', NULL, 1, 1, '2022-08-20 09:15:10', '2022-08-23 02:46:08'),
(19, 'pro hope 4', NULL, 1, 1, '2022-08-20 09:15:34', '2022-08-20 09:15:34'),
(20, 'pro hope 9', NULL, 1, 1, '2022-08-20 09:15:48', '2022-08-23 03:34:22'),
(21, 'Ligos hộp', NULL, 1, 1, '2022-08-20 09:16:10', '2022-08-22 09:41:48'),
(22, 'Ligos 4', NULL, 1, 1, '2022-08-20 09:16:25', '2022-08-26 01:40:47'),
(23, 'Ligos 9', NULL, 1, 1, '2022-08-20 09:16:40', '2022-08-26 01:40:47'),
(24, 'mom 4', NULL, 1, 1, '2022-08-20 09:17:14', '2022-08-22 09:38:39'),
(25, 'mom 9', NULL, 1, 1, '2022-08-20 09:17:27', '2022-08-20 09:17:27'),
(26, 'Rena 1 gold 4', NULL, 1, 1, '2022-08-20 09:17:47', '2022-08-22 09:38:39'),
(27, 'Rena 1 gold 9', NULL, 1, 1, '2022-08-20 09:18:02', '2022-08-22 09:25:52'),
(28, 'Rena 1 hộp', NULL, 1, 1, '2022-08-20 09:18:22', '2022-08-20 09:18:22'),
(29, 'rena 2 gold 4', NULL, 1, 1, '2022-08-20 09:18:42', '2022-08-26 01:40:47'),
(30, 'peptizer', NULL, 1, 1, '2022-08-20 09:19:06', '2022-08-26 01:40:47'),
(31, 'pro 10+ 4', NULL, 1, 1, '2022-08-20 09:20:05', '2022-08-22 09:12:59'),
(32, 'pro 10+ 9', NULL, 1, 1, '2022-08-20 09:20:20', '2022-08-22 09:52:52'),
(33, 'thyro  hộp', NULL, 1, 1, '2022-08-20 09:20:50', '2022-08-20 09:20:50'),
(34, 'thyro 4', NULL, 1, 1, '2022-08-20 09:21:07', '2022-08-23 02:40:52'),
(35, 'thyro 9', NULL, 1, 1, '2022-08-20 09:21:19', '2022-08-23 03:34:22'),
(36, 'thyro lid hộp', NULL, 1, 1, '2022-08-20 09:21:00', '2022-08-20 09:22:16'),
(37, 'thyro lid 4', NULL, 1, 1, '2022-08-20 09:22:07', '2022-08-20 09:22:07'),
(38, 'thyro lid 9', NULL, 1, 1, '2022-08-20 09:22:44', '2022-08-23 02:36:55'),
(39, 'metamax adult 4 (MTMA4)', NULL, 1, 1, '2022-08-20 09:23:16', '2022-08-23 02:42:23'),
(40, 'Metamax adult 9 (MTMA9)', NULL, 1, 1, '2022-08-20 09:23:40', '2022-08-26 01:40:47'),
(41, 'Metamax hộp', NULL, 1, 1, '2022-08-20 09:24:00', '2022-08-23 02:40:52'),
(42, 'cerna hộp', NULL, 1, 1, '2022-08-20 09:24:17', '2022-08-22 09:38:39'),
(43, 'cerna 4', NULL, 1, 1, '2022-08-20 09:24:30', '2022-08-23 02:39:01'),
(44, 'cerna 9', NULL, 1, 1, '2022-08-20 09:24:46', '2022-08-26 01:40:47'),
(45, 'peptizer hộp mẫu', NULL, 1, 1, '2022-08-22 09:44:00', '2022-08-28 19:29:51'),
(46, 'peptamen', NULL, 2, 1, '2022-08-28 19:50:19', '2022-08-28 19:50:19'),
(47, 'fohepta', NULL, 3, 1, '2022-09-02 01:10:01', '2022-09-02 01:10:01'),
(48, 'gluvita 400g', NULL, 3, 1, '2022-09-02 01:10:24', '2022-09-02 01:10:24'),
(49, 'santebaby 400g', NULL, 3, 1, '2022-09-02 01:10:38', '2022-09-02 01:10:38'),
(50, 'santekid 400g', NULL, 3, 1, '2022-09-02 01:11:00', '2022-09-02 01:55:06'),
(51, 'nepro 1 gold', NULL, 3, 1, '2022-09-02 01:12:40', '2022-09-02 01:12:40'),
(52, 'nepro 2 gold', NULL, 3, 1, '2022-09-02 01:12:52', '2022-09-02 01:12:52'),
(53, 'premium mom 400g', NULL, 3, 1, '2022-09-02 01:13:17', '2022-09-02 01:13:17'),
(54, 'aminoleban oral', NULL, 5, 1, '2022-09-02 01:13:31', '2022-09-02 01:13:31'),
(55, 'ensure advance (EPA) 220ml', NULL, 4, 1, '2022-09-02 01:14:01', '2022-09-02 01:14:01'),
(56, 'deli soup', NULL, 6, 1, '2022-09-02 01:14:33', '2022-09-02 01:14:33'),
(57, 'basic soup', NULL, 6, 1, '2022-09-02 01:14:43', '2022-09-02 01:14:43'),
(58, 'fomeal care', NULL, 6, 1, '2022-09-02 01:14:55', '2022-09-02 01:14:55'),
(59, 'navie cerna', NULL, 6, 1, '2022-09-02 01:15:05', '2022-09-02 01:15:05'),
(60, 'navie nepro 1', NULL, 6, 1, '2022-09-02 01:15:20', '2022-09-02 01:15:20'),
(61, 'navie nepro 2', NULL, 6, 1, '2022-09-02 01:15:30', '2022-09-02 01:15:30'),
(62, 'fomeal', NULL, 6, 1, '2022-09-02 01:15:40', '2022-09-02 01:15:40'),
(63, 'leankid 12', NULL, 1, 1, '2022-09-02 02:34:07', '2022-09-02 02:34:07'),
(64, 'BA gói', NULL, 1, 1, '2022-09-02 02:38:14', '2022-09-02 02:38:14'),
(65, 'premium mumcare 900g', NULL, 3, 1, '2022-09-04 19:01:18', '2022-09-04 19:01:18'),
(66, 'infant 1+', NULL, 3, 1, '2022-09-04 19:01:35', '2022-09-04 19:01:35'),
(67, 'santebaby 800g', NULL, 3, 1, '2022-09-04 19:01:00', '2022-09-04 19:05:10'),
(68, 'vital 200ml', NULL, 4, 1, '2022-09-04 19:05:51', '2022-09-04 19:05:51'),
(69, 'ensure gold 400g', NULL, 4, 1, '2022-09-04 19:06:29', '2022-09-04 19:06:29'),
(70, 'glucerna 400g', NULL, 4, 1, '2022-09-04 19:06:40', '2022-09-04 19:06:40'),
(71, 'metamax adult gói mẫu (MTMA gói mẫu)', NULL, 1, 1, '2022-09-23 01:53:42', '2022-09-23 01:53:42'),
(72, 'novofer drop', NULL, 7, 1, '2022-10-26 01:35:38', '2022-10-26 01:35:38'),
(73, 'immuno glucan C', NULL, 7, 1, '2022-10-26 01:35:58', '2022-10-26 01:35:58'),
(74, 'immune support', NULL, 7, 1, '2022-10-26 01:36:19', '2022-10-26 01:36:19'),
(75, 'Healthy Plex D3K2 10 ml  (D3: 400UI)', NULL, 7, 1, '2022-10-28 07:59:00', '2022-10-28 08:02:03'),
(76, 'D3 bone 15ml,  (D3: 400IU, K2 12mcg)', NULL, 7, 1, '2022-10-28 07:59:00', '2022-10-28 08:02:39'),
(77, 'iroc (Fe 30mg/2ml, C, folic)', NULL, 7, 1, '2022-10-28 08:01:11', '2022-10-28 08:01:11'),
(78, 'novofer drops 30ml (sắt 10mg/1ml, folic 5mcg, C 10mg, B2, B12)', NULL, 7, 1, '2022-10-28 08:03:00', '2022-10-28 08:05:05'),
(79, 'Bone Cal 100ml (ca: 500mg, D3: 200IU, K2: 10mcg)', NULL, 7, 1, '2022-10-28 08:04:38', '2022-10-28 08:04:38'),
(80, 'Imunoglucan C 100ml ( C 80mg, beta glucan 60mg)', NULL, 7, 1, '2022-10-28 08:05:48', '2022-10-28 08:05:48'),
(81, 'Zinc plex 100ml (Zinc 15mg, lysin 10mg, se 27mcg)', NULL, 7, 1, '2022-10-28 08:06:34', '2022-10-28 08:06:34'),
(82, 'D3 omega DHA 10ml (D3 400IU, DHA 1mg)', NULL, 7, 1, '2022-10-28 08:07:21', '2022-10-28 08:07:21'),
(83, 'Pactol Kids Petit 150ml (sữa ong chúa., các vit B> ăn ngon)', NULL, 7, 1, '2022-10-28 08:08:35', '2022-10-28 08:08:35'),
(84, 'calkamin 30v (ca 500mg, mg 4mg, K2 25mcg, D3 200iu)', NULL, 7, 1, '2022-10-28 08:09:59', '2022-10-28 08:09:59'),
(85, 'Ginkgo Biloba 120v (tăng tuần hoàn máu)', NULL, 7, 1, '2022-10-28 08:11:17', '2022-10-28 08:11:17'),
(86, 'Dona 30 gói  (lysin, sữa non, thymomodulin, tinh chất men bia tươi, canxinano, men tiêu hoá', NULL, 7, 1, '2022-10-28 08:13:40', '2022-10-28 08:13:40'),
(87, 'canxi tảo biển (100mg canxi, 57mg Magie, D3 100Iu, K2 20mcg)', NULL, 7, 1, '2022-10-28 08:15:24', '2022-10-28 08:15:24'),
(88, 'Supvid 3 (200.000 IU D3)', NULL, 7, 1, '2022-10-28 08:15:59', '2022-10-28 08:15:59'),
(89, 'infogos 30 gói (inuline 900mg, fos 900mg, galacto 900mg)', NULL, 7, 1, '2022-10-28 08:16:00', '2022-10-28 08:18:25'),
(90, 'Olym gold 20 gói (men tiêu hoá)', NULL, 7, 1, '2022-10-28 08:17:00', '2022-10-28 08:18:38'),
(91, 'entero medi  20 ống (3 chủng men vi sinh, 4 tỷ lợi khuẩn)', NULL, 7, 1, '2022-10-28 08:17:00', '2022-10-28 08:18:08'),
(92, 'Donacolex 120ml (chất xơ, 18 vit và ck)', NULL, 7, 1, '2022-10-28 08:19:40', '2022-10-28 08:19:40'),
(93, 'syrup zinc 150ml (kẽm)', NULL, 7, 1, '2022-10-28 08:20:12', '2022-10-28 08:20:12'),
(94, 'Lacdokid MD 20 ống ( glutathione, thymomoduline, beta glucan, kẽm, fos, B1, B5, B6)', NULL, 7, 1, '2022-10-28 08:21:19', '2022-10-28 08:21:19'),
(95, 'Donazin  20 ống (arginin, lysine, GABA, pepsin, kẽm, B1, B2, B6, B12)', NULL, 7, 1, '2022-10-28 08:22:18', '2022-10-28 08:22:18'),
(96, 'Dona colostrum 20 gói (colostrum, tính chất men bia, lysine, canxi, taurine, các vit B, kẽm, DHA)', NULL, 7, 1, '2022-10-28 08:23:33', '2022-10-28 08:23:33'),
(97, 'Coldagen gold 60v (chống lão hoá, cải thiện nội tiết)', NULL, 7, 1, '2022-10-28 08:24:49', '2022-10-28 08:24:49'),
(98, 'BA 180ml', NULL, 1, 1, '2022-10-31 23:07:38', '2022-10-31 23:07:38'),
(99, 'BA 110ml', NULL, 1, 1, '2022-10-31 23:08:00', '2022-10-31 23:08:00'),
(100, 'MTMA gói mẫu', NULL, 1, 1, '2022-12-09 08:25:41', '2022-12-09 08:25:41'),
(101, 'ligos gói jmẫu', NULL, 1, 1, '2022-12-09 08:25:52', '2022-12-09 08:25:52'),
(102, 'canxi star', NULL, 1, 1, '2023-02-09 01:04:33', '2023-02-09 01:04:33'),
(103, 'leankid BA 110ml', NULL, 1, 1, '2023-02-14 10:01:06', '2023-02-14 10:01:06');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `roles`
--

INSERT INTO `roles` (`id`, `name`, `display_name`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'Administrator', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(2, 'user', 'Normal User', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(3, 'Guest', 'Guest', '2022-08-23 01:06:21', '2022-08-23 01:06:21'),
(4, 'Kho', 'Kho', '2022-08-29 02:20:01', '2022-08-29 02:20:01'),
(5, 'export', 'Xuất', '2022-08-29 02:20:18', '2022-09-02 05:16:28');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `settings`
--

CREATE TABLE `settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `details` text DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  `group` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `settings`
--

INSERT INTO `settings` (`id`, `key`, `display_name`, `value`, `details`, `type`, `order`, `group`) VALUES
(1, 'site.title', 'Site Title', 'Site Title', '', 'text', 1, 'Site'),
(2, 'site.description', 'Site Description', 'Site Description', '', 'text', 2, 'Site'),
(3, 'site.logo', 'Site Logo', '', '', 'image', 3, 'Site'),
(4, 'site.google_analytics_tracking_id', 'Google Analytics Tracking ID', '', '', 'text', 4, 'Site'),
(5, 'admin.bg_image', 'Admin Background Image', '', '', 'image', 5, 'Admin'),
(6, 'admin.title', 'Admin Title', 'Voyager', '', 'text', 1, 'Admin'),
(7, 'admin.description', 'Admin Description', 'Welcome to Voyager. The Missing Admin for Laravel', '', 'text', 2, 'Admin'),
(8, 'admin.loader', 'Admin Loader', '', '', 'image', 3, 'Admin'),
(9, 'admin.icon_image', 'Admin Icon Image', '', '', 'image', 4, 'Admin'),
(10, 'admin.google_analytics_client_id', 'Google Analytics Client ID (used for admin dashboard)', '', '', 'text', 1, 'Admin');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `translations`
--

CREATE TABLE `translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `table_name` varchar(255) NOT NULL,
  `column_name` varchar(255) NOT NULL,
  `foreign_key` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `translations`
--

INSERT INTO `translations` (`id`, `table_name`, `column_name`, `foreign_key`, `locale`, `value`, `created_at`, `updated_at`) VALUES
(1, 'data_types', 'display_name_singular', 5, 'pt', 'Post', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(2, 'data_types', 'display_name_singular', 6, 'pt', 'Página', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(3, 'data_types', 'display_name_singular', 1, 'pt', 'Utilizador', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(4, 'data_types', 'display_name_singular', 4, 'pt', 'Categoria', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(5, 'data_types', 'display_name_singular', 2, 'pt', 'Menu', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(6, 'data_types', 'display_name_singular', 3, 'pt', 'Função', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(7, 'data_types', 'display_name_plural', 5, 'pt', 'Posts', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(8, 'data_types', 'display_name_plural', 6, 'pt', 'Páginas', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(9, 'data_types', 'display_name_plural', 1, 'pt', 'Utilizadores', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(10, 'data_types', 'display_name_plural', 4, 'pt', 'Categorias', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(11, 'data_types', 'display_name_plural', 2, 'pt', 'Menus', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(12, 'data_types', 'display_name_plural', 3, 'pt', 'Funções', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(13, 'categories', 'slug', 1, 'pt', 'categoria-1', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(14, 'categories', 'name', 1, 'pt', 'Categoria 1', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(15, 'categories', 'slug', 2, 'pt', 'categoria-2', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(16, 'categories', 'name', 2, 'pt', 'Categoria 2', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(17, 'pages', 'title', 1, 'pt', 'Olá Mundo', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(18, 'pages', 'slug', 1, 'pt', 'ola-mundo', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(19, 'pages', 'body', 1, 'pt', '<p>Olá Mundo. Scallywag grog swab Cat o\'nine tails scuttle rigging hardtack cable nipper Yellow Jack. Handsomely spirits knave lad killick landlubber or just lubber deadlights chantey pinnace crack Jennys tea cup. Provost long clothes black spot Yellow Jack bilged on her anchor league lateen sail case shot lee tackle.</p>\r\n<p>Ballast spirits fluke topmast me quarterdeck schooner landlubber or just lubber gabion belaying pin. Pinnace stern galleon starboard warp carouser to go on account dance the hempen jig jolly boat measured fer yer chains. Man-of-war fire in the hole nipperkin handsomely doubloon barkadeer Brethren of the Coast gibbet driver squiffy.</p>', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(20, 'menu_items', 'title', 1, 'pt', 'Painel de Controle', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(21, 'menu_items', 'title', 2, 'pt', 'Media', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(22, 'menu_items', 'title', 12, 'pt', 'Publicações', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(23, 'menu_items', 'title', 3, 'pt', 'Utilizadores', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(24, 'menu_items', 'title', 11, 'pt', 'Categorias', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(25, 'menu_items', 'title', 13, 'pt', 'Páginas', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(26, 'menu_items', 'title', 4, 'pt', 'Funções', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(27, 'menu_items', 'title', 5, 'pt', 'Ferramentas', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(28, 'menu_items', 'title', 6, 'pt', 'Menus', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(29, 'menu_items', 'title', 7, 'pt', 'Base de dados', '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(30, 'menu_items', 'title', 10, 'pt', 'Configurações', '2022-08-19 20:05:03', '2022-08-19 20:05:03');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `avatar` varchar(255) DEFAULT 'users/default.png',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `campain_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `role_id`, `name`, `email`, `avatar`, `email_verified_at`, `password`, `remember_token`, `settings`, `warehouse_id`, `campain_id`, `created_at`, `updated_at`) VALUES
(1, 1, 'Admin', 'admin@admin.com', 'users/default.png', NULL, '$2y$10$L1rN6drLFrtoH8DPWc3r/.fmRvHkGNuxv63r0TKgbfmYhB04Voc/S', '46m45EZuG0Jrk88F4vsA09lNT8e6hB5EfOSHrlZctbpUrJtxeIHM2g0dSHWZ', NULL, NULL, NULL, '2022-08-19 20:05:03', '2022-08-19 20:05:03'),
(2, 1, 'Quốc Đạt', 'qdatvirgo@gmail.com', 'users/default.png', NULL, '$2y$10$U0YhtTn/L50UZr15qxJuX.59Wtv5qrJsAo3H3miEhfOZwol8UZ36.', NULL, '{\"locale\":\"en\"}', 1, 1, '2022-08-20 07:22:48', '2022-09-04 19:34:44'),
(3, 2, 'Thơm', 'kissytb@gmail.com', 'users/default.png', NULL, '$2y$10$C6fH0pcI.TbIsctrYRmVGuVpgQOjD8upB.wqbKhg.YBfZY5fXtXuC', NULL, '{\"locale\":\"en\"}', 1, 1, '2022-08-23 01:05:23', '2022-09-06 07:52:42'),
(4, 4, 'Guest', 'guest@gmail.com', 'users/default.png', NULL, '$2y$10$KtzvOnYEX4Ww.xZTdb8cTOVqqIMwZpboarVLWlXSLkoK9YeJR0wLy', NULL, '{\"locale\":\"en\"}', 1, 1, '2022-08-23 01:07:02', '2022-09-02 08:50:38'),
(5, 5, 'Bạch Mai', 'bachmai@gmail.com', 'users/default.png', NULL, '$2y$10$IlLJLn0PnGEQskWgi5bM0ukQs9dSLQVqfRYNhoyTSEhLeZw4gIAQC', NULL, '{\"locale\":\"en\"}', 1, 1, '2022-09-02 06:48:01', '2022-09-02 08:50:47');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user_roles`
--

CREATE TABLE `user_roles` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `user_roles`
--

INSERT INTO `user_roles` (`user_id`, `role_id`) VALUES
(2, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `warehouse`
--

CREATE TABLE `warehouse` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(1024) NOT NULL,
  `campain_id` int(10) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `warehouse`
--

INSERT INTO `warehouse` (`id`, `name`, `campain_id`, `created_at`, `updated_at`) VALUES
(1, 'Chính', 1, '2022-08-25 02:49:18', '2022-08-25 02:49:18'),
(2, 'PK Tâm An', 1, '2022-08-25 02:49:26', '2022-08-25 02:49:26'),
(3, 'Canteen', 1, '2022-08-27 06:30:55', '2022-08-27 06:30:55'),
(4, 'Hằng- thanh hoá', 1, '2022-09-04 18:48:02', '2022-09-04 18:48:02'),
(5, 'Nga- vitadaily', 1, '2022-09-04 18:48:38', '2022-09-04 18:48:38'),
(6, 'Nga- Abbott', 1, '2022-09-04 19:08:24', '2022-09-04 19:08:24'),
(7, 'cháo orgalife', 1, '2022-09-04 19:54:03', '2022-09-04 19:54:03'),
(8, 'thuốc', 1, '2022-10-28 08:26:04', '2022-10-28 08:26:04'),
(9, 'vietcom', 1, '2022-11-18 07:01:44', '2022-11-18 07:01:44');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `campain`
--
ALTER TABLE `campain`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_slug_unique` (`slug`),
  ADD KEY `categories_parent_id_foreign` (`parent_id`);

--
-- Chỉ mục cho bảng `data_rows`
--
ALTER TABLE `data_rows`
  ADD PRIMARY KEY (`id`),
  ADD KEY `data_rows_data_type_id_foreign` (`data_type_id`);

--
-- Chỉ mục cho bảng `data_types`
--
ALTER TABLE `data_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `data_types_name_unique` (`name`),
  ADD UNIQUE KEY `data_types_slug_unique` (`slug`);

--
-- Chỉ mục cho bảng `debts`
--
ALTER TABLE `debts`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `discount`
--
ALTER TABLE `discount`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `exports`
--
ALTER TABLE `exports`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Chỉ mục cho bảng `imports`
--
ALTER TABLE `imports`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `menus_name_unique` (`name`);

--
-- Chỉ mục cho bảng `menu_items`
--
ALTER TABLE `menu_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `menu_items_menu_id_foreign` (`menu_id`);

--
-- Chỉ mục cho bảng `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pages_slug_unique` (`slug`);

--
-- Chỉ mục cho bảng `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Chỉ mục cho bảng `pay`
--
ALTER TABLE `pay`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `permissions_key_index` (`key`);

--
-- Chỉ mục cho bảng `permission_role`
--
ALTER TABLE `permission_role`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `permission_role_permission_id_index` (`permission_id`),
  ADD KEY `permission_role_role_id_index` (`role_id`);

--
-- Chỉ mục cho bảng `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Chỉ mục cho bảng `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `posts_slug_unique` (`slug`);

--
-- Chỉ mục cho bảng `prb_log_activity`
--
ALTER TABLE `prb_log_activity`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `price`
--
ALTER TABLE `price`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_unique` (`name`);

--
-- Chỉ mục cho bảng `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `settings_key_unique` (`key`);

--
-- Chỉ mục cho bảng `translations`
--
ALTER TABLE `translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `translations_table_name_column_name_foreign_key_locale_unique` (`table_name`,`column_name`,`foreign_key`,`locale`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_role_id_foreign` (`role_id`);

--
-- Chỉ mục cho bảng `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `user_roles_user_id_index` (`user_id`),
  ADD KEY `user_roles_role_id_index` (`role_id`);

--
-- Chỉ mục cho bảng `warehouse`
--
ALTER TABLE `warehouse`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `campain`
--
ALTER TABLE `campain`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `data_rows`
--
ALTER TABLE `data_rows`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=156;

--
-- AUTO_INCREMENT cho bảng `data_types`
--
ALTER TABLE `data_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT cho bảng `debts`
--
ALTER TABLE `debts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;

--
-- AUTO_INCREMENT cho bảng `discount`
--
ALTER TABLE `discount`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `exports`
--
ALTER TABLE `exports`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT cho bảng `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `imports`
--
ALTER TABLE `imports`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=337;

--
-- AUTO_INCREMENT cho bảng `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `menu_items`
--
ALTER TABLE `menu_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT cho bảng `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT cho bảng `pages`
--
ALTER TABLE `pages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `pay`
--
ALTER TABLE `pay`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=358;

--
-- AUTO_INCREMENT cho bảng `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;

--
-- AUTO_INCREMENT cho bảng `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `prb_log_activity`
--
ALTER TABLE `prb_log_activity`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `price`
--
ALTER TABLE `price`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=270;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT cho bảng `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `translations`
--
ALTER TABLE `translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `warehouse`
--
ALTER TABLE `warehouse`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `data_rows`
--
ALTER TABLE `data_rows`
  ADD CONSTRAINT `data_rows_data_type_id_foreign` FOREIGN KEY (`data_type_id`) REFERENCES `data_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `menu_items`
--
ALTER TABLE `menu_items`
  ADD CONSTRAINT `menu_items_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `permission_role`
--
ALTER TABLE `permission_role`
  ADD CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

--
-- Các ràng buộc cho bảng `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `user_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_roles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
