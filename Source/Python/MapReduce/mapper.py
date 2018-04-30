#!/usr/bin/env python
"""mapper.py"""

import json
import sys

# each line is a single variant from a variant batch file 
for line in sys.stdin:
    variant = json.loads(line)
    
    # perform any filtering here
    if variant.p_value < 0.5:
        print(line)
        
        
        