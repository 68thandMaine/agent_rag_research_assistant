#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}Setting up PostgreSQL with pgVector for RAG Research Agent${NC}"
echo ""

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo -e "${RED}Error: Docker is not running. Please start Docker first.${NC}"
    exit 1
fi

# Check if .env file exists
if [ ! -f .env ]; then
    echo -e "${YELLOW}Warning: .env file not found.${NC}"
    echo "Creating .env file from template..."
    cat > .env << EOF
# OpenAI Configuration
OPENAI_API_KEY=your-openai-api-key-here

# PostgreSQL Configuration
POSTGRES_CONNECTION_STRING=postgresql://rag_user:rag_password@localhost:5432/rag_research_db
EOF
    echo -e "${GREEN}.env file created. Please update OPENAI_API_KEY with your actual key.${NC}"
fi

# Start PostgreSQL
echo -e "${GREEN}Starting PostgreSQL container...${NC}"
docker compose up -d

# Wait for PostgreSQL to be ready
echo -e "${GREEN}Waiting for PostgreSQL to be ready...${NC}"
MAX_ATTEMPTS=30
ATTEMPT=0

while [ $ATTEMPT -lt $MAX_ATTEMPTS ]; do
    if docker compose exec -T postgres pg_isready -U rag_user -d rag_research_db > /dev/null 2>&1; then
        echo -e "${GREEN}PostgreSQL is ready!${NC}"
        break
    fi
    echo -n "."
    sleep 1
    ATTEMPT=$((ATTEMPT + 1))
done

if [ $ATTEMPT -eq $MAX_ATTEMPTS ]; then
    echo -e "${RED}Error: PostgreSQL failed to start within 30 seconds.${NC}"
    exit 1
fi

# Verify pgVector extension
echo -e "${GREEN}Verifying pgVector extension...${NC}"
docker compose exec -T postgres psql -U rag_user -d rag_research_db -c "SELECT extname, extversion FROM pg_extension WHERE extname = 'vector';" | grep vector > /dev/null

if [ $? -eq 0 ]; then
    echo -e "${GREEN}pgVector extension is installed successfully!${NC}"
else
    echo -e "${RED}Error: pgVector extension is not installed.${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}Database setup complete!${NC}"
echo ""
echo "Connection details:"
echo "  Host: localhost"
echo "  Port: 5432"
echo "  Database: rag_research_db"
echo "  User: rag_user"
echo "  Password: rag_password"
echo ""
echo "Connection string: postgresql://rag_user:rag_password@localhost:5432/rag_research_db"
echo ""
echo -e "${YELLOW}Remember to update your .env file with your OpenAI API key!${NC}" 