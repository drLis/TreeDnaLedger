from brownie import *

def main():
	return accounts[0].deploy(TreeDnaLedger)