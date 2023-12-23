## Deploy a sample 2 tier application on cloud
I planned to create a simple API. It is really useful for tourist to know about the bus routes and bus details. The bus routes and bus details can be added by the government incharge.

First, I created mysql database in AWS RDS Dashboard and I connected the mysql in my system

```bash
mysql -h awsmysqlendpoint -u username -p
```
Then, I create the api code in flask
```python
import pymysql
from flask import Flask, jsonify, request

host = 'awsendpoint'
user = ''
password = ''
database = ''
port = 3306

connection = pymysql.connect(host = host, port = port, user = user, password = password, database = database)
cursor = connection.cursor()


app = Flask(__name__)

@app.route('/add', methods=['POST'])
def add():
    try:
        _json = request.json
        _busno = _json['busno']
        _startpoint = _json['startpoint']
        _endpoint = _json['endpoint']
        sqlQuery = "INSERT INTO details(bus_no, start_point, end_point) VALUES(%s, %s, %s)"
        bindData = (_busno, _startpoint, _endpoint)
        cursor.execute(sqlQuery, bindData)
        connection.commit()
        response = jsonify({'response':'bus details added successfully!'})
        response.status_code = 200
        return response
    except Exception as e:
        print(e)

@app.route('/update', methods=['PUT'])
def update():
    try:
        _json = request.json
        _busno = _json['busno']
        _start = _json['startpoint']
        _end = _json['endpoint']
        sqlQuery = "update details set start_point=%s, end_point=%s where bus_no=%s"
        bindData = (_start, _end, _busno)
        cursor.execute(sqlQuery, bindData)
        connection.commit()
        response = jsonify({'response':'bus details updated successfully!'})
        return response
    except Exception as e:
        print(e)

@app.route('/get', methods=['GET'])
def get():
    try:
        _json = request.json
        _busno = _json['busno']
        sqlQuery = "select * from details where bus_no=%s"
        bindData = (_busno, )
        cursor.execute(sqlQuery, bindData)
        connection.commit()
        ret = cursor.fetchall()
        response = jsonify({'busno' : ret[0][0], 'startpoint' : ret[0][1], 'endpoint' : ret[0][2]})
        return response
    except Exception as e:
        print(e)

@app.route('/delete', methods=['DELETE'])
def delete():
    try:
        _json = request.json
        _busno = _json['busno']
        sqlQuery = "delete from details where bus_no=%s"
        bindData = (_busno)
        cursor.execute(sqlQuery, bindData)
        connection.commit()
        response = jsonify({'response' : 'bus detail deleted successfully'})
        return response
    except Exception as e:
        print(e)

@app.route('/')
def home():
    return "Hello World"

if __name__=="__main__":
    app.run(debug=True,port=8000)

```
After that, I created an EC2 instance in AWS. And copy my api code using scp command and store it on my EC2 instance.
Then I created a service and run the api code in my instance.
```service
[Unit]
Description=My API Service

[Service]
WorkingDirectory=/home/ubuntu/Project/
User=ubuntu
ExecStart=/usr/bin/python3 /home/ubuntu/Project/api.py

[Install]
WantedBy=multi-user.target
```
And I Install the caddy server in my EC2 instance. And do the reverse proxy if the request is come from the 80 port it is forward the request to port 8000 in the EC2 instance.
```caddyfile
:80 {
        reverse_proxy localhost:8000
}
```
This is the database I connected to my api. Then, I test the API in curl.

First I tested the GET method in curl
```bash
curl -X GET -H 'Content-type: application/json' -d '{"busno" : "70"}' 3.109.209.131/get
```
Then I tested the POST method in curl
```bash
curl -X POST -H 'Content-type: application/json' -d '{"busno" : "20", "startpoint" : "Sulur", "endpoint" : "Singanallur"}' 3.109.209.131/add
```
Then I tested the PUT method in curl
```bash
curl -X PUT -H 'Content-type: application/json' -d '{"busno" : "20", "startpoint" : "Sulur", "endpoint" : "Gandhipuram"}' 3.109.209.131/update
```
Then I tested the DELETE method in curl
```bash
curl -X DELETE -H 'Content-type: application/json' -d '{"busno" : "23"}' 3.109.209.131/delete
```
