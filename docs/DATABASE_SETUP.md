# PostgreSQL Database Setup

This guide will help you set up a PostgreSQL database with pgVector extension for the RAG Research Agent.

## Prerequisites

- Docker and Docker Compose installed on your system
- OpenAI API key

## Setup Instructions

### 1. Start the PostgreSQL Database

Run the following command in the project root directory:

```bash
docker compose up -d
```

This will:
- Start a PostgreSQL 16 container with pgVector extension
- Create a database named `rag_research_db`
- Set up the necessary tables and extensions
- Expose the database on port 5432

### 2. Configure Environment Variables

Create a `.env` file in the project root with the following variables:

```env
# OpenAI Configuration
OPENAI_API_KEY=your-openai-api-key-here

# PostgreSQL Configuration
POSTGRES_CONNECTION_STRING=postgresql://rag_user:rag_password@localhost:5432/rag_research_db
```

### 3. Verify Database Connection

You can verify the database is running with:

```bash
docker compose ps
```

To connect to the database directly:

```bash
docker compose exec postgres psql -U rag_user -d rag_research_db
```

### 4. Check pgVector Extension

Once connected to the database, verify pgVector is installed:

```sql
SELECT * FROM pg_extension WHERE extname = 'vector';
```

## Database Schema

The initialization script creates:

- **vectors** table: Stores embedding vectors with metadata
- **pgvector** extension: Enables vector similarity search
- Automatic timestamp updates via triggers

## Stopping the Database

To stop the database:

```bash
docker compose down
```

To stop and remove all data:

```bash
docker compose down -v
```

## Troubleshooting

### Connection Timeout

If you get connection timeout errors:
1. Ensure Docker is running
2. Check if the container is healthy: `docker compose ps`
3. Verify no other service is using port 5432

### SSL Certificate Issues

The notebook includes a workaround for SSL issues. In production, properly configure SSL certificates instead of disabling verification. 