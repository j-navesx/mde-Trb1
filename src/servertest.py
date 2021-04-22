from http.server import BaseHTTPRequestHandler, HTTPServer
import sys
import os
import cx_Oracle
import time
import json
import cgi
import testcode

hostName = "localhost"
serverPort = 9000

def get_querrys(sqlfile):
    parsed_querries = []
    parent_dir = __file__.strip("src\servertest.py") + '\querrys/'
    for root, dirs, files in os.walk(parent_dir):
        if sqlfile in files:
            directory = root+"/"+sqlfile
            with open(directory) as file:
                querries = file.read()
                querries = querries.split(';')
                querries_copy = list(querries)
                for querry in querries_copy:
                    q = querry.splitlines()
                    q_copy = list(q)
                    for line in q_copy:
                        if line.startswith('--') or line.startswith('\n--'):
                            q.remove(line);
                    q = ''.join(map(str,q))
                    parsed_querries.append(q)
                parsed_querries.remove('')
         
    return parsed_querries

class MyServer(BaseHTTPRequestHandler):
    def _set_headers(self):
        self.send_response(200)
        self.send_header('Content-type', 'application/json')
        self.end_headers()

    def do_GET(self):
        self._set_headers()
        self.wfile.write(bytes(json.dumps({'hello': 'world', 'received': 'ok'}), encoding='utf8'))
        testcode.outsidePrint()
        length = 0
        try:
            length = int(self.headers['Content-Length'])
        except:
            pass
        if length:
            message = json.loads(self.rfile.read(length))
            print(message)
        else:
            print("No Body")


if __name__ == "__main__":
    if(len(sys.argv) > 1):
        try:
            assert len(sys.argv) == 4
        
        except AssertionError:
            print("\nInsufficient number of arguments\n")
            exit()
        
        webServer = HTTPServer((hostName, serverPort), MyServer)
        username = sys.argv[2]
        password = sys.argv[3]
        #username = "mde_trb1"
        #password = "mde"
        
        try:
            connectstr = username+"/"+password+"@//localhost:1521/xe"
            conn = cx_Oracle.connect(connectstr)
        
        except cx_Oracle.DatabaseError:
            print("\nDATABASE ERROR: Username/Password not correct.\n")
            exit()
        
        print("\nConnected to the database")
        print("Server started http://%s:%s\n" % (hostName, serverPort))
        
        cursor = conn.cursor()
        test_querrys = get_querrys("drop_all.sql")
        #print(test_querrys)
        results = []
        for querry in test_querrys:
            try:
                cursor.execute(querry)
                results.append(cursor.fetchall())
            except cx_Oracle.DatabaseError:
                print("\n\nERROR\n\n",querry)
            except cx_Oracle.InterfaceError:
                pass
        print(results)
        try:
            webServer.serve_forever()
        except KeyboardInterrupt:
            pass

        webServer.server_close()
        print("Server stopped.")
    
    else:
        print("\nNo arguments detected\n")
        print("Use option -s to start database or -r to resume database\n")
        print("After the option insert username and password to the database\n")