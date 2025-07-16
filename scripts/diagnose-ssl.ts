#!/usr/bin/env node

import https from 'https';
import { Agent } from 'https';

async function testSSLConnection(url: string) {
    try {
        const agent = new Agent({
            rejectUnauthorized: false // For testing only
        });

        const response = await fetch(url, { 
            agent: agent as any
        });
        
        console.log('Connection successful!');
        console.log('Response status:', response.status);
        return true;
    } catch (error) {
        console.error('Connection failed:', error);
        return false;
    }
}

async function main() {
    const testUrl = 'https://arxiv.org/html/1706.03762';
    console.log('Testing SSL connection to:', testUrl);
    
    // Test with default settings
    console.log('\nTesting with default SSL settings...');
    await testSSLConnection(testUrl);
    
    // Test with SSL verification disabled
    console.log('\nTesting with SSL verification disabled...');
    process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0';
    await testSSLConnection(testUrl);
}

main().catch(console.error); 