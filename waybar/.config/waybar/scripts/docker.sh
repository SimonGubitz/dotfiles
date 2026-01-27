#!/bin/bash

if systemctl is-active --quiet docker; then
	echo " "
else
	echo ""
fi
