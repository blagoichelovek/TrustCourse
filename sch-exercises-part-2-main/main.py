#!/usr/bin/python
import sys

def main():
    pay_amount = int(sys.argv[1])
    assert(pay_amount >=0)
    start_balance = 1000000
    current_balance = pay(start_balance, pay_amount)
    current_balance = pay_tax(current_balance, pay_amount)
    
def pay(balance, amount):
    assert(amount <= balance)
    balance = int(balance - amount)
    return balance
    
def pay_tax(balance, amount):
    tax = int(amount / 100) * 20
    assert(balance >= tax)
    balance -= tax
    return balance
    
main()