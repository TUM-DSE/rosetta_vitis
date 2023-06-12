CXX=g++
CFLAGS=-O0 -g
MINIZIP_LDFLAGS=-lminizip -laes -lz
LDFLAGS=$(MINIZIP_LDFLAGS)

AR=ar rcs
