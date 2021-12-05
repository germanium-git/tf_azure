#!/bin/bash
content=$(wget http://172.16.2.10:8000 -q -O -)
echo $content
