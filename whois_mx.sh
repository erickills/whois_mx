# Author: erickills@githhub

#!/bin/bash

clear

# Script header
cat << EOF
A simple bash script for WHOIS information and Email Server Verification (MX Records)
Author: Ericson Santiago (erickills)
EOF

echo

# Prompt for domain
read -p "Insert or paste domain (ctrl+v on key): " the_domain



# Check if the domain exists
if ! host "$the_domain" &> /dev/null; then
    echo "Error: Domain $the_domain not found."
    exit 1
fi


# WHOIS lookup
cat << EOF


$(whois_output=$(whois $the_domain 2>/dev/null)
if [ $? -eq 0 ]; then
    echo "$whois_output" | grep -E 'Creation Date:|Updated Date:|Registrant|Reseller|Registrar:'
else
    echo "WHOIS lookup failed for $the_domain"
fi)

EOF


# MX record lookup
mx_output=$(dig $the_domain mx +short 2>/dev/null)
if [ -n "$mx_output" ]; then
    mx_count=$(echo "$mx_output" | wc -l)
    echo "Number of MX records found: $mx_count"
    echo "$mx_output"
else
    echo "No MX records found for $the_domain"
fi
