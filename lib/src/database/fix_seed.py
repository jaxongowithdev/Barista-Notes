#!/usr/bin/env python3
import re

with open('content_seed.dart', 'r') as f:
    content = f.read()

# Fix apostrophes in strings
content = content.replace("'marked'", "marked")
content = content.replace("Espresso 'marked", "Espresso marked")

with open('content_seed.dart', 'w') as f:
    f.write(content)

print("Fixed apostrophe issues")
