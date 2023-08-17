#!/bin/bash
mkdir modsec custom

wget -O modsec/modsecurity.conf https://raw.githubusercontent.com/SpiderLabs/ModSecurity/v3/master/modsecurity.conf-recommended

wget -O modsec/unicode.mapping https://raw.githubusercontent.com/SpiderLabs/ModSecurity/v3/master/unicode.mapping 

wget -O crs3.tar.gz https://github.com/coreruleset/coreruleset/archive/refs/tags/v3.3.5.tar.gz  && tar -xzvf crs3.tar.gz && rm -rf crs3.tar.gz
cp coreruleset-3.3.5/crs-setup.conf.example coreruleset-3.3.5/crs-setup.conf
