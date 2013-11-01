-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1
-- Время создания: Окт 30 2013 г., 16:23
-- Версия сервера: 5.5.25
-- Версия PHP: 5.3.13

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `hr_db`
--

-- --------------------------------------------------------

--
-- Структура таблицы `positions`
--

CREATE TABLE IF NOT EXISTS `positions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `skills` varchar(50) NOT NULL DEFAULT 'Junior',
  `description` varchar(255) DEFAULT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Positions list' AUTO_INCREMENT=37 ;

--
-- Дамп данных таблицы `positions`
--

INSERT INTO `positions` (`id`, `name`, `skills`, `description`, `date`) VALUES
(2, 'Грузчик', 'trainee', 'Наемный грузчик (неполная занятость)', '2013-10-30 10:00:00'),
(3, 'Грузчик', 'junior', 'грузчик склада', '2013-10-30 10:00:00'),
(4, 'Грузчик', 'senior', 'Старший грузчик', '2013-10-30 10:00:00'),
(5, 'Грузчик', 'intermediate', 'Старший грузчик склада', '2013-10-30 10:00:00'),
(6, 'Помощник логиста', 'intermediate', 'Должность для помощника логиста', '2013-10-30 10:00:00'),
(7, 'Начальник логистики', 'senior', 'Начальник отдела логистики', '2013-10-30 10:00:00'),
(13, 'Дворник', 'junior', 'Дворник на склад', '2013-10-30 10:00:00'),
(32, 'Менеджер по закупкам', 'junior', 'Для отдела логистики (младший менеджер)', '2013-10-30 11:15:45'),
(33, 'Test 1', 'junior', 'Test record 1', '2013-10-30 13:20:53'),
(34, 'Test 2', 'junior', 'test 2', '2013-10-30 13:21:27');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
