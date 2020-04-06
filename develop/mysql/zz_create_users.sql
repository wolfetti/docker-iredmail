CREATE USER 'amavisd'@'%' IDENTIFIED BY 'amavisd';
GRANT DELETE, INSERT, SELECT, UPDATE ON `amavisd`.* TO 'amavisd'@'%';

CREATE USER 'iredadmin'@'%' IDENTIFIED BY 'iredadmin';
GRANT ALL PRIVILEGES ON `iredadmin`.* TO 'iredadmin'@'%';

CREATE USER 'iredapd'@'%' IDENTIFIED BY 'iredapd';
GRANT ALL PRIVILEGES ON `iredapd`.* TO 'iredapd'@'%';

CREATE USER 'vmail'@'%' IDENTIFIED BY 'vmail';
GRANT SELECT ON `vmail`.* TO 'vmail'@'%';

CREATE USER 'vmailadmin'@'%' IDENTIFIED BY 'vmailadmin';
GRANT DELETE, INSERT, SELECT, UPDATE ON `vmail`.* TO 'vmailadmin'@'%';

CREATE USER 'roundcube'@'%' IDENTIFIED BY 'roundcube';
GRANT ALL PRIVILEGES ON `roundcubemail`.* TO 'roundcube'@'%';
GRANT SELECT, UPDATE ON `vmail`.`mailbox` TO 'roundcube'@'%';
