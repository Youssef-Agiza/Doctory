-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema HealthRecordsDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema HealthRecordsDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `HealthRecordsDB` ;
USE `HealthRecordsDB` ;

-- -----------------------------------------------------
-- Table `HealthRecordsDB`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HealthRecordsDB`.`user` ;

CREATE TABLE IF NOT EXISTS `HealthRecordsDB`.`user` (
  `id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `mname` VARCHAR(255) NOT NULL,
  `lname` VARCHAR(255) NOT NULL,
  `phone` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NULL,
  `address` VARCHAR(255) NULL,
  `birthdate` DATETIME NULL,
  `password` VARCHAR(125) NOT NULL,
  `passwordChangedAt` DATETIME NULL,
  `passwordResetToken` VARCHAR(125) NULL,
  `passwordResetTokenExpiry` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthRecordsDB`.`role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HealthRecordsDB`.`role` ;

CREATE TABLE IF NOT EXISTS `HealthRecordsDB`.`role` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `privileges` VARCHAR(225) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthRecordsDB`.`appointments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HealthRecordsDB`.`appointments` ;

CREATE TABLE IF NOT EXISTS `HealthRecordsDB`.`appointments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `appointment_date` DATE NOT NULL,
  `appointment_from` TIME NOT NULL,
  `appointment_to` TIME NOT NULL,
  `dr_national_id` INT NOT NULL,
  `patient_national_id` INT NOT NULL,
  PRIMARY KEY (`id`, `dr_national_id`, `patient_national_id`),
  INDEX `fk_appointments_user1_idx` (`dr_national_id` ASC) VISIBLE,
  INDEX `fk_appointments_user2_idx` (`patient_national_id` ASC) VISIBLE,
  CONSTRAINT `fk_appointments_user1`
    FOREIGN KEY (`dr_national_id`)
    REFERENCES `HealthRecordsDB`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_appointments_user2`
    FOREIGN KEY (`patient_national_id`)
    REFERENCES `HealthRecordsDB`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthRecordsDB`.`record_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HealthRecordsDB`.`record_type` ;

CREATE TABLE IF NOT EXISTS `HealthRecordsDB`.`record_type` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthRecordsDB`.`record`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HealthRecordsDB`.`record` ;

CREATE TABLE IF NOT EXISTS `HealthRecordsDB`.`record` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `description` LONGTEXT NULL,
  `appointments_id` INT NOT NULL,
  `record_type_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_record_appointments1_idx` (`appointments_id` ASC) VISIBLE,
  INDEX `fk_record_record_type1_idx` (`record_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_record_appointments1`
    FOREIGN KEY (`appointments_id`)
    REFERENCES `HealthRecordsDB`.`appointments` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_record_record_type1`
    FOREIGN KEY (`record_type_id`)
    REFERENCES `HealthRecordsDB`.`record_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthRecordsDB`.`record_file`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HealthRecordsDB`.`record_file` ;

CREATE TABLE IF NOT EXISTS `HealthRecordsDB`.`record_file` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `path` VARCHAR(255) NOT NULL,
  `record_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_record_file_record1_idx` (`record_id` ASC) VISIBLE,
  CONSTRAINT `fk_record_file_record1`
    FOREIGN KEY (`record_id`)
    REFERENCES `HealthRecordsDB`.`record` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
