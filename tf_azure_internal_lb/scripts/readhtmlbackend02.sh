#!/bin/bash
content=$(wget http://172.16.2.11:8000 -q -O -)
echo $content
