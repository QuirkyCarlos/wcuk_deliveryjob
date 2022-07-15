CREATE TABLE `deliveryjob` (
  `identifier` varchar(100) CHARACTER SET latin1 NOT NULL,
  `companyID` int(11) NOT NULL,
  `name` varchar(100) CHARACTER SET latin1 NOT NULL DEFAULT 'Bezorg Bedrijf',
  `level` int(11) NOT NULL DEFAULT 0,
  `certificate` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;