create database models;
use models;

CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Conversations (
    conversation_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ended_at TIMESTAMP NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE Messages (
    message_id INT PRIMARY KEY AUTO_INCREMENT,
    conversation_id INT,
    sender ENUM('User', 'Chatbot') NOT NULL,
    message_text TEXT NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (conversation_id) REFERENCES Conversations(conversation_id) ON DELETE CASCADE
);

CREATE TABLE QueryPatterns (
    pattern_id INT PRIMARY KEY AUTO_INCREMENT,
    query_text TEXT NOT NULL,
    occurrence_count INT DEFAULT 1,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY (query_text(255)) -- Indexing first 255 characters of TEXT column
);


CREATE TABLE ChatbotResponses (
    response_id INT PRIMARY KEY AUTO_INCREMENT,
    pattern_id INT NOT NULL,  -- Ensuring it is NOT NULL
    response_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (pattern_id) REFERENCES QueryPatterns(pattern_id) ON DELETE CASCADE
) ENGINE=InnoDB;  -- Ensure foreign key support


CREATE TABLE AIModelIntegration (
    model_id INT PRIMARY KEY AUTO_INCREMENT,
    model_name VARCHAR(255) NOT NULL,
    version VARCHAR(50) NOT NULL,
    deployed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO Users (username, email) VALUES
('krishna', 'krishna@example.com'),
('kashyap', 'kashyap@example.com'),
('piyush', 'piyush@example.com'),
('aniket', 'aniket@example.com'),
('prasad', 'prasad@example.com');

INSERT INTO Conversations (user_id, started_at, ended_at) VALUES
(1, NOW(), NOW()),
(2, NOW(), NOW()),
(3, NOW(), NOW()),
(4, NOW(), NULL),
(5, NOW(), NULL);

INSERT INTO Messages (conversation_id, sender, message_text) VALUES
(1, 'User', 'Hello! How can I reset my password?'),
(1, 'Chatbot', 'You can reset it via the settings page.'),
(2, 'User', 'What are your working hours?'),
(2, 'Chatbot', 'We are available 24/7.'),
(3, 'User', 'Can you help me with my order status?');

INSERT INTO QueryPatterns (query_text, occurrence_count) VALUES
('How to reset my password?', 10),
('What are your working hours?', 7),
('Can you help me with my order?', 5),
('What is the refund policy?', 8),
('How do I contact support?', 6);

INSERT INTO ChatbotResponses (pattern_id, response_text) VALUES
(1, 'To reset your password, go to settings and click "Reset Password".'),
(2, 'Our chatbot is available 24/7 to assist you.'),
(3, 'Please provide your order ID, and I will check the status for you.'),
(4, 'Our refund policy allows returns within 30 days of purchase.'),
(5, 'You can contact support via email at support@example.com.');

INSERT INTO AIModelIntegration (model_name, version) VALUES
('ChatGPT-4', '4.0.1'),
('BERT', '1.2.0'),
('DialogFlow', '3.0.5'),
('Rasa', '2.1.0'),
('IBM Watson', '1.5.3');

SELECT * FROM Users;
SELECT * FROM Conversations;
SELECT * FROM Messages;
SELECT * FROM QueryPatterns;
SELECT * FROM ChatbotResponses;
SELECT * FROM AIModelIntegration;