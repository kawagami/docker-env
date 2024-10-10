-- Add down migration script here
DROP INDEX IF EXISTS idx_chat_user_id;

DROP TABLE IF EXISTS chat;

