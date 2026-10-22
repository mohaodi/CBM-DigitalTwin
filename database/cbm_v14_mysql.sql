CREATE DATABASE IF NOT EXISTS cbm_twin DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE cbm_twin;

CREATE TABLE IF NOT EXISTS borehole (
  id BIGINT PRIMARY KEY AUTO_INCREMENT, code VARCHAR(32) UNIQUE NOT NULL,
  name VARCHAR(128) NOT NULL, spacing_m DOUBLE NOT NULL, inclination_deg DOUBLE NOT NULL,
  azimuth_deg DOUBLE NOT NULL, length_m DOUBLE NOT NULL, enabled TINYINT DEFAULT 1
);
CREATE TABLE IF NOT EXISTS sensor_reading (
  id BIGINT PRIMARY KEY AUTO_INCREMENT, recorded_at VARCHAR(64) NOT NULL,
  borehole_code VARCHAR(32) NOT NULL, source_type VARCHAR(32) NOT NULL,
  negative_pressure_kpa DOUBLE NOT NULL, methane_pct DOUBLE NOT NULL,
  mixed_flow_m3_min DOUBLE NOT NULL, pure_flow_m3_min DOUBLE NOT NULL,
  reservoir_pressure_mpa DOUBLE NOT NULL, temperature_c DOUBLE NOT NULL,
  valve_open_pct DOUBLE NOT NULL, pump_power_kw DOUBLE NOT NULL,
  lifecycle_stage VARCHAR(16) NOT NULL, quality_flag VARCHAR(32) NOT NULL,
  INDEX idx_sensor_time(recorded_at), INDEX idx_sensor_well_time(borehole_code, recorded_at)
);
CREATE TABLE IF NOT EXISTS extraction_scheme (
  id BIGINT PRIMARY KEY AUTO_INCREMENT, scheme_code VARCHAR(64) UNIQUE NOT NULL,
  created_at VARCHAR(64) NOT NULL, lifecycle_stage VARCHAR(16) NOT NULL,
  source_model VARCHAR(255) NOT NULL, target_json JSON NOT NULL,
  parameters_json JSON NOT NULL, metrics_json JSON NOT NULL,
  status VARCHAR(32) NOT NULL, approved TINYINT DEFAULT 0
);
CREATE TABLE IF NOT EXISTS scheme_borehole (
  id BIGINT PRIMARY KEY AUTO_INCREMENT, scheme_code VARCHAR(64) NOT NULL,
  borehole_code VARCHAR(32) NOT NULL, inclination_deg DOUBLE NOT NULL,
  azimuth_deg DOUBLE NOT NULL, spacing_m DOUBLE NOT NULL, length_m DOUBLE NOT NULL,
  extraction_pressure_kpa DOUBLE NOT NULL, start_x DOUBLE NOT NULL, start_y DOUBLE NOT NULL,
  start_z DOUBLE NOT NULL, end_x DOUBLE NOT NULL, end_y DOUBLE NOT NULL, end_z DOUBLE NOT NULL
);
CREATE TABLE IF NOT EXISTS alarm_event (
  id BIGINT PRIMARY KEY AUTO_INCREMENT, created_at VARCHAR(64) NOT NULL,
  borehole_code VARCHAR(32), level VARCHAR(16) NOT NULL, alarm_type VARCHAR(64) NOT NULL,
  message VARCHAR(500) NOT NULL, status VARCHAR(16) NOT NULL
);
CREATE TABLE IF NOT EXISTS control_advice (
  id BIGINT PRIMARY KEY AUTO_INCREMENT, created_at VARCHAR(64) NOT NULL,
  lifecycle_stage VARCHAR(16) NOT NULL, source VARCHAR(64) NOT NULL,
  advice_json JSON NOT NULL, safety_checked TINYINT NOT NULL,
  execution_status VARCHAR(32) NOT NULL
);
CREATE TABLE IF NOT EXISTS assessment_record (
  id BIGINT PRIMARY KEY AUTO_INCREMENT, created_at VARCHAR(64) NOT NULL,
  lifecycle_stage VARCHAR(16) NOT NULL, score DOUBLE NOT NULL,
  compliant TINYINT NOT NULL, details_json JSON NOT NULL
);
CREATE TABLE IF NOT EXISTS simulation_task (
  id BIGINT PRIMARY KEY AUTO_INCREMENT, model_id VARCHAR(128) NOT NULL,
  negative_pressure_kpa DOUBLE NOT NULL, days INT NOT NULL,
  engine VARCHAR(64) NOT NULL, result_json JSON NOT NULL, create_time VARCHAR(64) NOT NULL
);
