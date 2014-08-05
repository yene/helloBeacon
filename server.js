var http = require('http');
var sys = require('sys')
var exec = require('child_process').exec;
var express = require('express')
var app = express()

app.get('/hi/:name', function (req, res) {
	exec("say hi " + req.params.name);
	res.send('Hi ' + req.params.name)
})

app.get('/bye/:name', function (req, res) {
	exec("say goodbye " + req.params.name, puts);
	res.send('Hi ' + req.params.name)
})

app.listen(3000)

console.log('Server running at http://127.0.0.1:3000/');