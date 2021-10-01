#!/bin/sh
cd $RENEWED_LINEAGE
cat fullchain.pem >agent.pem
cat privkey.pem >>agent.pem
cat bc2025.pem >cafile.pem
cat dstroot.pem >>cafile.pem
cat cert.pem >>cafile.pem
