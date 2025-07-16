-- Enable pgvector extension
CREATE EXTENSION IF NOT EXISTS vector;

-- Create a general vectors table for Mastra
CREATE TABLE IF NOT EXISTS vectors (
    id SERIAL PRIMARY KEY,
    index_name VARCHAR(255) NOT NULL,
    content_id VARCHAR(255) NOT NULL,
    vector vector,
    metadata JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(index_name, content_id)
);

-- Create an index for faster similarity searches
CREATE INDEX IF NOT EXISTS idx_vectors_index_name ON vectors(index_name);

-- Create a function to update the updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create a trigger to automatically update the updated_at column
CREATE TRIGGER update_vectors_updated_at BEFORE UPDATE ON vectors
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column(); 