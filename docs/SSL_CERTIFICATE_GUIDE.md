# SSL Certificate Configuration Guide

This guide helps you configure SSL certificates for the RAG Research Agent project.

## Quick Start

### Development Environment

For development, you can quickly disable SSL verification:

```bash
export NODE_TLS_REJECT_UNAUTHORIZED=0
npm run dev
```

⚠️ **Warning**: Never use this in production!

### Production Environment

For production, properly configure SSL certificates:

```bash
# Set custom CA certificate
export NODE_EXTRA_CA_CERTS=/path/to/ca-bundle.crt

# Or set certificate directory
export SSL_CERT_DIR=/path/to/certificates/
```

## Troubleshooting

### Run SSL Diagnostic

```bash
npm run diagnose:ssl https://arxiv.org
```

This will test the SSL connection and provide recommendations.

### Common Issues

#### 1. Corporate Proxy

If you're behind a corporate proxy:

```bash
export HTTP_PROXY=http://proxy.company.com:8080
export HTTPS_PROXY=http://proxy.company.com:8080

# With authentication
export HTTP_PROXY=http://username:password@proxy.company.com:8080
```

#### 2. Self-Signed Certificates

For self-signed certificates:

1. Export the certificate:
   ```bash
   openssl s_client -connect server:443 -showcerts < /dev/null | \
     openssl x509 -outform PEM > server.crt
   ```

2. Add to your certificate store:
   ```bash
   export NODE_EXTRA_CA_CERTS=server.crt
   ```

#### 3. Corporate CA Certificates

Many corporations use internal CAs. To add them:

1. **macOS**:
   ```bash
   security find-certificate -a -p /System/Library/Keychains/SystemRootCertificates.keychain > ca-bundle.crt
   security find-certificate -a -p /Library/Keychains/System.keychain >> ca-bundle.crt
   export NODE_EXTRA_CA_CERTS=ca-bundle.crt
   ```

2. **Linux**:
   ```bash
   export NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt
   ```

3. **Windows**:
   ```powershell
   $env:NODE_EXTRA_CA_CERTS = "C:\path\to\ca-bundle.crt"
   ```

## Configuration Options

The HTTP client supports the following environment variables:

| Variable | Description | Example |
|----------|-------------|---------|
| `NODE_TLS_REJECT_UNAUTHORIZED` | Disable SSL verification (dev only) | `0` |
| `NODE_EXTRA_CA_CERTS` | Path to CA certificate bundle | `/path/to/ca-bundle.crt` |
| `SSL_CERT_FILE` | Alternative CA certificate path | `/path/to/cert.pem` |
| `SSL_CERT_DIR` | Directory containing certificates | `/path/to/certs/` |
| `HTTP_PROXY` | HTTP proxy URL | `http://proxy:8080` |
| `HTTPS_PROXY` | HTTPS proxy URL | `https://proxy:8443` |
| `REQUEST_TIMEOUT` | Request timeout in milliseconds | `30000` |

## Programmatic Configuration

You can also configure SSL certificates programmatically:

```typescript
import { HttpClient } from './src/utils/httpClient';
import fs from 'fs';

const client = new HttpClient({
  ca: fs.readFileSync('/path/to/ca-bundle.crt'),
  rejectUnauthorized: true,
  timeout: 60000,
  proxy: {
    host: 'proxy.company.com',
    port: 8080,
    auth: {
      username: 'user',
      password: 'pass'
    }
  }
});
```

## Best Practices

1. **Never disable SSL verification in production**
2. **Use proper CA certificates from your organization**
3. **Store certificates securely**
4. **Rotate certificates before expiry**
5. **Monitor certificate expiration dates**

## Certificate Formats

The HTTP client supports:
- `.crt` - Certificate files
- `.pem` - PEM encoded certificates
- `.ca` - Certificate authority files

## Need Help?

If you continue to have SSL issues:

1. Run the diagnostic tool: `npm run diagnose:ssl`
2. Check your corporate IT documentation
3. Verify proxy settings
4. Ensure certificates are not expired 