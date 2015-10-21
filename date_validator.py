#!/usr/bin/python
"""date_validator.py
Checks MASKS formats
"""

import sys
import time

MASKS = ['%Y%m%d','%Y-%m-%d','%d%m%Y','%m%d%Y']
 
def check_format(datec):
    for mask in MASKS:
        try:
            time.strptime(datec, mask)
            break
        except:
            raise Exception('Mask not found for: {0}'.format(datec))     
    return mask


def main():
    print 'Mask {0} valid for parsed date.'.format(check_format(sys.argv[1]))


if __name__=="__main__":
    main()