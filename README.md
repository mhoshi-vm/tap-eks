# Generate Self-Signed Certificate

```
mkdir cert; cd cert
openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 \
  -nodes -keyout tappoc.com.key -out tappoc.com.crt -subj "/CN=tappoc.com" \
  -addext "subjectAltName=DNS:tappoc.com,DNS:*.tappoc.com"
```


# Build image

```
docker build -t ghcr.io/mhoshi-vm/tap-eks-lc:latest .
```



