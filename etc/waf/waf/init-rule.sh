#!/bin/bash
mkdir modsec custom

wget https://raw.githubusercontent.com/SpiderLabs/ModSecurity/v3/master/modsecurity.conf-recommended -o modsec/modsecurity.conf

wget https://raw.githubusercontent.com/SpiderLabs/ModSecurity/v3/master/unicode.mapping -o modsec/unicode.mapping

wget https://github.com/coreruleset/coreruleset/archive/refs/tags/v3.3.4.tar.gz -o crs3.tar.gz && tar -xzvf crs3.tar.gz && rm -rf crs3.tar.gz
cp coreruleset-3.3.4/crs-setup.conf.example coreruleset-3.3.4/crs-setup.conf
