-- Add up migration script here
CREATE TABLE chat(
    id serial PRIMARY KEY,
    user_id int NOT NULL,
    message text NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_chat_user_id ON chat(user_id);

