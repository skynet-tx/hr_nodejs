-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1
-- Время создания: Ноя 04 2013 г., 15:52
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
-- Структура таблицы `departments`
--

CREATE TABLE IF NOT EXISTS `departments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Table of departments list' AUTO_INCREMENT=5 ;

--
-- Дамп данных таблицы `departments`
--

INSERT INTO `departments` (`id`, `name`, `description`, `date`) VALUES
(1, 'Reserve', 'Позиции резерва', '2013-10-30 10:00:00'),
(2, 'Логистика', 'Позиции для склада и закупки', '2013-10-30 10:00:00'),
(3, 'Бухгалтерия', 'Позиции бухгалтерии', '2013-10-30 10:00:00'),
(4, 'ОПП', 'Отдел по подбору персонала', '2013-11-04 07:44:51');

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
  `department_id` int(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Positions list' AUTO_INCREMENT=58 ;

--
-- Дамп данных таблицы `positions`
--

INSERT INTO `positions` (`id`, `name`, `skills`, `description`, `date`, `department_id`) VALUES
(2, 'Грузчик', 'trainee', 'Наемный грузчик (неполная занятость)', '2013-10-30 10:00:00', 2),
(3, 'Грузчик', 'junior', 'грузчик склада', '2013-10-30 10:00:00', 3),
(4, 'Грузчик', 'senior', 'Старший грузчик', '2013-10-30 10:00:00', 2),
(5, 'Грузчик', 'intermediate', 'Старший грузчик склада', '2013-10-30 10:00:00', 2),
(6, 'Помощник логиста', 'intermediate', 'Должность для помощника логиста', '2013-10-30 10:00:00', 2),
(7, 'Начальник логистики', 'senior', 'Начальник отдела логистики', '2013-10-30 10:00:00', 2),
(13, 'Дворник', 'junior', 'Дворник на склад', '2013-10-30 10:00:00', 1),
(32, 'Менеджер по закупкам', 'junior', 'Для отдела логистики (младший менеджер)', '2013-10-30 11:15:45', 2),
(53, 'Старший менеджер по закупкам', 'intermediate', 'В отдел логистики', '2013-10-30 15:51:39', 2),
(56, 'Главный бухгалтер', 'senior', 'Общий для фирмы', '2013-11-01 10:38:32', 3);

-- --------------------------------------------------------

--
-- Структура таблицы `staff`
--

CREATE TABLE IF NOT EXISTS `staff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `surname` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `birthday` datetime NOT NULL,
  `city` varchar(50) DEFAULT NULL,
  `department_id` int(11) NOT NULL,
  `position_id` int(11) NOT NULL,
  `salary` int(11) DEFAULT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='For list of staff' AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `staff`
--

INSERT INTO `staff` (`id`, `name`, `surname`, `middle_name`, `birthday`, `city`, `department_id`, `position_id`, `salary`, `date`) VALUES
(1, 'Антон', 'Крылов', 'Олександрович', '1980-09-21 00:00:00', 'Kiev', 2, 2, 1500, '2013-10-30 10:00:00'),
(2, 'Михаил', 'Ветров', 'Сергеевич', '2000-10-30 00:00:00', 'Kiev', 2, 3, 1650, '2013-10-30 10:00:00');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
