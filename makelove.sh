#!/bin/sh

if [ -e Ninja\ Jam.love ]; then
	rm Ninja\ Jam.love
fi

cd Ninja\ Jam
zip -r ../Ninja\ Jam.love *
