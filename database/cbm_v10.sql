CREATE DATABASE IF NOT EXISTS cbm_twin DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE cbm_twin;

CREATE TABLE IF NOT EXISTS simulation_task (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    model_id VARCHAR(128) NOT NULL,
    negative_pressure_kpa DOUBLE NOT NULL,
    days INT NOT NULL,
    engine VARCHAR(64) NOT NULL,
    result_json JSON NOT NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_simulation_time (create_time),
    INDEX idx_simulation_model (model_id)
);
