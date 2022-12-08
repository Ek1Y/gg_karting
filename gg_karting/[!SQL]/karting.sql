INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES ('zeton', 'Zeton', -1, 0, 1); -- Limit

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('zeton', 'Zeton', -1, 0, 1); -- Weight

INSERT INTO `addon_account` (name, label, shared) VALUES 
  ('society_karting','Karting',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
  ('society_karting','Karting',1)
;

INSERT INTO `jobs` (`name`, `label`) VALUES
  ('karting', 'Karting')
;


INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
  ('karting', 0, 'novi', 'Novi', 0, '{}', '{}'),
  ('karting', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
  ('karting', 2, 'zamenik', 'Zamenik Sefa', 0, '{}', '{}'),
  ('karting', 3, 'boss', 'Sef', 0, '{}', '{}');