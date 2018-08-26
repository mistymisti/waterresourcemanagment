-- MySQL Script generated by MySQL Workbench
-- 09/03/16 16:42:00
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema clairwat_clair
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `clairwat_clair` ;

-- -----------------------------------------------------
-- Schema clairwat_clair
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `clairwat_clair` DEFAULT CHARACTER SET utf8 ;
USE `clairwat_clair` ;

-- -----------------------------------------------------
-- Table `clairwat_clair`.`company_group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clairwat_clair`.`company_group` (
  `id` VARCHAR(40) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `CREATED_TIME` DATETIME NOT NULL,
  `UPDATED_TIME` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `clairwat_clair`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clairwat_clair`.`user` (
  `id` VARCHAR(40) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `PASS` VARCHAR(100) NOT NULL,
  `GROUP_ID` VARCHAR(100) NOT NULL,
  `FIRST_NAME` VARCHAR(50) NULL DEFAULT NULL,
  `LAST_NAME` VARCHAR(50) NULL DEFAULT NULL,
  `EMAIL_ID` VARCHAR(50) NULL DEFAULT NULL,
  `CREATED_TIME` DATETIME NULL DEFAULT NULL,
  `UPDATED_TIME` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `group_ix_idx` (`GROUP_ID` ASC),
  CONSTRAINT `group_ix`
    FOREIGN KEY (`GROUP_ID`)
    REFERENCES `clairwat_clair`.`company_group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `clairwat_clair`.`element`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clairwat_clair`.`element` (
  `id` VARCHAR(40) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `units` VARCHAR(45) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `lower_limit` FLOAT NOT NULL,
  `upper_limit` FLOAT NOT NULL,
  `CREATED_TIME` DATETIME NOT NULL,
  `UPDATED_TIME` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `clairwat_clair`.`water`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clairwat_clair`.`water` (
  `id` VARCHAR(40) NOT NULL,
  `type` VARCHAR(100) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `CREATED_TIME` DATETIME NOT NULL,
  `UPDATED_TIME` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `clairwat_clair`.`water_element_association`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clairwat_clair`.`water_element_association` (
  `water_id` VARCHAR(40) NOT NULL,
  `element_id` VARCHAR(40) NOT NULL,
  `CREATED_TIME` DATETIME NOT NULL,
  `UPDATED_TIME` DATETIME NOT NULL,
  PRIMARY KEY (`water_id`, `element_id`),
  INDEX `element_ix_idx` (`element_id` ASC),
  CONSTRAINT `water_ix`
    FOREIGN KEY (`water_id`)
    REFERENCES `clairwat_clair`.`water` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `element_ix`
    FOREIGN KEY (`element_id`)
    REFERENCES `clairwat_clair`.`element` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `clairwat_clair`.`CT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clairwat_clair`.`CT` (
  `id` VARCHAR(40) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `group_id` VARCHAR(100) NULL,
  `CREATED_TIME` DATETIME NOT NULL,
  `UPDATED_TIME` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `group_id_idx` (`group_id` ASC),
  CONSTRAINT `group_id_ix`
    FOREIGN KEY (`group_id`)
    REFERENCES `clairwat_clair`.`company_group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `clairwat_clair`.`CT_water_association`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clairwat_clair`.`CT_water_association` (
  `CT_id` VARCHAR(40) NOT NULL,
  `water_id` VARCHAR(40) NOT NULL,
  `CREATED_TIME` DATETIME NOT NULL,
  `UPDATED_TIME` DATETIME NOT NULL,
  PRIMARY KEY (`CT_id`, `water_id`),
  INDEX `water_ix0_idx` (`water_id` ASC),
  CONSTRAINT `CT_ix`
    FOREIGN KEY (`CT_id`)
    REFERENCES `clairwat_clair`.`CT` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `water_ix0`
    FOREIGN KEY (`water_id`)
    REFERENCES `clairwat_clair`.`water` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `clairwat_clair`.`clair_data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clairwat_clair`.`clair_data` (
  `user_id` VARCHAR(40) NOT NULL,
  `CT_id` VARCHAR(40) NOT NULL,
  `water_id` VARCHAR(40) NOT NULL,
  `element_id` VARCHAR(40) NOT NULL,
  `element_value` FLOAT NOT NULL,
  `criteria` VARCHAR(20) NULL,
  `CREATED_TIME` DATETIME NOT NULL,
  `UPDATED_TIME` DATETIME NOT NULL,
  INDEX `water_ix0_idx` (`water_id` ASC),
  PRIMARY KEY (`user_id`, `CT_id`, `water_id`, `element_id`),
  INDEX `CT_ix00_idx` (`CT_id` ASC),
  INDEX `element_ix00_idx` (`element_id` ASC),
  CONSTRAINT `water_ix00`
    FOREIGN KEY (`water_id`)
    REFERENCES `clairwat_clair`.`water` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_ix00`
    FOREIGN KEY (`user_id`)
    REFERENCES `clairwat_clair`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CT_ix00`
    FOREIGN KEY (`CT_id`)
    REFERENCES `clairwat_clair`.`CT` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `element_ix00`
    FOREIGN KEY (`element_id`)
    REFERENCES `clairwat_clair`.`element` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
