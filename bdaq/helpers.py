# -*- coding: utf-8 -*-
"""
Created on Sat Feb 20 23:36:21 2016

@author: Raman
"""

def pack_bits(bools):
    """Pack sequence of bools into bits"""

    if len(bools) % 8 != 0:
        raise ValueError("list length must be multiple of 8")
    bytes_ = []
    b = 0
    for j, v in enumerate(reversed(bools)):
        b <<= 1
        b |= v
        if j % 8 == 7:
            bytes_.append(b)
            b = 0
    return bytes_
    
def unpack_bits(x):
    """convert byte x into a list of bools corresponding to bits"""
    bools = []
    while x:
        for i in range(8):
            bools.append(bool(x&1))
            x >>= 1
    return bools
    
if __name__ == '__main__':
    bools = [True, False, True, False, True, False, True, True, 
             True, False, True, False, True, False, True, True]
    print(pack_bits(bools))