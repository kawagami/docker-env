-- Add up migration script here

CREATE TABLE blogs (
    id UUID PRIMARY KEY,
    markdown TEXT NOT NULL,
    html TEXT NOT NULL,
    tags TEXT[] DEFAULT '{}'::TEXT[], 
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
