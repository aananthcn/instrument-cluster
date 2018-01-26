.DEFAULT_GOAL := all

# constants
TARGET = instrument-cluster
CLASSPATH = ../../classes
MKDIR = mkdir -p
COPY = cp -r
#CC = gcc


LOCAL_IFLAGS += -I. -I${CLASSPATH}
LOCAL_CFLAGS += -Wall -g ${LOCAL_IFLAGS}
LOCAL_LFLAGS += -lEGL -lGLESv2 -lwayland-client -lwayland-egl



# objects: that is compiler outputs
#client_objects = 	Client.o \

objects = 	init_window.o


#server_objects = 	Server.o \


%.o: %.c
	$(CC) -c $(LOCAL_CFLAGS) $^ -o $@



#lc-client: ${client_objects}
#	$(CC) -o $@ $^ $(LOCAL_LFLAGS)

#lc-server: ${server_objects}
#	$(CC) -o $@ $^ $(LOCAL_LFLAGS)

${TARGET}: ${objects}
	$(CC) -o $@ $^ $(LOCAL_LFLAGS)


.PHONY: install clean


clean:
	$(RM) ${objects}
	$(RM) ${TARGET}


debug: LOCAL_CFLAGS += -g -DDEBUG
debug: LOCAL_LFLAGS += -g -DDEBUG
debug: ${TARGET}


install:
	$(MKDIR) ${DESTDIR}/usr
	$(MKDIR) ${DESTDIR}/usr/bin
	$(COPY) ./${TARGET} ${DESTDIR}/usr/bin/


all: ${TARGET}

