import os
import re
import getpass
import sys

''' Set variables '''
user = getpass.getuser()
filename = 'config'

''' Change to user homedir '''
os.chdir('/home/' + user + '/.ssh/')

''' Compile the regex pattern for speed purposes. '''
patternc = re.compile(r"(^Host) (?P<server_name>\w+.*)\s")

''' Defining functions '''

def main():
   if sys.argv[1]:
       customer = sys.argv[1]
   else:
       customer = input('Write the customer name/domain')


   if filename:
       with open(filename, 'r') as fh:
           for line in fh.readlines():
               if customer in line:
                   server = re.match(patternc, line)
                   if server:
                       print(server.group('server_name'))

       fh.close()
   return 0

if __name__ == '__main__':


    main()
