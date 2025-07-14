import { createVectorQueryTool } from '@mastra/rag';
import { openai } from '@ai-sdk/openai';

const vectorQueryTool = createVectorQueryTool({
  vectorStoreName: 'pgVector',
  indexName: 'papers',
  model: openai.embedding('text-embedding-3-small'),
});
